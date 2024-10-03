package net.wg.gui.components.crosshairPanel
{
   public class CrosshairArcade extends WTCrosshairBase
   {
      
      private static const RELOAD_TIME_BLINK_Y_DIAGONAL:int = 9;
      
      private static const RELOAD_TIME_BLINK_Y_HORIZONTAL:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_RADIAL:int = 10;
      
      private static const RELOAD_TIME_BLINK_Y_DASHED:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_SIEGE:int = 22;
      
      private static const PLASMA_INDICATOR_Y_HORIZONTAL:Number = 550;
      
      private static const PLASMA_INDICATOR_Y_DIAGONAL:Number = 1050;
      
      private static const PLASMA_INDICATOR_Y_RADIAL:Number = 1050;
      
      private static const PLASMA_INDICATOR_Y_DASHED:Number = 1050;
      
      private static const PLASMA_INDICATOR_Y_SIEGE:Number = 1050;
      
      private static const PLASMA_INDICATOR_SCALE_DIAGONAL:Number = 1.25;
      
      private static const PLASMA_INDICATOR_SCALE_HORIZONTAL:Number = 0.75;
      
      private static const PLASMA_INDICATOR_SCALE_RADIAL:Number = 1.25;
      
      private static const PLASMA_INDICATOR_SCALE_DASHED:Number = 1.25;
      
      private static const PLASMA_INDICATOR_SCALE_SIEGE:Number = 1.25;
       
      
      public function CrosshairArcade()
      {
         super();
      }
      
      override protected function getReloadTimeBlinkYPos() : Array
      {
         return [RELOAD_TIME_BLINK_Y_DIAGONAL,RELOAD_TIME_BLINK_Y_HORIZONTAL,RELOAD_TIME_BLINK_Y_RADIAL,RELOAD_TIME_BLINK_Y_DASHED,RELOAD_TIME_BLINK_Y_SIEGE];
      }
      
      override protected function getPlasmaDamageIndicatorYPos() : Array
      {
         return [PLASMA_INDICATOR_Y_DIAGONAL,PLASMA_INDICATOR_Y_HORIZONTAL,PLASMA_INDICATOR_Y_RADIAL,PLASMA_INDICATOR_Y_DASHED,PLASMA_INDICATOR_Y_SIEGE];
      }
      
      override protected function getPlasmaDamageIndicatorScale() : Array
      {
         return [PLASMA_INDICATOR_SCALE_DIAGONAL,PLASMA_INDICATOR_SCALE_HORIZONTAL,PLASMA_INDICATOR_SCALE_RADIAL,PLASMA_INDICATOR_SCALE_DASHED,PLASMA_INDICATOR_SCALE_SIEGE];
      }
   }
}
