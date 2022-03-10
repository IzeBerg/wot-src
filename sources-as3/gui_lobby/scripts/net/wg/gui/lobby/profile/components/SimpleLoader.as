package net.wg.gui.lobby.profile.components
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getQualifiedClassName;
   import net.wg.infrastructure.events.IconLoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SimpleLoader extends Sprite implements IDisposable
   {
      
      private static const CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";
       
      
      private var _disposed:Boolean = false;
      
      private var _loader:Loader;
      
      private var _currentSourcePath:String;
      
      public function SimpleLoader()
      {
         super();
      }
      
      public function get source() : String
      {
         return this._currentSourcePath;
      }
      
      public function setSource(param1:String) : void
      {
         if(this._currentSourcePath == param1)
         {
            return;
         }
         if(this._loader)
         {
            this.unloadLoader();
         }
         this._currentSourcePath = param1;
         if(param1)
         {
            this.startLoading(param1);
         }
         else
         {
            this.clear();
         }
      }
      
      public function clear() : void
      {
         this.disposeLoader();
      }
      
      public function disposeLoader() : void
      {
         if(this._loader)
         {
            this.removeLoaderHandlers();
            this.unloadLoader();
            this._loader.parent.removeChild(this._loader);
            this._loader = null;
         }
         this._currentSourcePath = null;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.disposeLoader();
      }
      
      protected function startLoading(param1:String) : void
      {
         if(!this._loader)
         {
            this._loader = new Loader();
            this.addLoaderHandlers();
            addChild(this._loader);
         }
         this._loader.load(new URLRequest(param1));
      }
      
      protected function onLoadingComplete() : void
      {
      }
      
      protected function onLoadingError() : void
      {
      }
      
      protected function get loader() : Loader
      {
         return this._loader;
      }
      
      private function unloadLoader() : void
      {
         if(this._loader.contentLoaderInfo.contentType == CONTENT_TYPE_SWF)
         {
            this._loader.unloadAndStop(true);
         }
         else
         {
            this._loader.unload();
         }
      }
      
      private function addLoaderHandlers() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadingCompleteHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingIoErrorHandler,false,0,true);
      }
      
      private function removeLoaderHandlers() : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadingCompleteHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingIoErrorHandler);
      }
      
      private function onLoadingIoErrorHandler(param1:IOErrorEvent) : void
      {
         this.onLoadingError();
         DebugUtils.LOG_DEBUG(getQualifiedClassName(this) + " : couldn\'t load extra icon!",this._currentSourcePath);
         dispatchEvent(new IconLoaderEvent(IconLoaderEvent.ICON_LOADING_FAILED,this._loader,this._currentSourcePath));
      }
      
      private function onLoadingCompleteHandler(param1:Event) : void
      {
         this.onLoadingComplete();
         dispatchEvent(new IconLoaderEvent(IconLoaderEvent.ICON_LOADED,this._loader,this._currentSourcePath));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
