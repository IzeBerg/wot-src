package net.wg.gui.components.common
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ContentLoader extends Loader implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _urlRequest:URLRequest = null;
      
      private var _isInProgress:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      public function ContentLoader()
      {
         super();
      }
      
      override public function close() : void
      {
         this._isInProgress = false;
         super.close();
      }
      
      public function dispose() : void
      {
         contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded,false);
         contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false);
         this.close();
         unloadAndStop();
         this._isLoaded = false;
         this._isInProgress = false;
         this._disposed = true;
         this._urlRequest = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function loadURL(param1:String) : void
      {
         var _loc2_:LoaderContext = null;
         if(!this._urlRequest)
         {
            this._urlRequest = new URLRequest();
            _loc2_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            contentLoaderInfo.addEventListener(Event.INIT,this.onSWFLoaded,false,0,true);
            contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false,0,true);
         }
         this._isInProgress = true;
         this._urlRequest.url = param1;
         load(this._urlRequest,_loc2_);
      }
      
      public function get isInProgress() : Boolean
      {
         return this._isInProgress;
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      private function onSWFLoaded(param1:Event) : void
      {
         this._isLoaded = true;
         this._isInProgress = false;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onSWFLoadError(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
