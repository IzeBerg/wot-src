package net.wg.gui.battle.views.siegeModePanel
{
   public class YohChassisModeAnimation extends SiegeModeAnimation
   {
      
      private static const YOH_PREFIX:String = "yoh_";
       
      
      public function YohChassisModeAnimation()
      {
         super();
      }
      
      override protected function createDeviceStatusImgSrc(param1:String, param2:String) : String
      {
         return YOH_PREFIX + param1 + DELIMITER + param2;
      }
   }
}
