package net.wg.gui.components.crosshairPanel
{
   public class CrosshairArcade extends CrosshairWithCassette
   {
      
      private static const RELOAD_TIME_BLINK_Y_DIAGONAL:int = 9;
      
      private static const RELOAD_TIME_BLINK_Y_HORIZONTAL:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_RADIAL:int = 10;
      
      private static const RELOAD_TIME_BLINK_Y_DASHED:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_SIEGE:int = 22;
       
      
      public function CrosshairArcade()
      {
         super();
      }
      
      override protected function getReloadTimeBlinkYPos() : Array
      {
         return [RELOAD_TIME_BLINK_Y_DIAGONAL,RELOAD_TIME_BLINK_Y_HORIZONTAL,RELOAD_TIME_BLINK_Y_RADIAL,RELOAD_TIME_BLINK_Y_DASHED,RELOAD_TIME_BLINK_Y_SIEGE];
      }
   }
}
