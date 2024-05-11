package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ImageHitAreaWrapper extends UIComponentEx
   {
       
      
      public var image:Image = null;
      
      public var hitMc:Sprite = null;
      
      public function ImageHitAreaWrapper()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.image.buttonMode = true;
         this.image.mouseChildren = this.image.mouseEnabled = false;
         hitArea = this.hitMc;
      }
      
      override protected function onDispose() : void
      {
         this.image.dispose();
         this.image = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function set source(param1:String) : void
      {
         this.image.source = param1;
      }
      
      override public function get height() : Number
      {
         return this.image.height;
      }
      
      override public function get width() : Number
      {
         return this.image.width;
      }
   }
}
