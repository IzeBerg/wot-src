package net.wg.gui.components.paginator
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class PaginationPageButton extends SoundButtonEx
   {
      
      private static const INVALID_MINIMIZE:String = "invalid_minimize";
      
      private static const INVALID_IMAGE:String = "invalid_nav_image";
      
      private static const IMG_ALPHA_HIGHLIGHT:Number = 1;
      
      private static const IMG_ALPHA:Number = 0.5;
      
      private static const UP_STATE:String = "up";
      
      private static const OUT_STATE:String = "out";
       
      
      public var navImg:IImage = null;
      
      private var _isMinimize:Boolean = false;
      
      private var _imageSource:String = null;
      
      public function PaginationPageButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.navImg.alpha = IMG_ALPHA;
         this.navImg.addEventListener(Event.CHANGE,this.onNavImgChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.navImg.removeEventListener(Event.CHANGE,this.onNavImgChangeHandler);
         this.navImg.dispose();
         this.navImg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = _newFrame;
         if(isInvalid(INVALID_MINIMIZE))
         {
            this.navImg.visible = this._isMinimize;
            if(this._isMinimize)
            {
               label = Values.EMPTY_STR;
            }
            invalidate(INVALID_IMAGE);
            invalidateSize();
         }
         super.draw();
         if(this._isMinimize && isInvalid(InvalidationType.STATE))
         {
            if(_loc1_ == null || _loc1_ == UP_STATE || _loc1_ == OUT_STATE)
            {
               this.navImg.alpha = IMG_ALPHA;
            }
            else
            {
               this.navImg.alpha = IMG_ALPHA_HIGHLIGHT;
            }
         }
         if(this._isMinimize && isInvalid(INVALID_IMAGE))
         {
            this.navImg.source = this._imageSource;
         }
         if(this._isMinimize && isInvalid(InvalidationType.SIZE))
         {
            this.navImg.scaleX = 1 / scaleX;
            this.navImg.x = _width / scaleX - this.navImg.width >> 1;
         }
      }
      
      public function setImage(param1:String) : void
      {
         if(this._imageSource != param1)
         {
            this._imageSource = param1;
            invalidate(INVALID_IMAGE);
         }
      }
      
      public function set isMinimize(param1:Boolean) : void
      {
         if(this._isMinimize != param1)
         {
            this._isMinimize = param1;
            invalidate(INVALID_MINIMIZE);
         }
      }
      
      private function onNavImgChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
