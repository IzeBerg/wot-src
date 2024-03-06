package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CustomizationSheetIconAnimated extends UIComponentEx
   {
      
      private static const IMAGE_NAME:String = "image";
      
      private static const IMAGE_HOVER_NAME:String = "imageHover";
      
      private static const IMAGE_DISABLE_NAME:String = "imageDisable";
      
      private static const IMAGE_NAME_ANIMATION:String = "imageAnimation";
      
      private static const IMAGE_HOVER_NAME_ANIMATION:String = "imageHoverAnimation";
      
      private static const IMAGE_DISABLE_NAME_ANIMATION:String = "imageDisableAnimation";
      
      private static const SWITCH_STATE:String = "Switch";
      
      private static const IDLE_STATE:String = "Idle";
      
      private static const IMAGE_POSITION_X:int = -16;
      
      private static const IMAGE_POSITION_Y:int = -16;
       
      
      public var container:Sprite = null;
      
      public var containerOut:Sprite = null;
      
      private var _icon:Image = null;
      
      private var _iconHover:Image = null;
      
      private var _iconDisable:Image = null;
      
      private var _iconAnimation:Image = null;
      
      private var _iconHoverAnimation:Image = null;
      
      private var _iconDisableAnimation:Image = null;
      
      public function CustomizationSheetIconAnimated()
      {
         super();
      }
      
      private function createImage(param1:String, param2:Boolean = false) : Image
      {
         var _loc3_:Image = new Image();
         _loc3_.x = IMAGE_POSITION_X;
         _loc3_.y = IMAGE_POSITION_Y;
         _loc3_.name = param1;
         _loc3_.mouseEnabled = _loc3_.mouseChildren = false;
         if(param2)
         {
            this.containerOut.addChild(_loc3_);
         }
         else
         {
            this.container.addChild(_loc3_);
         }
         return _loc3_;
      }
      
      override protected function onDispose() : void
      {
         this._icon.dispose();
         this._icon = null;
         this._iconHover.dispose();
         this._iconHover = null;
         this._iconDisable.dispose();
         this._iconDisable = null;
         this._iconAnimation.dispose();
         this._iconAnimation = null;
         this._iconHoverAnimation.dispose();
         this._iconHoverAnimation = null;
         this._iconDisableAnimation.dispose();
         this._iconDisableAnimation = null;
         this.container = null;
         this.containerOut = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._icon = this.createImage(IMAGE_NAME);
         this._iconHover = this.createImage(IMAGE_HOVER_NAME);
         this._iconDisable = this.createImage(IMAGE_DISABLE_NAME);
         this._iconAnimation = this.createImage(IMAGE_NAME_ANIMATION,true);
         this._iconHoverAnimation = this.createImage(IMAGE_HOVER_NAME_ANIMATION,true);
         this._iconDisableAnimation = this.createImage(IMAGE_DISABLE_NAME_ANIMATION,true);
         this._iconHover.visible = false;
         this._iconDisable.visible = false;
         this._iconHoverAnimation.visible = false;
         this._iconDisableAnimation.visible = false;
      }
      
      public function setData(param1:Object, param2:Boolean, param3:Boolean) : void
      {
         if(this._icon.source != param1.iconSrc)
         {
            this._iconAnimation.source = this._icon.source;
            this._iconHoverAnimation.source = this._iconHover.source;
            this._iconDisableAnimation.source = this._iconDisable.source;
            this._icon.source = param1.iconSrc;
            this._iconHover.source = param1.iconHoverSrc;
            this._iconDisable.source = param1.iconDisableSrc;
            if(param2 && param3)
            {
               gotoAndPlay(SWITCH_STATE);
            }
            else
            {
               gotoAndPlay(IDLE_STATE);
            }
         }
      }
      
      public function switchIcon(param1:Boolean) : void
      {
         this._icon.visible = !param1 && enabled;
         this._iconHover.visible = param1 && enabled;
         this._iconDisable.visible = !enabled;
         this._iconAnimation.visible = this._icon.visible;
         this._iconHoverAnimation.visible = this._iconHover.visible;
         this._iconDisableAnimation.visible = this._iconDisable.visible;
      }
   }
}
