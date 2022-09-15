package net.wg.gui.battle
{
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.battle.views.personalReservesTab.PersonalReservesTab;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
   import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewOperationSelector;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.infrastructure.base.meta.ITabbedFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.TabbedFullStatsMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   public class TabbedFullStats extends TabbedFullStatsMeta implements ITabbedFullStatsMeta
   {
      
      private static const MIN_TABS_RENDERER_WIDTH:int = 134;
      
      private static const TABS_Y:int = 141;
      
      private static const TABS_SMALL_Y:int = 98;
      
      private static const NO_QUEST_TF_GAP:int = 12;
      
      private static const TITLE_SMALL_Y_SHIFT:int = 58;
       
      
      public var tabs:ContentTabBar = null;
      
      public var tabQuest:IQuestProgressViewOperationSelector = null;
      
      public var tabReserves:PersonalReservesTab = null;
      
      public var noQuestTitleTF:TextField = null;
      
      public var noQuestDescrTF:TextField = null;
      
      private var _currentMissionName:String = null;
      
      private var _lastSelectedTabIndex:int = 0;
      
      private var _questStatusData:DAAPIQuestStatusVO = null;
      
      private var _hasQuestToPerform:Boolean = false;
      
      public function TabbedFullStats()
      {
         super();
      }
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         if(this.tabReserves)
         {
            this.tabReserves.width = param1;
            this.tabReserves.height = param2 - this.tabReserves.y;
            this.tabReserves.x = -this.tabReserves.width / 2;
         }
      }
      
      override public function getStatsProgressView() : IQuestProgressView
      {
         return this.tabQuest;
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
         this._questStatusData = DAAPIQuestStatusVO(param1);
         if(visible)
         {
            this.updateCurrentTab();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabs.itemRendererName = Linkages.CONTENT_TAB_RENDERER;
         this.tabs.minRendererWidth = MIN_TABS_RENDERER_WIDTH;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         if(this.tabQuest != null)
         {
            this.tabQuest.addEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
         }
      }
      
      override protected function updateTabs(param1:DataProvider) : void
      {
         this.tabs.dataProvider = param1;
      }
      
      override protected function onDispose() : void
      {
         if(this.tabQuest != null)
         {
            this.tabQuest.removeEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
            this.tabQuest.dispose();
            this.tabQuest = null;
         }
         if(this.tabReserves != null)
         {
            this.tabReserves = null;
         }
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.noQuestTitleTF = null;
         this.noQuestDescrTF = null;
         this._questStatusData = null;
         super.onDispose();
      }
      
      override protected function updateProgressTracking(param1:QPProgressTrackingVO) : void
      {
         var _loc2_:QPTrackingDataItemVO = null;
         if(this.tabQuest != null)
         {
            this.tabQuest.updateProgressTracking(param1);
         }
         for each(_loc2_ in param1.trackingData)
         {
            if(_loc2_.selected)
            {
               this._currentMissionName = _loc2_.fullMissionName;
               break;
            }
         }
      }
      
      override protected function questProgressPerform(param1:QuestProgressPerformVO) : void
      {
         this.noQuestTitleTF.htmlText = param1.noQuestTitle;
         this.noQuestDescrTF.htmlText = param1.noQuestDescr;
         if(this._hasQuestToPerform != param1.hasQuestToPerform)
         {
            this._hasQuestToPerform = param1.hasQuestToPerform;
            this.updateCurrentTab();
         }
      }
      
      override protected function doUpdateSizeTop(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTop(param1,param2);
         this.tabs.y = param2 < MIN_HEIGHT ? Number(TABS_SMALL_Y) : Number(TABS_Y);
      }
      
      override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTable(param1,param2);
         if(this.tabQuest != null)
         {
            this.tabQuest.y = statsTable.y;
         }
         if(this.tabReserves != null)
         {
            this.tabReserves.y = this.tabs.y + 13;
         }
         this.noQuestTitleTF.y = param2 - (this.noQuestTitleTF.height + this.noQuestTitleTF.height + NO_QUEST_TF_GAP) >> 1;
         this.noQuestDescrTF.y = this.noQuestTitleTF.y + this.noQuestTitleTF.height + NO_QUEST_TF_GAP | 0;
      }
      
      override protected function getTitleY() : int
      {
         var _loc1_:int = height - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
         return this.tabs.y + TITLE_SMALL_Y_SHIFT + _loc1_;
      }
      
      override protected function initTitle() : void
      {
      }
      
      override protected function setTitle() : void
      {
         title.setStatus(statsTable.visible || this._questStatusData == null ? emptyStatusVO : this._questStatusData);
         if(statsTable.visible)
         {
            super.setTitle();
         }
         else if(this.tabQuest && this.tabQuest.visible)
         {
            title.setTitle(this._currentMissionName);
         }
         else if(this.tabReserves && this.tabReserves.visible)
         {
            title.setTitle(App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_PERSONALRESERVES_HEADER_TITLE));
         }
      }
      
      public function as_resetActiveTab() : void
      {
         this.tabs.selectedIndex = this._lastSelectedTabIndex;
      }
      
      public function as_setActiveTab(param1:Number) : void
      {
         this._lastSelectedTabIndex = this.tabs.selectedIndex;
         this.tabs.selectedIndex = param1;
      }
      
      protected function updateCurrentTab() : void
      {
         var _loc3_:Boolean = false;
         statsTable.visible = this.tabs.selectedIndex == 0;
         var _loc1_:Boolean = this.tabs.selectedIndex == 2;
         if(this.tabReserves != null)
         {
            this.tabReserves.visible = _loc1_;
         }
         var _loc2_:Boolean = this.tabs.selectedIndex == 1 && this._hasQuestToPerform;
         if(this.tabQuest != null)
         {
            this.tabQuest.visible = _loc2_;
         }
         _loc3_ = statsTable.visible || _loc2_ || _loc1_;
         title.visible = _loc3_ && !_loc1_;
         if(_loc3_)
         {
            this.setTitle();
         }
         this.noQuestTitleTF.visible = this.noQuestDescrTF.visible = !_loc3_;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && title.visible)
         {
            title.validateNow();
         }
         super.visible = param1;
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         this.updateCurrentTab();
      }
      
      private function onProgressTrackingQuestSelectHandler(param1:QuestProgressTabEvent) : void
      {
         onSelectQuestS(param1.questID);
      }
   }
}
