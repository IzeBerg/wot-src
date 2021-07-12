package net.wg.gui.lobby.missions
{
   import fl.transitions.easing.Strong;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
   import net.wg.infrastructure.base.meta.ICurrentVehicleMissionsViewMeta;
   import net.wg.infrastructure.base.meta.impl.CurrentVehicleMissionsViewMeta;
   import scaleform.clik.motion.Tween;
   
   public class CurrentVehicleMissionsView extends CurrentVehicleMissionsViewMeta implements ICurrentVehicleMissionsViewMeta
   {
      
      private static const CAROUSEL_HEIGHT:int = 122;
      
      private static const MOVE_CAROUSEL_DURATION:Number = 1000;
       
      
      public var carousel:TankCarousel;
      
      private var _moveCarouselTween:Tween;
      
      private var _isAlreadyShow:Boolean = false;
      
      public function CurrentVehicleMissionsView()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.carousel,HANGAR_ALIASES.TANK_CAROUSEL);
      }
      
      override protected function onDispose() : void
      {
         this.carousel = null;
         this.clearMoveCarouselTween();
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         this.carousel.updateStage(_width,_originalHeight);
         if(this._isAlreadyShow)
         {
            this.updateCarouselPosition();
         }
         else
         {
            this.clearMoveCarouselTween();
            this.playMoveCarouselTween();
         }
      }
      
      override protected function getHeight() : int
      {
         return _height - CAROUSEL_HEIGHT;
      }
      
      override protected function updateDummySize() : void
      {
         super.updateDummySize();
         dummy.height = _height - CAROUSEL_HEIGHT;
      }
      
      private function getCarouselY() : int
      {
         return _height - this.carousel.getBottom() ^ 0;
      }
      
      private function clearMoveCarouselTween() : void
      {
         if(this._moveCarouselTween)
         {
            this._moveCarouselTween.dispose();
            this._moveCarouselTween = null;
         }
      }
      
      private function playMoveCarouselTween() : void
      {
         var _loc1_:int = this.getCarouselY();
         this.carousel.y = _loc1_ + CAROUSEL_HEIGHT;
         this._moveCarouselTween = new Tween(MOVE_CAROUSEL_DURATION,this.carousel,{"y":_loc1_},{
            "paused":false,
            "ease":Strong.easeOut,
            "delay":SMALL_FADE_IN_DELAY,
            "onComplete":this.onMoveCarouselTweenComplete
         });
         this._moveCarouselTween.fastTransform = false;
      }
      
      private function updateCarouselPosition() : void
      {
         this.carousel.y = this.getCarouselY();
      }
      
      private function onMoveCarouselTweenComplete() : void
      {
         this._isAlreadyShow = true;
         this.clearMoveCarouselTween();
      }
   }
}
