package net.wg.gui.battle
{
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.interfaces.IReservesStats;
   import net.wg.gui.battle.views.personalReservesTab.PersonalReservesTab;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
   import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewOperationSelector;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.infrastructure.base.meta.IClassicFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.ClassicFullStatsMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class ClassicFullStats extends ClassicFullStatsMeta implements IClassicFullStatsMeta, IReservesStats
   {
      
      private static const NO_QUEST_TF_GAP:int = 12;
      
      private static const TAB_RESERVES_Y_SHIFT:int = 13;
      
      private static const PERSONAL_RESERVES_TAB_ALIAS:String = "boosters";
       
      
      public var tabQuest:IQuestProgressViewOperationSelector = null;
      
      public var tabReserves:PersonalReservesTab = null;
      
      public var noQuestTitleTF:TextField = null;
      
      public var noQuestDescrTF:TextField = null;
      
      private var _currentMissionName:String = null;
      
      private var _questStatusData:DAAPIQuestStatusVO = null;
      
      private var _hasQuestToPerform:Boolean = false;
      
      public function ClassicFullStats()
      {
         super();
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
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         if(this.tabReserves)
         {
            this.tabReserves.width = param1;
            this.tabReserves.height = param2 - this.tabReserves.y;
            this.tabReserves.x = -this.tabReserves.width >> 1;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.tabQuest != null)
         {
            this.tabQuest.addEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
         }
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
      
      override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTable(param1,param2);
         if(this.tabQuest != null)
         {
            this.tabQuest.y = statsTable.y;
         }
         if(this.tabReserves != null)
         {
            this.tabReserves.y = tabs.y + TAB_RESERVES_Y_SHIFT;
         }
         this.noQuestTitleTF.y = param2 - (this.noQuestTitleTF.height + this.noQuestTitleTF.height + NO_QUEST_TF_GAP) >> 1;
         this.noQuestDescrTF.y = this.noQuestTitleTF.y + this.noQuestTitleTF.height + NO_QUEST_TF_GAP | 0;
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
      
      override protected function updateCurrentTab() : void
      {
         statsTable.visible = tabs.selectedIndex == 0;
         var _loc1_:Boolean = this.getTabDataAlias(tabs.selectedIndex) == PERSONAL_RESERVES_TAB_ALIAS;
         if(this.tabReserves != null)
         {
            this.tabReserves.visible = _loc1_;
         }
         var _loc2_:Boolean = tabs.selectedIndex == 1 && this._hasQuestToPerform;
         if(this.tabQuest != null)
         {
            this.tabQuest.visible = _loc2_;
         }
         var _loc3_:Boolean = statsTable.visible || _loc2_ || _loc1_;
         title.visible = _loc3_ && !_loc1_;
         if(_loc3_)
         {
            this.setTitle();
         }
         this.noQuestTitleTF.visible = this.noQuestDescrTF.visible = !_loc3_;
      }
      
      public function getReservesView() : IDAAPIModule
      {
         return this.tabReserves;
      }
      
      private function getTabDataAlias(param1:int) : String
      {
         if(param1 < 0)
         {
            return Values.EMPTY_STR;
         }
         var _loc2_:TabsDataVo = tabs.dataProvider[param1];
         return _loc2_.alias;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && title.visible)
         {
            title.validateNow();
         }
         super.visible = param1;
      }
      
      private function onProgressTrackingQuestSelectHandler(param1:QuestProgressTabEvent) : void
      {
         onSelectQuestS(param1.questID);
      }
   }
}
