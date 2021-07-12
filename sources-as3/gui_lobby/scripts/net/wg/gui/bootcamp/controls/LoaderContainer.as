package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LoaderContainer extends MovieClip implements IDisposable
   {
       
      
      public var loader:UILoaderAlt = null;
      
      private var _centered:Boolean = false;
      
      private var _imageWidth:int = -1;
      
      private var _imageHeight:int = -1;
      
      public function LoaderContainer()
      {
         super();
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      public final function dispose() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         this.loader.dispose();
         this.loader = null;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._imageWidth = param1;
         this._imageHeight = param2;
         this.updatePosition();
      }
      
      private function updatePosition() : void
      {
         if(this._imageWidth != Values.DEFAULT_INT)
         {
            this.loader.width = this._imageWidth;
            this.loader.height = this._imageHeight;
         }
         if(this._centered)
         {
            this.loader.x = -this.loader.width >> 1;
            this.loader.y = -this.loader.height >> 1;
         }
      }
      
      public function get centered() : Boolean
      {
         return this._centered;
      }
      
      public function set centered(param1:Boolean) : void
      {
         this._centered = param1;
         this.updatePosition();
      }
      
      public function get source() : String
      {
         return this.loader.source;
      }
      
      public function set source(param1:String) : void
      {
         this.loader.source = param1;
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updatePosition();
      }
   }
}
