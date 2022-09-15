package net.wg.gui.lobby.vehPostProgression.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleInfoVO extends DAAPIDataClass
   {
       
      
      public var isElite:Boolean = false;
      
      public var freeExp:int = -1;
      
      public var earnedXP:int = -1;
      
      public function VehicleInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
