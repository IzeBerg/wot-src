package net.wg.gui.components.crosshairPanel
{
   public class CrosshairArcade extends CrosshairWithCassette
   {
      
      private static const CASSETE_POSITION_DIAGONAL:Number = -2;
      
      private static const CASSETE_POSITION_HORIZONTAL:Number = 8;
      
      private static const CASSETE_POSITION_RADIAL:Number = -2;
      
      private static const CASSETE_POSITION_DASHED:Number = -2;
       
      
      public function CrosshairArcade()
      {
         super();
      }
      
      override protected function getCassettePositions() : Array
      {
         return [CASSETE_POSITION_DIAGONAL,CASSETE_POSITION_HORIZONTAL,CASSETE_POSITION_RADIAL,CASSETE_POSITION_DASHED];
      }
   }
}
