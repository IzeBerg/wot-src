package net.wg.app.iml.base
{
   import flash.external.ExternalInterface;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   import net.wg.infrastructure.managers.ILibrariesLoader;
   import net.wg.infrastructure.managers.impl.LibrariesLoader;
   
   public class RootApp extends BaseRootApp
   {
       
      
      private var _loader:ILibrariesLoader = null;
      
      private var _registerCallback:String = null;
      
      public function RootApp(param1:IRootAppMainContent, param2:Vector.<String>, param3:String = null)
      {
         super(param1);
         if(param3 != null && param3.length > 0)
         {
            this._registerCallback = param3;
         }
         if(param2 != null && param2.length > 0)
         {
            this._loader = new LibrariesLoader();
            this._loader.addEventListener(LibraryLoaderEvent.LOADED_COMPLETED,this.onLoaderLoadedCompletedHandler);
            this._loader.load(param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._loader != null)
         {
            this._loader.removeEventListener(LibraryLoaderEvent.LOADED_COMPLETED,this.onLoaderLoadedCompletedHandler);
            this._loader.dispose();
            this._loader = null;
         }
         super.onDispose();
      }
      
      protected function onLibsLoadingComplete() : void
      {
      }
      
      protected function callRegisterCallback() : void
      {
         if(this._registerCallback != null)
         {
            ExternalInterface.call(this._registerCallback);
         }
      }
      
      private function onLoaderLoadedCompletedHandler(param1:LibraryLoaderEvent) : void
      {
         this._loader.removeEventListener(LibraryLoaderEvent.LOADED_COMPLETED,this.onLoaderLoadedCompletedHandler);
         this.onLibsLoadingComplete();
      }
   }
}
