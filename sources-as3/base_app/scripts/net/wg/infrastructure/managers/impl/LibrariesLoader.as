package net.wg.infrastructure.managers.impl
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import net.wg.infrastructure.managers.ILibrariesLoader;
   
   public class LibrariesLoader extends EventDispatcher implements ILibrariesLoader
   {
       
      
      private var _loaders:Vector.<Loader> = null;
      
      private var _librariesDict:Dictionary;
      
      private var _processedCounter:int = 0;
      
      public function LibrariesLoader()
      {
         this._librariesDict = new Dictionary();
         super();
         this._loaders = new Vector.<Loader>(0);
      }
      
      public final function dispose() : void
      {
         this.clear();
         this._loaders = null;
         App.utils.data.cleanupDynamicObject(this._librariesDict);
         this._librariesDict = null;
      }
      
      public function load(param1:Vector.<String>) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:Loader = null;
         var _loc4_:LoaderContext = null;
         var _loc5_:String = null;
         this.clear();
         if(param1.length > 0)
         {
            this._processedCounter = param1.length;
            _loc4_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            for each(_loc5_ in param1)
            {
               _loc2_ = new URLRequest(_loc5_);
               _loc3_ = new Loader();
               this.addListeners(_loc3_.contentLoaderInfo);
               _loc3_.load(_loc2_,_loc4_);
               this._librariesDict[_loc3_] = _loc5_;
               this._loaders.push(_loc3_);
            }
         }
      }
      
      private function addListeners(param1:LoaderInfo) : void
      {
         param1.addEventListener(Event.INIT,this.onLoaderInfoInitHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderInfoIoErrorHandler);
      }
      
      private function removeListeners(param1:LoaderInfo) : void
      {
         param1.removeEventListener(Event.INIT,this.onLoaderInfoInitHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderInfoIoErrorHandler);
      }
      
      private function checkLoadComplete() : void
      {
         --this._processedCounter;
         if(this._processedCounter == 0)
         {
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADED_COMPLETED));
         }
      }
      
      private function clear() : void
      {
         var _loc1_:Loader = null;
         if(this._loaders != null && this._loaders.length > 0)
         {
            for each(_loc1_ in this._loaders)
            {
               this.removeListeners(_loc1_.contentLoaderInfo);
               _loc1_.unloadAndStop(true);
            }
            this._loaders.splice(0,this._loaders.length);
         }
      }
      
      private function onLoaderInfoInitHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         var _loc3_:String = this._librariesDict[_loc2_.loader];
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADED,_loc2_.loader,_loc2_.url,_loc3_));
         this.checkLoadComplete();
      }
      
      private function onLoaderInfoIoErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         var _loc3_:String = this._librariesDict[_loc2_.loader];
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADING_FAILED,_loc2_.loader,_loc2_.url,_loc3_));
         this.checkLoadComplete();
      }
   }
}
