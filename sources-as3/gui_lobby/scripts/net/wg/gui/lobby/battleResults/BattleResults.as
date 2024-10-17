package net.wg.gui.lobby.battleResults
{
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.FinalStatisticEvent;
   import net.wg.gui.events.QuestEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.TabInfoVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
   import net.wg.gui.lobby.battleResults.event.TeamTableSortEvent;
   import net.wg.gui.lobby.battleResults.progressReport.DogTagLinkEvent;
   import net.wg.gui.lobby.battleResults.progressReport.UnlockLinkEvent;
   import net.wg.gui.lobby.prestige.event.PrestigeEvent;
   import net.wg.infrastructure.base.meta.IBattleResultsMeta;
   import net.wg.infrastructure.base.meta.impl.BattleResultsMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.IRegisteredComponent;
   import net.wg.infrastructure.uilogging.player_satisfaction_rating.PostBattleTeamLogger;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   
   public class BattleResults extends BattleResultsMeta implements IBattleResultsMeta
   {
       
      
      public var tabs_mc:ButtonBarEx = null;
      
      public var view_mc:ViewStack = null;
      
      public var line:Sprite = null;
      
      public var noResult:TextField = null;
      
      public var resultsShareBtn:SoundButtonEx = null;
      
      public var wndBgForm:Sprite = null;
      
      private var _emblemLoadingDelegates:Dictionary;
      
      private var _data:BattleResultsVO = null;
      
      private var _logger:PostBattleTeamLogger = null;
      
      public function BattleResults()
      {
         this._emblemLoadingDelegates = new Dictionary();
         super();
         this.wndBgForm.visible = false;
         showWindowBgForm = false;
         this.visible = false;
         this.noResult.visible = false;
         addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler,false,0,true);
         addEventListener(ClanEmblemRequestEvent.TYPE,this.onClanEmblemLoadEventHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._logger = new PostBattleTeamLogger();
         this.noResult.text = BATTLE_RESULTS.NODATA;
         this.tabs_mc.addEventListener(FocusEvent.FOCUS_IN,this.onTabFocusInHandler);
         this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
         addEventListener(UnlockLinkEvent.TYPE,this.onUnlockLinkBtnHandler);
         addEventListener(DogTagLinkEvent.BATTLE_RESULTS_DOG_TAG_LINK_BTN_EVENT,this.onDogTagLinkBtnHandler);
         addEventListener(PrestigeEvent.SHOW_TECHNIQUE_PROFILE,this.onPrestigeProgressBtnHandler);
         addEventListener(TeamTableSortEvent.TYPE,this.onTeamTableSortEventHandler);
         addEventListener(BattleResultsViewEvent.SHOW_PROGRESSIVE_REWARD_VIEW,this.onShowProgressiveRewardViewHandler,false,0,true);
         addEventListener(QuestEvent.SELECT_QUEST,this.onShowEventsWindowHandler,false,0,true);
         addEventListener(BattleResultsViewEvent.APPLIED_PREMIUM_BONUS,this.onAppliedPremiumBonusHandler,false,0,true);
         addEventListener(BattleResultsViewEvent.SHOW_DETAILS_PREMIUM,this.onShowDetailsPremiumHandler,false,0,true);
         addEventListener(BattleResultsViewEvent.SHOW_DETAILS_WOT_PLUS,this.onShowDetailsWotPlusHandler,false,0,true);
         addEventListener(BattleResultsViewEvent.SHOW_MANAGEABLE_XP_SCREEN,this.onShowManageableXPHandler,false,0,true);
         this.tabs_mc.visible = false;
         this.line.visible = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         showWaitingMessage("");
         this.visible = true;
         window.getBackground().tabChildren = false;
         window.getBackground().tabEnabled = false;
         this.resultsShareBtn.visible = false;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(UnlockLinkEvent.TYPE,this.onUnlockLinkBtnHandler);
         removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler);
         removeEventListener(ClanEmblemRequestEvent.TYPE,this.onClanEmblemLoadEventHandler);
         removeEventListener(TeamTableSortEvent.TYPE,this.onTeamTableSortEventHandler);
         this.resultsShareBtn.removeEventListener(ButtonEvent.CLICK,this.onResultsShareBtnClickHandler);
         this.resultsShareBtn.dispose();
         this.resultsShareBtn = null;
         this.wndBgForm = null;
         removeEventListener(BattleResultsViewEvent.SHOW_PROGRESSIVE_REWARD_VIEW,this.onShowProgressiveRewardViewHandler);
         removeEventListener(QuestEvent.SELECT_QUEST,this.onShowEventsWindowHandler);
         removeEventListener(BattleResultsViewEvent.APPLIED_PREMIUM_BONUS,this.onAppliedPremiumBonusHandler);
         removeEventListener(BattleResultsViewEvent.SHOW_DETAILS_PREMIUM,this.onShowDetailsPremiumHandler);
         removeEventListener(BattleResultsViewEvent.SHOW_DETAILS_WOT_PLUS,this.onShowDetailsWotPlusHandler);
         removeEventListener(BattleResultsViewEvent.SHOW_MANAGEABLE_XP_SCREEN,this.onShowManageableXPHandler);
         removeEventListener(DogTagLinkEvent.BATTLE_RESULTS_DOG_TAG_LINK_BTN_EVENT,this.onDogTagLinkBtnHandler);
         removeEventListener(PrestigeEvent.SHOW_TECHNIQUE_PROFILE,this.onPrestigeProgressBtnHandler);
         App.utils.data.cleanupDynamicObject(this._emblemLoadingDelegates);
         this._emblemLoadingDelegates = null;
         this.tabs_mc.removeEventListener(FocusEvent.FOCUS_IN,this.onTabFocusInHandler);
         this.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
         this.tabs_mc.dispose();
         this.tabs_mc = null;
         this.view_mc.dispose();
         this.view_mc = null;
         this.noResult = null;
         this._data = null;
         this.line = null;
         if(this._logger)
         {
            this._logger.dispose();
            this._logger = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               this.tabs_mc.visible = true;
               this.line.visible = true;
               window.title = this._data.textData.windowTitle;
               this.resultsShareBtn.label = this._data.textData.shareButtonLabel;
               this.resultsShareBtn.tooltip = this._data.textData.shareButtonTooltip;
            }
            this.noResult.visible = this._data == null;
         }
         super.draw();
      }
      
      override protected function setData(param1:BattleResultsVO) : void
      {
         this._data = param1;
         this.tabs_mc.dataProvider = param1.tabInfo;
         if(this.tabs_mc.selectedIndex == -1)
         {
            this.tabs_mc.selectedIndex = 0;
         }
         this.tabs_mc.validateNow();
         setFocus(this.tabs_mc);
         this.resultsShareBtn.visible = this._data.common.battleResultsSharingIsAvailable;
         if(this.resultsShareBtn.visible)
         {
            this.resultsShareBtn.addEventListener(ButtonEvent.CLICK,this.onResultsShareBtnClickHandler);
         }
         else
         {
            this.resultsShareBtn.removeEventListener(ButtonEvent.CLICK,this.onResultsShareBtnClickHandler);
         }
         invalidateData();
         showWaiting = false;
         this.registerComponent(this.view_mc.currentView as IRegisteredComponent);
         this.view_mc.currentView.update(param1);
      }
      
      public function as_setClanEmblem(param1:String, param2:String) : void
      {
         this.onEmblemLoaded(param1,param2,null);
      }
      
      public function as_setIsInBattleQueue(param1:Boolean) : void
      {
         this._data.personal.dispatchEvent(new BattleResultsViewEvent(!!param1 ? BattleResultsViewEvent.BATTLE_QUEUE_ENTERED : BattleResultsViewEvent.BATTLE_QUEUE_EXITED));
      }
      
      public function as_setTeamInfo(param1:String, param2:String, param3:String) : void
      {
         this.onEmblemLoaded(param1,param2,param3);
      }
      
      private function onEmblemLoaded(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:IEmblemLoadedDelegate = null;
         if(this._emblemLoadingDelegates[param1] != null)
         {
            _loc4_ = IEmblemLoadedDelegate(this._emblemLoadingDelegates[param1]);
            _loc4_.onEmblemLoaded(param1,param2,param3);
            delete this._emblemLoadingDelegates[param1];
         }
      }
      
      private function registerComponent(param1:IRegisteredComponent) : void
      {
         if(param1)
         {
            param1.registerFlashComponentVia(this);
         }
      }
      
      private function onShowProgressiveRewardViewHandler(param1:BattleResultsViewEvent) : void
      {
         showProgressiveRewardViewS();
      }
      
      private function onTeamTableSortEventHandler(param1:TeamTableSortEvent) : void
      {
         saveSortingS(param1.columnId,param1.sortDirection,param1.bonusType);
         this._data.common.iconType = param1.columnId;
         this._data.common.sortDirection = param1.sortDirection;
         this._data.common.bonusType = param1.bonusType;
      }
      
      private function onUnlockLinkBtnHandler(param1:UnlockLinkEvent) : void
      {
         showUnlockWindowS(param1.itemId,param1.unlockType);
      }
      
      private function onDogTagLinkBtnHandler(param1:DogTagLinkEvent) : void
      {
         showDogTagWindowS(param1.componentId);
      }
      
      private function onPrestigeProgressBtnHandler(param1:PrestigeEvent) : void
      {
         showVehicleStatsS(param1.vehCD);
      }
      
      private function onResultsShareBtnClickHandler(param1:ButtonEvent) : void
      {
         onResultsSharingBtnPressS();
      }
      
      private function onClanEmblemLoadEventHandler(param1:ClanEmblemRequestEvent) : void
      {
         param1.stopPropagation();
         this._emblemLoadingDelegates[param1.uid] = param1.delegate;
         getClanEmblemS(param1.uid,param1.clanId);
      }
      
      private function onFocusRequestHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
      }
      
      private function onTabFocusInHandler(param1:FocusEvent) : void
      {
         this.view_mc.dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.HIDE_STATS_VIEW));
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         if(param1.lastIndex != 1 && param1.index == 1)
         {
            this._logger.logOpenTeamPanel();
         }
         var _loc2_:Boolean = TabInfoVO(param1.data).showWndBg;
         this.wndBgForm.visible = _loc2_;
      }
      
      private function onViewChangedHandler(param1:ViewStackEvent) : void
      {
         this.registerComponent(param1.view as IRegisteredComponent);
         param1.view.update(this._data);
      }
      
      private function onShowEventsWindowHandler(param1:QuestEvent) : void
      {
         showEventsWindowS(param1.questID,param1.eventType);
      }
      
      private function onAppliedPremiumBonusHandler(param1:BattleResultsViewEvent) : void
      {
         onAppliedPremiumBonusS();
      }
      
      private function onShowDetailsPremiumHandler(param1:BattleResultsViewEvent) : void
      {
         onShowDetailsPremiumS();
      }
      
      private function onShowDetailsWotPlusHandler(param1:BattleResultsViewEvent) : void
      {
         onShowDetailsWotPlusS();
      }
      
      private function onShowManageableXPHandler(param1:BattleResultsViewEvent) : void
      {
         onShowManageableXPScreenS();
      }
   }
}
