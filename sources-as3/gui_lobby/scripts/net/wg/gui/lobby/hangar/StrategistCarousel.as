package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IStrategistCarouselMeta;
   import net.wg.infrastructure.base.meta.impl.StrategistCarouselMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class StrategistCarousel extends StrategistCarouselMeta implements IStrategistCarouselMeta
   {
      
      private static const HEIGHT:int = 200;
       
      
      private var _stageWidth:int = 0;
      
      public function StrategistCarousel()
      {
         super();
         setSize(this._stageWidth,HEIGHT);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            setSize(this._stageWidth,HEIGHT);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function updateCarouselPosition(param1:Number) : void
      {
         y = param1;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         this._stageWidth = param1;
         invalidate(InvalidationType.SIZE);
      }
   }
}
