package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BossBotInfoVO extends DAAPIDataClass
   {
       
      
      public var vehicleIcon:String = "";
      
      public var typeVehicle:String = "";
      
      public var hpMax:int = 0;
      
      public var hpCurrent:int = 0;
      
      public var vehID:uint = 0;
      
      public var campIndex:uint = 0;
      
      public var vehicleGuiName:String = "";
      
      public function BossBotInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
