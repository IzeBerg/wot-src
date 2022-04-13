package net.wg.infrastructure.helpers.statisticsDataController
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.infrastructure.base.meta.IRTSBattleStatisticDataControllerMeta;
   import net.wg.infrastructure.base.meta.impl.RTSBattleStatisticDataControllerMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   
   public class RTSBattleStatisticDataController extends RTSBattleStatisticDataControllerMeta implements IRTSBattleStatisticDataControllerMeta
   {
       
      
      private var _rtsComponents:Vector.<IRTSBattleStatisticDataController> = null;
      
      public function RTSBattleStatisticDataController()
      {
         super();
         this._rtsComponents = new Vector.<IRTSBattleStatisticDataController>(0);
      }
      
      override protected function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSCommanderInfo(param1);
         }
      }
      
      override protected function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSCommanderData(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._rtsComponents.fixed = false;
         this._rtsComponents.splice(0,this._rtsComponents.length);
         this._rtsComponents = null;
         super.onDispose();
      }
      
      override protected function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSSelectedVehicles(param1);
         }
      }
      
      override protected function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSSupplyData(param1);
         }
      }
      
      public function as_setRTSCommanderMode(param1:Boolean) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSCommanderMode(param1);
         }
      }
      
      public function as_setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSVehicleDisabled(param1,param2);
         }
      }
      
      public function as_setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc4_:IRTSBattleStatisticDataController = null;
         for each(_loc4_ in this._rtsComponents)
         {
            _loc4_.setRTSOrder(param1,param2,param3);
         }
      }
      
      public function as_setRTSPlayerCommander(param1:Boolean) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSPlayerCommander(param1);
         }
      }
      
      public function as_setRTSVehicleGroup(param1:int, param2:int) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSVehicleGroup(param1,param2);
         }
      }
      
      public function as_setRTSVehicleInFocus(param1:int) : void
      {
         var _loc2_:IRTSBattleStatisticDataController = null;
         for each(_loc2_ in this._rtsComponents)
         {
            _loc2_.setRTSVehicleInFocus(param1);
         }
      }
      
      override protected function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSVehiclesInFocus(param1,param2);
         }
      }
      
      public function as_setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:IRTSBattleStatisticDataController = null;
         for each(_loc5_ in this._rtsComponents)
         {
            _loc5_.setRTSReloading(param1,param2,param3,param4);
         }
      }
      
      public function as_setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSSpeakingVehicle(param1,param2);
         }
      }
      
      public function as_setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:IRTSBattleStatisticDataController = null;
         for each(_loc6_ in this._rtsComponents)
         {
            _loc6_.setRTSClipData(param1,param2,param3,param4,param5);
         }
      }
      
      public function registerRTSComponentController(param1:IRTSBattleStatisticDataController) : void
      {
         App.utils.asserter.assertNotNull(param1,"ComponentController to be added " + Errors.CANT_NULL);
         this._rtsComponents.push(param1);
      }
      
      public function as_setDeviceDamaged(param1:Number, param2:String) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSVehicleModuleDamaged(param1,param2);
         }
      }
      
      public function as_setDeviceRepaired(param1:Number, param2:String) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSVehicleModuleRepaired(param1,param2);
         }
      }
      
      public function as_setRTSVehicleCondition(param1:Number, param2:String) : void
      {
         var _loc3_:IRTSBattleStatisticDataController = null;
         for each(_loc3_ in this._rtsComponents)
         {
            _loc3_.setRTSCondition(param1,param2);
         }
      }
   }
}
