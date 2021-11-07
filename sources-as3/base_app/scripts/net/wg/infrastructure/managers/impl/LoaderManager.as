package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.data.daapi.ViewSettingsVO;
   import net.wg.infrastructure.base.meta.impl.LoaderManagerMeta;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import net.wg.infrastructure.events.LoaderEvent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.ILoaderManager;
   
   [Event(name="viewLoadError",type="net.wg.infrastructure.events.LoaderEvent")]
   [Event(name="viewLoaded",type="net.wg.infrastructure.events.LoaderEvent")]
   public class LoaderManager extends LoaderManagerMeta implements ILoaderManager
   {
      
      private static const DEF_VIEW_NAME:String = "main";
      
      private static const KEY_NOT_LOADER_MESSAGE:String = "Not loader try to load swf";
       
      
      private var _librariesLoaders:Dictionary = null;
      
      private var _libsList:Vector.<String> = null;
      
      private var _libsLoading:Vector.<String> = null;
      
      private var _loaderToInfo:Dictionary;
      
      private var _loaderTimerValue:Number;
      
      private var _stats:Object;
      
      public function LoaderManager()
      {
         this._stats = {};
         super();
         this._loaderToInfo = new Dictionary(true);
         this._librariesLoaders = new Dictionary();
         this._libsList = new Vector.<String>();
         this._libsLoading = new Vector.<String>();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:Loader = null;
         var _loc3_:StatsEntity = null;
         var _loc4_:LibrariesLoader = null;
         for(_loc1_ in this._loaderToInfo)
         {
            _loc2_ = _loc1_ as Loader;
            if(_loc2_)
            {
               _loc2_.close();
               _loc2_.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded);
               _loc2_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
               delete this._loaderToInfo[_loc2_];
            }
            else
            {
               assert(false,KEY_NOT_LOADER_MESSAGE);
            }
         }
         this._loaderToInfo = null;
         if(this._librariesLoaders != null)
         {
            for each(_loc4_ in this._librariesLoaders)
            {
               this.removeLibrariesLoaderListeners(_loc4_);
               _loc4_.dispose();
            }
            App.utils.data.cleanupDynamicObject(this._librariesLoaders);
            this._librariesLoaders = null;
         }
         for each(_loc3_ in this._stats)
         {
            _loc3_.dispose();
         }
         this._stats = null;
         this._libsList.splice(0,this._libsList.length);
         this._libsList = null;
         this._libsLoading.splice(0,this._libsLoading.length);
         this._libsLoading = null;
         super.onDispose();
      }
      
      override protected function loadView(param1:LoadViewVO) : void
      {
         var _loc3_:URLRequest = null;
         var _loc4_:Loader = null;
         var _loc5_:LoaderContext = null;
         this._loaderTimerValue = getTimer();
         param1.cached = App.cacheMgr && App.cacheMgr.isCached(param1.configVO.url);
         var _loc2_:ViewSettingsVO = param1.configVO;
         if(param1.cached)
         {
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING,_loc2_,param1.name);
            App.utils.scheduler.scheduleOnNextFrame(this.onSWFCached,param1);
         }
         else
         {
            _loc3_ = new URLRequest(_loc2_.url);
            _loc4_ = new Loader();
            _loc5_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            _loc4_.load(_loc3_,_loc5_);
            _loc4_.contentLoaderInfo.addEventListener(Event.INIT,this.onSWFLoaded,false,0,true);
            _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false,0,true);
            this._loaderToInfo[_loc4_] = param1;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING,_loc2_,param1.name);
         }
      }
      
      public function as_cancelLoadView(param1:String) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Loader = null;
         var _loc3_:LoadViewVO = null;
         for(_loc4_ in this._loaderToInfo)
         {
            _loc2_ = Loader(_loc4_);
            _loc3_ = this._loaderToInfo[_loc2_];
            if(param1 == _loc3_.name)
            {
               this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING_CANCEL,_loc3_.configVO,_loc3_.name);
               break;
            }
         }
      }
      
      public function getStats() : String
      {
         var _loc2_:StatsEntity = null;
         var _loc1_:String = "\nLoaderManager stats: ";
         for each(_loc2_ in this._stats)
         {
            _loc1_ += "\n\tURL:\t\t\t" + _loc2_.url;
            _loc1_ += "\n\tfrom cache:\t\t" + String(_loc2_.cached);
            _loc1_ += "\n\tLoading time ";
            _loc1_ += "\n\t\taverage:\t" + String(_loc2_.loadTime);
            _loc1_ += "\n\t\tmax:\t\t" + String(_loc2_.loadTimeMax);
            _loc1_ += "\n\tInit time ";
            _loc1_ += "\n\t\taverage:\t" + String(_loc2_.initTime);
            _loc1_ += "\n\t\tmax:\t\t" + String(_loc2_.initTimeMax);
            _loc1_ += "\n\t- - - - - - - - - - - - - - - - - - - -";
         }
         return _loc1_;
      }
      
      public function loadLibraries(param1:Vector.<String>) : void
      {
         var _loc3_:String = null;
         App.utils.asserter.assertNotNull(param1,"librariesList" + Errors.CANT_NULL);
         DebugUtils.LOG_DEBUG("LibraryLoader load:",param1);
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(_loc3_ in param1)
         {
            if(this._libsLoading.indexOf(_loc3_) == -1 && this._libsList.indexOf(_loc3_) == -1)
            {
               _loc2_.push(_loc3_);
               this._libsLoading.push(_loc3_);
            }
         }
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc4_:LibrariesLoader = new LibrariesLoader();
         this._librariesLoaders[_loc2_] = _loc4_;
         _loc4_.addEventListener(LibraryLoaderEvent.LOADED_COMPLETED,this.onLibrariesLoaderLoadedCompletedHandler);
         _loc4_.addEventListener(LibraryLoaderEvent.LOADED,this.onLibrariesLoaderLoadedHandler);
         _loc4_.addEventListener(LibraryLoaderEvent.LOADING_FAILED,this.onLibrariesLoaderLoadingFailedHandler);
         _loc4_.load(_loc2_);
      }
      
      public function stopLoadingByViewNames(param1:Array) : void
      {
         var _loc7_:* = undefined;
         var _loc2_:Loader = null;
         var _loc3_:LoadViewVO = null;
         var _loc4_:int = 0;
         var _loc5_:String = Values.EMPTY_STR;
         var _loc6_:String = Values.EMPTY_STR;
         for(_loc7_ in this._loaderToInfo)
         {
            _loc2_ = Loader(_loc7_);
            _loc3_ = this._loaderToInfo[_loc2_];
            _loc4_ = param1.indexOf(_loc3_.name);
            if(_loc4_ != -1)
            {
               param1.splice(_loc4_,1);
               _loc7_.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded,false);
               _loc7_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false);
               _loc2_.unloadAndStop(true);
               _loc5_ = _loc3_.alias;
               _loc6_ = _loc3_.name;
               _loc3_.dispose();
               delete this._loaderToInfo[_loc7_];
               viewLoadCanceledS(_loc5_,_loc6_);
            }
         }
      }
      
      private function dispatchLoaderEvent(param1:String, param2:ViewSettingsVO, param3:String, param4:IView = null) : void
      {
         dispatchEvent(new LoaderEvent(param1,param2,param3,param4));
      }
      
      private function applyViewData(param1:IView, param2:LoadViewVO, param3:Loader) : void
      {
         param1.as_config = param2;
         param1.loader = param3;
      }
      
      private function removeExtraInstances(param1:Loader) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:int = DisplayObjectContainer(param1.content).numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = DisplayObjectContainer(param1.content).getChildAt(_loc3_);
            if(_loc4_.name != DEF_VIEW_NAME)
            {
               App.utils.commons.releaseReferences(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function onSWFCached(param1:LoadViewVO) : void
      {
         var config:ViewSettingsVO = null;
         var view:IView = null;
         var viewClass:Class = null;
         var data:LoadViewVO = param1;
         config = data.configVO;
         var statsEntity:StatsEntity = this._stats[config.url];
         statsEntity.loadTime = getTimer() - this._loaderTimerValue;
         statsEntity.cached = true;
         this._loaderTimerValue = getTimer();
         try
         {
            viewClass = App.cacheMgr.getClassDef(config.url,true);
            view = IView(new viewClass());
         }
         catch(error:*)
         {
            DebugUtils.LOG_ERROR("Couldn\'t initialize cached object for " + config.url + ": \n" + error.toString());
         }
         if(view)
         {
            this.applyViewData(view,data,null);
            statsEntity.initTime = getTimer() - this._loaderTimerValue;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADED,null,"",view);
            viewLoadedS(data.alias,data.name,view);
         }
         else
         {
            viewInitializationErrorS(data.alias,data.name);
         }
         data.dispose();
      }
      
      private function removeLibrariesLoaderListeners(param1:LibrariesLoader) : void
      {
         param1.removeEventListener(LibraryLoaderEvent.LOADED_COMPLETED,this.onLibrariesLoaderLoadedCompletedHandler);
         param1.removeEventListener(LibraryLoaderEvent.LOADED,this.onLibrariesLoaderLoadedHandler);
         param1.removeEventListener(LibraryLoaderEvent.LOADING_FAILED,this.onLibrariesLoaderLoadingFailedHandler);
      }
      
      private function onLibrariesLoaderLoadedCompletedHandler(param1:LibraryLoaderEvent) : void
      {
         DebugUtils.LOG_DEBUG("Libraries loading has been completed.");
         this.removeLibrariesLoaderListeners(LibrariesLoader(param1.target));
         dispatchEvent(param1.clone());
      }
      
      private function onLibrariesLoaderLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         DebugUtils.LOG_DEBUG("Library loaded",param1.url);
         var _loc2_:String = param1.url;
         this._libsList.push(_loc2_);
         this._libsLoading.splice(this._libsLoading.indexOf(_loc2_),1);
         dispatchEvent(param1.clone());
      }
      
      private function onLibrariesLoaderLoadingFailedHandler(param1:LibraryLoaderEvent) : void
      {
         DebugUtils.LOG_DEBUG("Library load error",param1.url);
         dispatchEvent(param1.clone());
      }
      
      private function onSWFLoaded(param1:Event) : void
      {
         var loader:Loader = null;
         var event:Event = param1;
         var info:LoaderInfo = LoaderInfo(event.currentTarget);
         loader = info.loader;
         info.removeEventListener(Event.INIT,this.onSWFLoaded);
         info.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
         var data:LoadViewVO = this._loaderToInfo[loader];
         var config:ViewSettingsVO = data.configVO;
         var alias:String = data.alias;
         this._loaderTimerValue = getTimer() - this._loaderTimerValue;
         var statsEntity:StatsEntity = this._stats[config.url];
         if(!statsEntity)
         {
            statsEntity = new StatsEntity(config.url);
            this._stats[config.url] = statsEntity;
         }
         statsEntity.loadTime = this._loaderTimerValue;
         this._loaderTimerValue = getTimer();
         var view:IView = loader.content as IView;
         if(!view)
         {
            try
            {
               view = IView(loader.content[DEF_VIEW_NAME]);
               this.removeExtraInstances(loader);
            }
            catch(error:*)
            {
               DebugUtils.LOG_ERROR("Couldn\'t initialize loaded object for " + loader.contentLoaderInfo.url + ": \n" + error.toString());
            }
            App.utils.asserter.assertNotNull(view,"net.wg.infrastructure.interfaces.IView does not implemented");
         }
         data.cached = App.cacheMgr && App.cacheMgr.add(config.url,loader,App.utils.classFactory.getClass(getQualifiedClassName(view)));
         if(data.cached)
         {
            loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
         }
         if(view)
         {
            this.applyViewData(view,data,loader);
            statsEntity.initTime = getTimer() - this._loaderTimerValue;
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADED,null,"",view);
            viewLoadedS(data.alias,data.name,view);
         }
         else
         {
            viewInitializationErrorS(alias,data.name);
         }
         delete this._loaderToInfo[loader];
      }
      
      private function onSWFLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.INIT,this.onSWFLoaded);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
         var _loc3_:Loader = _loc2_.loader;
         _loc3_.unloadAndStop();
         var _loc4_:LoadViewVO = this._loaderToInfo[_loc3_];
         viewLoadErrorS(_loc4_.alias,_loc4_.name,param1.text);
         _loc4_.dispose();
         delete this._loaderToInfo[_loc3_];
         dispatchEvent(new LoaderEvent(LoaderEvent.VIEW_LOAD_ERROR,_loc4_.configVO,_loc4_.name));
      }
   }
}

class StatsEntity
{
    
   
   public var url:String;
   
   public var cached:Boolean;
   
   private var _loadTime:Number = 0;
   
   private var _loadTimeMax:Number = 0;
   
   private var _initTime:Number = 0;
   
   private var _initTimeMax:Number = 0;
   
   function StatsEntity(param1:String)
   {
      super();
      this.url = param1;
      this.cached = false;
   }
   
   public function set initTime(param1:Number) : void
   {
      this._initTimeMax = Math.max(this._initTime,param1);
      this._initTime = this._initTime > 0 ? Number(this._initTime + param1 >> 1) : Number(param1);
   }
   
   public function get initTime() : Number
   {
      return this._initTime;
   }
   
   public function get initTimeMax() : Number
   {
      return this._initTimeMax;
   }
   
   public function set loadTime(param1:Number) : void
   {
      this._loadTimeMax = Math.max(this._loadTime,param1);
      this._loadTime = this._loadTime > 0 ? Number(this._loadTime + param1 >> 1) : Number(param1);
   }
   
   public function get loadTime() : Number
   {
      return this._loadTime;
   }
   
   public function get loadTimeMax() : Number
   {
      return this._loadTimeMax;
   }
   
   public function dispose() : void
   {
      this.url = null;
   }
}
