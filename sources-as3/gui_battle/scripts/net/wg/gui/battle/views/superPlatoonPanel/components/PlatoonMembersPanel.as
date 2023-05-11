package net.wg.gui.battle.views.superPlatoonPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.views.superPlatoonPanel.list.PlatoonPanelList;
   import net.wg.infrastructure.events.VoiceChatEvent;
   
   public class PlatoonMembersPanel extends BattleUIComponent
   {
       
      
      public var squadIcon:BattleAtlasSprite = null;
      
      public var platoonTitleTF:TextField = null;
      
      public var platoonPanelList:PlatoonPanelList = null;
      
      public var background:MovieClip = null;
      
      public function PlatoonMembersPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onStartSpeakingHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onStopSpeakingHandler);
      }
      
      override protected function onDispose() : void
      {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onStartSpeakingHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onStopSpeakingHandler);
         this.squadIcon = null;
         this.platoonTitleTF = null;
         this.platoonPanelList.dispose();
         this.platoonPanelList = null;
         this.background = null;
         super.onDispose();
      }
      
      public function updateColorBlind() : void
      {
         this.platoonPanelList.updateColorBlind();
      }
      
      public function forceOrderUpdate() : void
      {
         this.platoonPanelList.forceOrderUpdate();
      }
      
      public function setEpicVehiclesStats(param1:EpicVehicleStatsVO) : void
      {
         this.platoonPanelList.setEpicVehiclesStats(param1);
      }
      
      public function setPlatoonTitle(param1:String) : void
      {
         this.platoonTitleTF.text = param1;
      }
      
      public function setPlayerStatus(param1:DAAPIPlayerStatusVO) : void
      {
         this.platoonPanelList.setPlayerStatus(param1.vehicleID,param1.status);
      }
      
      public function setPlayerHP(param1:Boolean, param2:int, param3:int) : void
      {
         this.platoonPanelList.setPlayerHP(param1,param2,param3);
      }
      
      public function setOverrideExInfo(param1:Boolean) : void
      {
         this.platoonPanelList.setOverrideExInfo(param1);
      }
      
      public function setSquadIndex(param1:int) : void
      {
         if(this.squadIcon != null)
         {
            this.squadIcon.visible = true;
            this.squadIcon.imageName = BATTLEATLAS.squad_gold(param1.toString());
            this.visible = true;
         }
      }
      
      public function setUserTags(param1:DAAPIVehicleUserTagsVO) : void
      {
         this.platoonPanelList.setUserTags(param1.vehicleID,param1.userTags);
      }
      
      public function setVehicleData(param1:DAAPIVehicleInfoVO) : Boolean
      {
         return this.platoonPanelList.setVehicleData(param1);
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
         this.platoonPanelList.updateOrder(param1);
      }
      
      public function updateUserTags(param1:DAAPIVehicleUserTagsVO) : void
      {
         this.platoonPanelList.setUserTags(param1.vehicleID,param1.userTags);
      }
      
      public function updateVehicleStatus(param1:DAAPIVehicleStatusVO) : void
      {
         this.platoonPanelList.setVehicleStatus(param1.vehicleID,param1.status);
      }
      
      public function triggerChatCommand(param1:Number, param2:String) : void
      {
         this.platoonPanelList.triggerChatCommand(param1,param2);
      }
      
      public function setChatCommandsVisibility(param1:Boolean) : void
      {
         this.platoonPanelList.setChatCommandsVisibility(param1);
      }
      
      public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         this.platoonPanelList.setPanelHPBarVisibilityState(param1);
      }
      
      private function onStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.platoonPanelList.setSpeaking(param1.getAccountDBID(),true);
      }
      
      private function onStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.platoonPanelList.setSpeaking(param1.getAccountDBID(),false);
      }
   }
}
