package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehiclesDataVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO.BossBotInfoVO;
   import net.wg.white_tiger.infrastructure.base.meta.IWTPlayersPanelMeta;
   import net.wg.white_tiger.infrastructure.base.meta.impl.WTPlayersPanelMeta;
   
   public class PlayersPanel extends WTPlayersPanelMeta implements IWTPlayersPanelMeta
   {
       
      
      public var bossPanelList:BossPanelList = null;
      
      private var _isBoss:Boolean = false;
      
      public function PlayersPanel()
      {
         super();
      }
      
      override public function as_setPanelMode(param1:int) : void
      {
      }
      
      override public function as_setPlayerHP(param1:Boolean, param2:int, param3:int) : void
      {
         super.as_setPlayerHP(param1,param2,param3);
      }
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         if(!this._isBoss)
         {
            this.bossPanelList.x = listRight.x;
         }
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setListsState(PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES);
      }
      
      override protected function onDispose() : void
      {
         this.bossPanelList.dispose();
         this.bossPanelList = null;
         super.onDispose();
      }
      
      override protected function applyVehicleData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIHunterVehiclesDataVO = DAAPIHunterVehiclesDataVO(param1);
         listLeft.setVehicleData(_loc2_.leftVehicleInfos);
         listLeft.updateOrder(_loc2_.leftVehiclesIDs);
         listRight.setVehicleData(_loc2_.rightVehicleInfos);
         listRight.updateOrder(_loc2_.rightVehiclesIDs);
      }
      
      override protected function setBossBotInfo(param1:BossBotInfoVO) : void
      {
         this.bossPanelList.setBotInfo(param1);
      }
      
      override protected function setListsState(param1:int) : void
      {
         state = listLeft.state = listRight.state = param1;
         dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,param1));
      }
      
      public function as_clearBossBotCamp(param1:int) : void
      {
         this.bossPanelList.clearCamp(param1);
      }
      
      public function as_resetGeneratorCaptureTimer(param1:int) : void
      {
         this.bossPanelList.resetGeneratorIconTimer(param1);
      }
      
      public function as_setAllBossBotCampsOffline() : void
      {
         this.bossPanelList.setAllCampsOffline();
      }
      
      public function as_setBossBotSpotted(param1:int, param2:int) : void
      {
         this.bossPanelList.setBotSpotted(param1,param2);
      }
      
      public function as_setIsBoss(param1:Boolean) : void
      {
         this._isBoss = param1;
         listLeft.visible = !param1;
         listRight.visible = param1;
         this.bossPanelList.isAlly = param1;
         this.bossPanelList.x = !!param1 ? Number(0) : Number(listRight.x);
      }
      
      public function as_setIsDestroyed(param1:int, param2:Boolean) : void
      {
         this.bossPanelList.setIsDestroyed(param1,param2);
      }
      
      public function as_updateBossBotHp(param1:int, param2:int, param3:int) : void
      {
         this.bossPanelList.updateBotHp(param1,param2,param3);
      }
      
      public function as_updateCampInfoStatus(param1:int) : void
      {
         this.bossPanelList.updateInfoStatus(param1);
      }
      
      public function as_updateGeneratorCaptureTimer(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.bossPanelList.updateGeneratorCaptureTimer(param1,param2,param3,param4,param5);
      }
      
      public function as_updateGeneratorDownTime(param1:int, param2:Number, param3:Number, param4:String) : void
      {
         this.bossPanelList.updateGeneratorDownTime(param1,param2,param3,param4);
      }
   }
}
