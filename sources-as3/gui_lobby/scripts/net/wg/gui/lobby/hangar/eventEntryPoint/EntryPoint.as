package net.wg.gui.lobby.hangar.eventEntryPoint
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.hangar.eventEntryPoint.data.EntryPointVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EntryPoint extends EventDispatcher implements IDisposable
   {
      
      private static const _classFactory:IClassFactory = App.utils.classFactory;
      
      private static const GF_WRAPPER_PACKAGE_PREFIX:String = "net.wg.";
      
      private static const GF_WRAPPER_PACKAGE_DOT:String = ".";
      
      private static const GF_WRAPPER_PACKAGE:String = "gui.lobby.hangar.eventEntryPoint.gfWrapper.";
       
      
      private var _loader:Loader;
      
      private var _vo:EntryPointVO;
      
      private var _entryPoint:IEventEntryPoint;
      
      private var _disposed:Boolean = false;
      
      public function EntryPoint(param1:EntryPointVO)
      {
         super();
         this._vo = param1;
      }
      
      public final function dispose() : void
      {
         var _loc1_:LoaderInfo = null;
         this._disposed = true;
         this._entryPoint = null;
         this._vo = null;
         if(this._loader)
         {
            _loc1_ = this._loader.contentLoaderInfo;
            _loc1_.removeEventListener(Event.COMPLETE,this.onSwfLoadedHandler);
            _loc1_.removeEventListener(IOErrorEvent.IO_ERROR,this.onSwfLoadErrorHandler);
            this._loader.close();
            this._loader.unloadAndStop();
         }
      }
      
      public function init() : void
      {
         if(this._vo.swfPath != Values.EMPTY_STR)
         {
            this.loadSwf();
         }
         else
         {
            this.createEntry();
         }
      }
      
      private function createEntry() : void
      {
         var _loc1_:Class = _classFactory.getClass(this._vo.entryLinkage);
         if(_loc1_ == null)
         {
            _loc1_ = _classFactory.getClass(GF_WRAPPER_PACKAGE_PREFIX + (!!StringUtils.isEmpty(this._vo.extension) ? Values.EMPTY_STR : this._vo.extension + GF_WRAPPER_PACKAGE_DOT) + GF_WRAPPER_PACKAGE + this._vo.entryLinkage);
         }
         if(_loc1_)
         {
            this._entryPoint = new _loc1_();
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            DebugUtils.LOG_ERROR("Can\'t find as3 definition for " + this._vo.entryLinkage,"You should check SWF if you are using flash entryPoint with correct Linkage or if you are " + "using gameface you should create the gfWrapper class in " + "net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper with name " + this._vo.entryLinkage);
         }
      }
      
      private function loadSwf() : void
      {
         var _loc1_:Loader = new Loader();
         _loc1_.load(new URLRequest(this._vo.swfPath),new LoaderContext(false,ApplicationDomain.currentDomain));
         var _loc2_:LoaderInfo = _loc1_.contentLoaderInfo;
         _loc2_.addEventListener(Event.COMPLETE,this.onSwfLoadedHandler);
      }
      
      public function get linkage() : String
      {
         return this._vo.entryLinkage;
      }
      
      public function get entryPoint() : IEventEntryPoint
      {
         return this._entryPoint;
      }
      
      public function get entryPointDO() : DisplayObject
      {
         return DisplayObject(this._entryPoint);
      }
      
      private function onSwfLoadErrorHandler(param1:IOErrorEvent) : void
      {
         DebugUtils.LOG_ERROR(param1.text);
      }
      
      private function onSwfLoadedHandler(param1:Event) : void
      {
         this.createEntry();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
