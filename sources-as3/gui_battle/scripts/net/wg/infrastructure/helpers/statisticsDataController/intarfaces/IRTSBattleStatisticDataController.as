package net.wg.infrastructure.helpers.statisticsDataController.intarfaces
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   
   public interface IRTSBattleStatisticDataController
   {
       
      
      function setRTSCommanderMode(param1:Boolean) : void;
      
      function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void;
      
      function setRTSIsSpotted(param1:Number, param2:Boolean) : void;
      
      function setRTSCondition(param1:Number, param2:String) : void;
      
      function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void;
      
      function setRTSCommanderData(param1:DAAPICommanderDataVO) : void;
      
      function setRTSPlayerCommander(param1:Boolean) : void;
      
      function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void;
      
      function setRTSVehicleGroup(param1:int, param2:int) : void;
      
      function setRTSVehicleInFocus(param1:int) : void;
      
      function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void;
      
      function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void;
      
      function setRTSSelectedVehicles(param1:Vector.<int>) : void;
      
      function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void;
      
      function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void;
      
      function setRTSVehicleDisabled(param1:int, param2:Boolean) : void;
      
      function setRTSVehicleModuleDamaged(param1:int, param2:String) : void;
      
      function setRTSVehicleModuleRepaired(param1:int, param2:String) : void;
   }
}
