package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BackgroundComponent extends MovieClip implements IDisposable
   {
      
      private static const BG_LOADER_NAME:String = "BgLoader";
       
      
      public var vignetteMC:MovieClip = null;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _loader:Loader = null;
      
      private var _bgIsLoaded:Boolean = false;
      
      private var _baseDisposed:Boolean = false;
      
      public function BackgroundComponent()
      {
         super();
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loader.name = BG_LOADER_NAME;
         addChildAt(this._loader,0);
      }
      
      protected function onDispose() : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         if(this._bgIsLoaded)
         {
            this._loader.unload();
         }
         removeChild(this._loader);
         this._loader = null;
         this.vignetteMC = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setBackground(param1:String) : void
      {
         this._bgIsLoaded = false;
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._loader.load(_loc2_,_loc3_);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         this.resize();
         this.vignetteMC.width = param1;
         this.vignetteMC.height = param2;
      }
      
      private function resize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._bgIsLoaded)
         {
            _loc1_ = this._loader.content.width;
            _loc2_ = this._loader.content.height;
            this._loader.scaleX = this._loader.scaleY = Math.max(this._width / _loc1_,this._height / _loc2_);
            this._loader.x = this._width - this._loader.width >> 1;
            this._loader.y = this._height - this._loader.height >> 1;
         }
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         this._bgIsLoaded = true;
         this.resize();
      }
   }
}
