package net.wg.gui.battle.pveBase.views
{
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.pveBase.views.minimap.PveFullMap;
   import net.wg.gui.battle.pveBase.views.playerLives.PvePlayerLives;
   import net.wg.gui.battle.pveBase.views.postmortemPanel.PvePostmortemPanel;
   import net.wg.gui.battle.pveBase.views.primaryObjective.PvePrimaryObjective;
   import net.wg.gui.battle.pveBase.views.progressCounter.PveProgressCounter;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.PveSecondaryObjectives;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.events.PveSecondaryObjectivesEvent;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.infrastructure.PveStatisticsDataController;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import scaleform.clik.constants.InvalidationType;
   
   public class PveBaseBattlePage extends BattlePage
   {
      
      private static const PROGRESS_COUNTER_OFFSET:int = 160;
      
      private static const OBJECTS_WIDGET_OFFSET:int = 162;
      
      private static const OBJECTS_WIDGET_WITHOUT_HISTORY_MESSAGES_OFFSET:int = 99;
      
      private static const PANEL_LIVES_OFFSET_Y:int = 50;
      
      private static const DAMAGE_PANEL_SPACING:int = 28;
      
      private static const HIDDEN_CHAT_OFFSET:int = 51;
      
      private static const CHAT_FREE_SPACE_WITH_SECONDARY_OBJECTIVES:int = 120;
       
      
      public var pveProgressCounter:PveProgressCounter = null;
      
      public var pvePrimaryObjective:PvePrimaryObjective = null;
      
      public var pveSecondaryObjectives:PveSecondaryObjectives = null;
      
      public var pvePlayerLives:PvePlayerLives = null;
      
      public var pveFullMap:PveFullMap = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      public function PveBaseBattlePage()
      {
         super();
         this.pveFullMap.visible = false;
         addChildAt(this.pveFullMap.dimmer,0);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.pveSecondaryObjectives.addEventListener(PveSecondaryObjectivesEvent.CHANGED,this.onPveSecondaryObjectivesChangeHandler);
         postmortemPanelUI.addEventListener(PvePostmortemPanel.CHANGED_EVENT,this.onPostmortemChangeHandler);
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:uint = param1 >> 1;
         this.pveProgressCounter.x = param1 - PROGRESS_COUNTER_OFFSET;
         this.pvePrimaryObjective.x = _loc3_;
         this.pvePrimaryObjective.updateStage(param1,param2);
         this.updatePveSecondaryObjectivesPosition();
         this.pvePlayerLives.y = damagePanel.y - PANEL_LIVES_OFFSET_Y;
         this.pveFullMap.updateStagePosition(param1,param2);
         if(postmortemPanelUI)
         {
            postmortemPanelUI.updateStage(param1,param2);
         }
         this.statusNotificationsPanel.updateStage(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.pvePlayerLives.addEventListener(Event.CHANGE,this.onPvePlayerLivesChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            updateMinimapSizeIndex(minimap.currentSizeIndex);
         }
      }
      
      private function updatePveSecondaryObjectivesPosition() : void
      {
         var _loc1_:int = !!battleMessenger.visible ? (!!battleMessenger.isHistoryEnabled ? int(OBJECTS_WIDGET_OFFSET) : int(OBJECTS_WIDGET_WITHOUT_HISTORY_MESSAGES_OFFSET)) : int(HIDDEN_CHAT_OFFSET);
         this.pveSecondaryObjectives.y = battleMessenger.y - _loc1_;
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new PveStatisticsDataController();
      }
      
      override protected function onPopulate() : void
      {
         if(postmortemPanelUI == null)
         {
            postmortemPanelUI = App.utils.classFactory.getComponent(Linkages.PVE_POSTMORTEM_PANEL,PostmortemPanel);
            addChild(postmortemPanelUI);
         }
         postmortemPanelUI.setCompVisible(false);
         registerComponent(this.pveProgressCounter,BATTLE_VIEW_ALIASES.PVE_PROGRESS_COUNTER);
         registerComponent(this.pvePrimaryObjective,BATTLE_VIEW_ALIASES.PVE_PRIMARY_OBJECTIVE);
         registerComponent(this.pveSecondaryObjectives,BATTLE_VIEW_ALIASES.PVE_SECONDARY_OBJECTIVES);
         registerComponent(this.pvePlayerLives,BATTLE_VIEW_ALIASES.PVE_PLAYER_LIVES);
         registerComponent(this.pveFullMap,BATTLE_VIEW_ALIASES.FULLSCREEN_MAP);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         super.onPopulate();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.pvePlayerLives.removeEventListener(Event.CHANGE,this.onPvePlayerLivesChangeHandler);
         this.pveSecondaryObjectives.removeEventListener(PveSecondaryObjectivesEvent.CHANGED,this.onPveSecondaryObjectivesChangeHandler);
         postmortemPanelUI.removeEventListener(PvePostmortemPanel.CHANGED_EVENT,this.onPostmortemChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.pveProgressCounter = null;
         this.pvePrimaryObjective = null;
         this.pveSecondaryObjectives = null;
         this.pvePlayerLives = null;
         this.pveFullMap = null;
         this.statusNotificationsPanel = null;
         super.onDispose();
      }
      
      override protected function getDamagePanelSpacing() : int
      {
         return this.pvePlayerLives.visible && this.pvePlayerLives.isEnabled ? int(DAMAGE_PANEL_SPACING) : int(0);
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         super.onMinimapSizeChangedHandler(param1);
         updateMinimapPosition();
      }
      
      override protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         super.setComponentsVisibility(param1,param2);
         if(param1.indexOf(BATTLE_VIEW_ALIASES.BATTLE_MESSENGER) != -1 || param2.indexOf(BATTLE_VIEW_ALIASES.BATTLE_MESSENGER) != -1)
         {
            this.updatePveSecondaryObjectivesPosition();
         }
         if(param1.indexOf(BATTLE_VIEW_ALIASES.PVE_PLAYER_LIVES) != -1 || param2.indexOf(BATTLE_VIEW_ALIASES.PVE_PLAYER_LIVES) != -1)
         {
            updateBattleMessengerPosition();
            this.updatePveSecondaryObjectivesPosition();
         }
         if(param1.indexOf(BATTLE_VIEW_ALIASES.FULLSCREEN_MAP) != -1 || param2.indexOf(BATTLE_VIEW_ALIASES.FULLSCREEN_MAP) != -1)
         {
            battleMessenger.setInputVisible(!this.pveFullMap.visible);
            battleMessenger.setMessagesInteraction(this.pveFullMap.visible);
         }
      }
      
      override public function as_onPostmortemActive(param1:Boolean) : void
      {
         super.as_onPostmortemActive(param1);
         if(param1)
         {
            updateMinimapSizeIndex(minimap.currentSizeIndex);
         }
      }
      
      override protected function getAvailableMinimapWidth() : Number
      {
         var _loc1_:Number = super.getAvailableMinimapWidth();
         if(postmortemPanelUI && postmortemPanelUI.visible)
         {
            if(postmortemPanelUI is PvePostmortemPanel)
            {
               return Math.min((postmortemPanelUI as PvePostmortemPanel).getMinimapAvailableWidth(),_loc1_);
            }
         }
         return _loc1_;
      }
      
      private function onPveSecondaryObjectivesChangeHandler(param1:PveSecondaryObjectivesEvent) : void
      {
         if(this.pveSecondaryObjectives.hasObjects())
         {
            battleMessenger.setFreeSpace(CHAT_FREE_SPACE_WITH_SECONDARY_OBJECTIVES);
         }
         else
         {
            battleMessenger.setFreeSpace();
         }
      }
      
      private function onPvePlayerLivesChangeHandler(param1:Event) : void
      {
         updateBattleMessengerPosition();
         this.updatePveSecondaryObjectivesPosition();
      }
      
      private function onPostmortemChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
