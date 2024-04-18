package net.wg.gui.lobby.battleResults
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.ArenaBonusTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.FinalStatisticEvent;
   import net.wg.gui.lobby.battleResults.components.AlertMessage;
   import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
   import net.wg.gui.lobby.battleResults.components.DetailsBlock;
   import net.wg.gui.lobby.battleResults.components.EfficiencyHeader;
   import net.wg.gui.lobby.battleResults.components.PrestigePoints;
   import net.wg.gui.lobby.battleResults.components.TankStatsView;
   import net.wg.gui.lobby.battleResults.components.TextFieldContainer;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
   import net.wg.gui.lobby.battleResults.data.OvertimeVO;
   import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
   import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
   import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
   import net.wg.gui.lobby.battleResults.progressReport.ProgressReportLinkageSelector;
   import net.wg.gui.lobby.progressiveReward.ProgressiveReward;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
   import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class CommonStats extends UIComponentEx implements IViewStackContent, IEmblemLoadedDelegate
   {
      
      private static const COUNTERS_SCALE:Number = 0.75;
      
      private static const COUNTER_LEFT_OFFSET:int = -17;
      
      private static const CREDITS_COUNTER_TOP_OFFSET:int = -8;
      
      private static const XP_COUNTER_TOP_OFFSET:int = -11;
      
      private static const CREDITS_ICON_TOP_OFFSET:int = -15;
      
      private static const XP_ICON_TOP_OFFSET:int = -17;
      
      private static const RES_ICON_LEFT_OFFSET:int = 8;
      
      private static const ARENA_NAME_Y_WITH_ICON:int = 10;
      
      private static const RESULT_DEFAULT_Y:int = 33;
      
      private static const RESULT_MULTIPLE_FINISH_REASON_Y:int = 12;
      
      private static const ARENA_ENEMY_CLAN_EMBLEM:String = "arenaEnemyClanEmblem";
      
      private static const TEAM_ENEMY_EMBLEM_COMMON:String = "teamEnemyEmblemCommon";
      
      private static const LABEL_PLAYER_NAME:String = "playerName";
      
      private static const ZERO_STR:String = "0";
      
      private static const HEADER_INVALID:String = "headerInvalid";
      
      private static const PROGRESS_BLOCK_V_DELTA:uint = 112;
      
      private static const PRESTIGE_POINTS_X_SHIFT:int = -90;
      
      private static const MEDALS_LIST_LEFT_X:int = 22;
       
      
      public var resultLbl:TextField;
      
      public var finishReasonLbl:TextField;
      
      public var arenaNameLbl:TextField;
      
      public var noEfficiencyLbl:TextField;
      
      public var efficiencyTitle:TextField;
      
      public var tankSlot:TankStatsView;
      
      public var efficiencyList:ScrollingListEx;
      
      public var detailsMc:DetailsBlock;
      
      public var progressiveReward:ProgressiveReward;
      
      public var progressiveRewardDelimiter:DisplayObject;
      
      public var medalsListLeft:BattleResultsMedalsList;
      
      public var medalsListRight:BattleResultsMedalsList;
      
      public var xpIcon:DisplayObject;
      
      public var creditsIcon:DisplayObject;
      
      public var crystalIcon:DisplayObject;
      
      public var creditsCounter:CounterEx;
      
      public var xpCounter:CounterEx;
      
      public var crystalCounter:CounterEx;
      
      public var scrollPane:ResizableScrollPane;
      
      public var subtasksScrollBar:ScrollBar;
      
      public var upperShadow:DisplayObjectContainer;
      
      public var lowerShadow:DisplayObjectContainer;
      
      public var noProgressTF:TextField;
      
      public var noIncomeAlert:AlertMessage;
      
      public var progressInfoBG:DisplayObject;
      
      public var overtimeFinishReasonTitle:TextField;
      
      public var mainFinishReasonTitle:TextField;
      
      public var secondaryFinishReason:TextField;
      
      public var overtimeFinishReason:TextField;
      
      public var mainFinishReason:TextField;
      
      public var overtimeBg:DisplayObject;
      
      public var efficiencyHeader:EfficiencyHeader;
      
      public var prestigePoints:PrestigePoints = null;
      
      public var deserter:TextFieldContainer = null;
      
      private var _progressReport:SubtasksList;
      
      private var _creditsCounterNumber:Number;
      
      private var _xpCounterNumber:Number;
      
      private var _crystalCounterNumber:Number = -1;
      
      private var _progressBlocksData:Array;
      
      private var _linkageSelector:ISubtaskListLinkageSelector;
      
      private var _hasPrestigePoints:Boolean = false;
      
      private var _data:BattleResultsVO;
      
      private var _startProgressBGPosition:Number;
      
      private var _statsUtilsManager:IStatsUtilsManager;
      
      public function CommonStats()
      {
         this._linkageSelector = new ProgressReportLinkageSelector();
         this._statsUtilsManager = StatsUtilsManager.getInstance();
         super();
      }
      
      private static function onEfficiencyIconRollOutHandler(param1:FinalStatisticEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function onDispose() : void
      {
         this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER,this.onEfficiencyIconRollOverHandler);
         this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT,onEfficiencyIconRollOutHandler);
         this.efficiencyList.removeEventListener(Event.SCROLL,this.onEfficiencyListScrollHandler);
         this.tankSlot.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.progressiveReward.removeEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
         this.noIncomeAlert.dispose();
         this.tankSlot.dispose();
         this.efficiencyList.dispose();
         this.detailsMc.dispose();
         this.medalsListLeft.dispose();
         this.medalsListRight.dispose();
         this.creditsCounter.dispose();
         this.xpCounter.dispose();
         this.subtasksScrollBar.dispose();
         this._progressBlocksData.splice(0,this._progressBlocksData.length);
         this.noIncomeAlert = null;
         this.progressInfoBG = null;
         this.resultLbl = null;
         this.finishReasonLbl = null;
         this.arenaNameLbl = null;
         this.noEfficiencyLbl = null;
         this.efficiencyTitle = null;
         this.tankSlot = null;
         this.efficiencyList = null;
         this.detailsMc = null;
         this.medalsListLeft = null;
         this.medalsListRight = null;
         this.xpIcon = null;
         this.creditsIcon = null;
         this.creditsCounter = null;
         this.xpCounter = null;
         this.efficiencyHeader.dispose();
         this.efficiencyHeader = null;
         this.crystalCounter.dispose();
         this.crystalCounter = null;
         this.crystalIcon = null;
         this.creditsIcon = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.subtasksScrollBar = null;
         this._progressReport = null;
         this.upperShadow = null;
         this.lowerShadow = null;
         this.noProgressTF = null;
         this.overtimeFinishReasonTitle = null;
         this.mainFinishReasonTitle = null;
         this.secondaryFinishReason = null;
         this.overtimeFinishReason = null;
         this.mainFinishReason = null;
         this.overtimeBg = null;
         this._progressBlocksData = null;
         this.progressiveReward.dispose();
         this.progressiveReward = null;
         this.progressiveRewardDelimiter = null;
         this._linkageSelector.dispose();
         this._linkageSelector = null;
         this.prestigePoints.dispose();
         this.prestigePoints = null;
         this.deserter.dispose();
         this.deserter = null;
         this._data = null;
         this._statsUtilsManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.width ^= 0;
         this.height ^= 0;
         this.upperShadow.mouseEnabled = false;
         this.upperShadow.mouseChildren = false;
         this.lowerShadow.mouseEnabled = false;
         this.lowerShadow.mouseChildren = false;
         this.efficiencyTitle.mouseEnabled = false;
         this.efficiencyList.visible = false;
         this.efficiencyTitle.autoSize = TextFieldAutoSize.LEFT;
         this._startProgressBGPosition = this.progressInfoBG.y;
         this.arenaNameLbl.alpha = 0.8;
         this.arenaNameLbl.blendMode = BlendMode.ADD;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
         {
            this.tankSlot.validateNow();
            this.efficiencyList.validateNow();
            this.detailsMc.validateNow();
            this.medalsListLeft.validateNow();
            this.medalsListRight.validateNow();
            this.creditsCounter.validateNow();
            this.xpCounter.validateNow();
            this.crystalCounter.validateNow();
            this.progressiveReward.validateNow();
            this.visible = true;
         }
         if(isInvalid(HEADER_INVALID))
         {
            this.updateEfficiencyHeader();
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function onEmblemLoaded(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1 == TEAM_ENEMY_EMBLEM_COMMON || param1 == ARENA_ENEMY_CLAN_EMBLEM)
         {
            this.arenaNameLbl.y = ARENA_NAME_Y_WITH_ICON;
            _loc4_ = param2 != null ? param2 + Values.SPACE_STR : Values.EMPTY_STR;
            _loc5_ = param3 != null ? Values.SPACE_STR + param3 : Values.EMPTY_STR;
            this.arenaNameLbl.htmlText += _loc4_ + this._data.common.clans.enemies.clanAbbrev + _loc5_;
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc11_:String = null;
         this._data = BattleResultsVO(param1);
         var _loc2_:PersonalDataVO = this._data.personal;
         var _loc3_:CommonStatsVO = this._data.common;
         var _loc4_:Array = AwardExtractor.extract(this._data.quests);
         var _loc5_:Array = AwardExtractor.extract(this._data.battlePass);
         var _loc6_:Array = this._data.dog_tags;
         var _loc7_:Array = this._data.unlocks;
         if(_loc3_.comp7Rating)
         {
            this._progressBlocksData = this._statsUtilsManager.mergeArrays(_loc7_,[_loc3_.comp7Rating]);
         }
         else
         {
            this._progressBlocksData = _loc7_;
         }
         this._progressBlocksData = this._statsUtilsManager.mergeArrays(this._progressBlocksData,_loc5_);
         if(_loc3_.rank)
         {
            this._progressBlocksData.push(_loc3_.rank);
         }
         this._progressBlocksData = this._statsUtilsManager.mergeArrays(this._progressBlocksData,_loc4_);
         this._progressBlocksData = this._statsUtilsManager.mergeArrays(this._progressBlocksData,_loc6_);
         this._hasPrestigePoints = _loc2_.prestigePoints && _loc2_.prestigePoints.isVisible;
         this.prestigePoints.visible = this._hasPrestigePoints;
         if(this._hasPrestigePoints)
         {
            this.prestigePoints.setData(_loc2_.prestigePoints);
         }
         this.initCounters(_loc2_.creditsStr,_loc2_.xpStr);
         this.efficiencyTitle.text = this._data.efficiencyTitle;
         this.initResultText(_loc3_);
         this.tankSlot.imageSwitcher.gotoAndStop(_loc3_.resultShortStr);
         this.arenaNameLbl.htmlText = _loc3_.arenaStr;
         this.tankSlot.setData(this._data);
         this.tankSlot.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChangeHandler);
         this.crystalCounter.visible = false;
         this.crystalIcon.visible = false;
         if(_loc3_.eligibleForCrystalRewards || StringUtils.isNotEmpty(_loc2_.crystalStr) && _loc2_.crystalStr != ZERO_STR)
         {
            this.initCrystalCounter(_loc2_.crystalStr);
         }
         if(_loc3_.bonusType == ArenaBonusTypes.FORT_BATTLE)
         {
            this.showClan(_loc3_);
         }
         this.medalsListLeft.dataProvider = _loc2_.achievementsLeft;
         this.medalsListRight.dataProvider = _loc2_.achievementsRight;
         this.medalsListLeft.x = !!this._hasPrestigePoints ? Number(0) : Number(MEDALS_LIST_LEFT_X);
         this.initEfficiencyList(_loc2_);
         this.initEfficiencyHeader(_loc2_);
         var _loc8_:ProgressiveRewardVO = this._data.progressiveReward;
         var _loc9_:Boolean = Boolean(_loc8_.isEnabled);
         if(_loc9_)
         {
            this.progressiveReward.setData(_loc8_);
            this.progressiveReward.addEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
         }
         this.progressiveReward.visible = _loc9_;
         this.progressiveRewardDelimiter.visible = _loc9_;
         this.layoutProgressReport(_loc9_);
         var _loc10_:Boolean = _loc2_.showNoIncomeAlert;
         this.setNoIncomeVisible(_loc10_);
         if(!_loc10_)
         {
            this.detailsMc.data = _loc2_;
            this.initProgressReport(0,_loc7_.length);
            this.subtasksScrollBar.visible = true;
         }
         else
         {
            this.noIncomeAlert.setData(_loc2_.noIncomeAlert);
            this.layoutNoIncomeAlert();
         }
         if(this._data.common.playerVehicles.length > 1)
         {
            this.tankSlot.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
         }
         _loc11_ = _loc2_.deserterStr;
         var _loc12_:Boolean = StringUtils.isNotEmpty(_loc11_);
         this.deserter.visible = _loc12_;
         if(_loc12_)
         {
            this.deserter.text = _loc11_;
         }
         invalidateSize();
      }
      
      private function initEfficiencyHeader(param1:PersonalDataVO) : void
      {
         if(param1 && param1.efficiencyHeader && param1.efficiencyHeader.hasEfficencyStats)
         {
            this.efficiencyHeader.setData(param1.efficiencyHeader);
         }
         invalidate(HEADER_INVALID);
      }
      
      private function initResultText(param1:CommonStatsVO) : void
      {
         var _loc2_:OvertimeVO = param1.overtime;
         this.resultLbl.text = param1.resultStr;
         this.resultLbl.y = !!_loc2_.enabled ? Number(RESULT_MULTIPLE_FINISH_REASON_Y) : Number(RESULT_DEFAULT_Y);
         this.overtimeBg.visible = _loc2_.enabled;
         this.mainFinishReasonTitle.visible = _loc2_.enabled;
         this.mainFinishReason.visible = _loc2_.enabled;
         this.overtimeFinishReasonTitle.visible = _loc2_.enabled;
         this.overtimeFinishReason.visible = _loc2_.enabled;
         this.finishReasonLbl.visible = !_loc2_.enabled;
         if(_loc2_.enabled)
         {
            this.mainFinishReasonTitle.text = _loc2_.mainTitle;
            this.mainFinishReason.text = param1.finishReasonStr;
            this.overtimeFinishReasonTitle.text = _loc2_.overtimeTitle;
            this.overtimeFinishReason.text = _loc2_.overtimeFinishReason;
         }
         else
         {
            this.finishReasonLbl.text = param1.finishReasonStr;
         }
         if(this.secondaryFinishReason)
         {
            this.secondaryFinishReason.text = param1.finishReasonClarificationStr;
         }
      }
      
      private function layoutNoIncomeAlert() : void
      {
         var _loc1_:Number = this.detailsMc.x;
         var _loc2_:Number = this.detailsMc.y;
         var _loc3_:Number = this.detailsMc.width;
         var _loc4_:Number = height - this.detailsMc.y;
         this.noIncomeAlert.x = _loc1_ + (_loc3_ - this.noIncomeAlert.width >> 1) | 0;
         this.noIncomeAlert.y = _loc2_ + (_loc4_ - this.noIncomeAlert.height >> 1) | 0;
      }
      
      private function setNoIncomeVisible(param1:Boolean) : void
      {
         this.noIncomeAlert.visible = param1;
         if(this._progressReport != null)
         {
            this._progressReport.visible = !param1;
         }
         this.detailsMc.visible = !param1;
         this.lowerShadow.visible = !param1;
         this.upperShadow.visible = !param1;
         this.subtasksScrollBar.visible = !param1;
         this.noProgressTF.visible = !param1;
         this.subtasksScrollBar.visible = !param1;
         this.progressInfoBG.visible = !param1;
      }
      
      private function showClan(param1:Object) : void
      {
         dispatchEvent(new ClanEmblemRequestEvent(ARENA_ENEMY_CLAN_EMBLEM,param1.clans.enemies.clanDBID,this));
      }
      
      private function alignControls(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.crystalIcon.x = this.crystalCounter.x + RES_ICON_LEFT_OFFSET;
            this.crystalCounter.scaleX = this.crystalCounter.scaleY = COUNTERS_SCALE;
         }
         this.creditsCounter.y += CREDITS_COUNTER_TOP_OFFSET;
         this.creditsCounter.scaleX = this.creditsCounter.scaleY = COUNTERS_SCALE;
         this.creditsIcon.y += CREDITS_ICON_TOP_OFFSET;
         this.xpCounter.y += XP_COUNTER_TOP_OFFSET;
         this.xpCounter.scaleX = this.xpCounter.scaleY = COUNTERS_SCALE;
         this.xpIcon.y += XP_ICON_TOP_OFFSET;
      }
      
      private function initEfficiencyList(param1:PersonalDataVO) : void
      {
         this.efficiencyList.addEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER,this.onEfficiencyIconRollOverHandler);
         this.efficiencyList.addEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT,onEfficiencyIconRollOutHandler);
         this.efficiencyList.addEventListener(Event.SCROLL,this.onEfficiencyListScrollHandler);
         if(param1.details && param1.details.length > 0)
         {
            this.noEfficiencyLbl.visible = false;
            this.efficiencyList.labelField = LABEL_PLAYER_NAME;
            this.tryCleanEfficiencyListDataProvider();
            this.efficiencyList.dataProvider = new DataProvider(param1.details[0]);
            App.utils.scheduler.scheduleOnNextFrame(this.showEfficiencyList);
         }
         else
         {
            this.efficiencyList.visible = false;
            this.noEfficiencyLbl.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_NONE;
            this.noEfficiencyLbl.visible = true;
         }
      }
      
      private function showEfficiencyList() : void
      {
         this.efficiencyList.visible = true;
      }
      
      private function initProgressReport(param1:int, param2:int) : void
      {
         this._progressReport = SubtasksList(this.scrollPane.target);
         this._progressReport.linkage = Linkages.BR_SUBTASK_COMPONENT_UI;
         if(this._progressBlocksData && this._progressBlocksData.length > 0)
         {
            this._linkageSelector.setUnlocksCount(param1,param2);
            this._progressReport.setLinkageSelector(this._linkageSelector);
            this._progressReport.setData(this._progressBlocksData);
            this.noProgressTF.visible = false;
         }
         else
         {
            this.lowerShadow.visible = false;
            this.upperShadow.visible = false;
            this._progressReport.visible = false;
            this.subtasksScrollBar.visible = false;
            this.noProgressTF.visible = true;
            this.noProgressTF.text = BATTLE_RESULTS.COMMON_NOPROGRESS;
            TextFieldEx.setVerticalAlign(this.noProgressTF,TextFieldEx.VALIGN_CENTER);
         }
      }
      
      private function layoutProgressReport(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this._startProgressBGPosition != this.progressInfoBG.y)
         {
            _loc2_ = !!param1 ? int(PROGRESS_BLOCK_V_DELTA) : int(0);
         }
         else
         {
            _loc2_ = !!param1 ? int(0) : int(-PROGRESS_BLOCK_V_DELTA);
         }
         if(_loc2_ != 0)
         {
            this.upperShadow.y += _loc2_;
            this.subtasksScrollBar.y += _loc2_;
            this.scrollPane.y += _loc2_;
            this.noProgressTF.y += _loc2_;
            this.progressInfoBG.y += _loc2_;
            this.progressInfoBG.height -= _loc2_;
            this.scrollPane.height -= _loc2_;
            this.subtasksScrollBar.height -= _loc2_;
         }
      }
      
      private function initCrystalCounter(param1:String) : void
      {
         var _loc2_:int = !!this._hasPrestigePoints ? int(PRESTIGE_POINTS_X_SHIFT) : int(0);
         var _loc3_:ILocale = App.utils.locale;
         var _loc4_:IFormattedInt = _loc3_.parseFormattedInteger(param1);
         this.crystalCounter.init(_loc4_.value,param1,_loc4_.delimiter,this._crystalCounterNumber != _loc4_.value);
         this.crystalCounter.x = (this.tankSlot.imageSwitcher.width + this.crystalCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET + _loc2_;
         if(this._crystalCounterNumber == -1)
         {
            this.alignControls(true);
         }
         this._crystalCounterNumber = _loc4_.value;
         this.crystalCounter.visible = true;
         this.crystalIcon.visible = true;
      }
      
      private function initCounters(param1:String, param2:String) : void
      {
         var _loc3_:int = !!this._hasPrestigePoints ? int(PRESTIGE_POINTS_X_SHIFT) : int(0);
         var _loc4_:ILocale = App.utils.locale;
         var _loc5_:IFormattedInt = _loc4_.parseFormattedInteger(param1);
         this.creditsCounter.init(_loc5_.value,param1,_loc5_.delimiter,this._creditsCounterNumber != _loc5_.value);
         this._creditsCounterNumber = _loc5_.value;
         this.creditsIcon.x = this.creditsCounter.x = (this.tankSlot.imageSwitcher.width + this.creditsCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET + _loc3_;
         var _loc6_:IFormattedInt = _loc4_.parseFormattedInteger(param2);
         this.xpCounter.init(_loc6_.value,_loc4_.cutCharsBeforeNumber(param2),_loc6_.delimiter,this._xpCounterNumber != _loc6_.value);
         this._xpCounterNumber = _loc6_.value;
         this.xpIcon.x = this.xpCounter.x = (this.tankSlot.imageSwitcher.width + this.xpCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET + _loc3_;
      }
      
      private function tryCleanEfficiencyListDataProvider() : void
      {
         if(this.efficiencyList.dataProvider != null)
         {
            this.efficiencyList.dataProvider.cleanUp();
         }
      }
      
      private function updateEfficiencyHeader() : void
      {
         this.efficiencyHeader.visible = this._data != null && this._data.personal != null && this._data.personal.efficiencyHeader != null && this._data.personal.efficiencyHeader.hasEfficencyStats && this.efficiencyList.scrollPosition == 0;
      }
      
      private function onProgressiveRewardLinkBtnClickHandler(param1:ProgressiveRewardEvent) : void
      {
         dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_PROGRESSIVE_REWARD_VIEW));
      }
      
      private function onDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:int = param1.index;
         var _loc3_:Array = this._data.personal.details[_loc2_];
         this.tryCleanEfficiencyListDataProvider();
         this.efficiencyList.dataProvider = new DataProvider(_loc3_);
         this.detailsMc.currentSelectedVehIdx = _loc2_;
      }
      
      private function onEfficiencyIconRollOverHandler(param1:FinalStatisticEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:IconEfficiencyTooltipData = null;
         var _loc2_:Object = param1.data;
         if(_loc2_.hoveredKind)
         {
            _loc3_ = this._data.common.playerVehicles.length > 1;
            _loc4_ = new IconEfficiencyTooltipData();
            _loc4_.type = _loc2_.hoveredKind;
            _loc4_.disabled = _loc2_.isDisabled;
            _loc4_.isGarage = _loc3_;
            switch(_loc2_.hoveredKind)
            {
               case BATTLE_EFFICIENCY_TYPES.DAMAGE:
                  _loc4_.setBaseValues(_loc2_.damageDealtVals,_loc2_.damageDealtNames,_loc2_.damageTotalItems);
                  break;
               case BATTLE_EFFICIENCY_TYPES.ARMOR:
                  _loc4_.setBaseValues(_loc2_.armorVals,_loc2_.armorNames,_loc2_.armorTotalItems);
                  break;
               case BATTLE_EFFICIENCY_TYPES.CAPTURE:
                  _loc4_.setBaseValues(_loc2_.captureVals,_loc2_.captureNames,_loc2_.captureTotalItems);
                  break;
               case BATTLE_EFFICIENCY_TYPES.DEFENCE:
                  _loc4_.setBaseValues(_loc2_.defenceVals,_loc2_.defenceNames,_loc2_.defenceTotalItems);
                  break;
               case BATTLE_EFFICIENCY_TYPES.ASSIST:
                  _loc4_.totalAssistedDamage = _loc2_.damageAssisted;
                  _loc4_.setBaseValues(_loc2_.damageAssistedVals,_loc2_.damageAssistedNames,_loc2_.assistTotalItems);
                  break;
               case BATTLE_EFFICIENCY_TYPES.CRITS:
                  _loc4_.setCritValues(_loc2_.criticalDevices,_loc2_.destroyedTankmen,_loc2_.destroyedDevices,_loc2_.critsCount);
                  break;
               case BATTLE_EFFICIENCY_TYPES.DESTRUCTION:
               case BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION:
                  _loc4_.killReason = _loc2_.deathReason;
                  _loc4_.arenaType = this._data.common.arenaType;
                  break;
               case BATTLE_EFFICIENCY_TYPES.ASSIST_STUN:
                  _loc4_.setBaseValues(_loc2_.stunVals,_loc2_.stunNames,_loc2_.stunTotalItems);
            }
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM,null,_loc4_);
         }
      }
      
      private function onEfficiencyListScrollHandler(param1:Event) : void
      {
         invalidate(HEADER_INVALID);
      }
   }
}
