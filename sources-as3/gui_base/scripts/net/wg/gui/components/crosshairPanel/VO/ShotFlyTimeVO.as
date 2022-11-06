package net.wg.gui.components.crosshairPanel.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShotFlyTimeVO extends DAAPIDataClass
   {
       
      
      public var shellIntCD:int = -1;
      
      public var flyTime:Number = 0;
      
      public function ShotFlyTimeVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
