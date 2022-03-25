package net.wg.gui.battle.commander.views.playersPanel
{
   import flash.events.Event;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.playersPanel.interfaces.IRTSPlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   
   public class RTSPlayersPanel extends PlayersPanel implements IRTSBattleStatisticDataController
   {
      
      private static const _SWITCH_FRAME_NORMAL:String = "normal";
      
      private static const _SWITCH_FRAME_COMMANDER:String = "commander";
       
      
      private var _rtsListLeft:IRTSPlayersPanelList = null;
      
      private var _rtsListRight:IRTSPlayersPanelList = null;
      
      private var _stageWidth:Number = 0;
      
      public function RTSPlayersPanel()
      {
         super();
      }
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         this._stageWidth = param1;
         this.updateSwitchPosition();
      }
      
      override protected function onPopulate() : void
      {
         this._rtsListLeft = IRTSPlayersPanelList(listLeft);
         this._rtsListRight = IRTSPlayersPanelList(listRight);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this._rtsListLeft = null;
         this._rtsListRight = null;
         super.onDispose();
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         var _loc2_:DAAPIVehicleCommanderDataVO = null;
         for each(_loc2_ in param1.leftItems)
         {
            this._rtsListLeft.setCommanderData(_loc2_.vehicleID,_loc2_);
            this._rtsListRight.setCommanderData(_loc2_.vehicleID,_loc2_);
         }
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._rtsListLeft.setRTSIsMove(param1,param3);
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
         this._rtsListLeft.visible = !param1;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
         this._rtsListLeft.setIsSpotted(param1,param2);
         this._rtsListRight.setIsSpotted(param1,param2);
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
         panelSwitch.gotoAndStop(!!param1 ? _SWITCH_FRAME_COMMANDER : _SWITCH_FRAME_NORMAL);
         this.updateSwitchPosition();
      }
      
      private function updateSwitchPosition() : void
      {
         panelSwitch.x = panelSwitch.currentFrameLabel == _SWITCH_FRAME_COMMANDER ? Number(this._stageWidth) : Number(0);
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
      }
      
      public function get leftHeight() : Number
      {
         return listLeft.y + listLeft.height;
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
      }
   }
}
