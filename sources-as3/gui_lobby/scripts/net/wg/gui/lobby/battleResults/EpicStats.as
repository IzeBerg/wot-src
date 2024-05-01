package net.wg.gui.lobby.battleResults
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.EPICBATTLES_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.lobby.battleResults.components.AlertMessage;
   import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
   import net.wg.gui.lobby.battleResults.components.MultiColumnSubtasksList;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.EfficiencyHeaderVO;
   import net.wg.gui.lobby.battleResults.data.EpicEfficiencyData;
   import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
   import net.wg.gui.lobby.battleResults.data.PremiumInfoVO;
   import net.wg.gui.lobby.battleResults.epic.EpicQuestProgressInfo;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
   import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
   import net.wg.gui.lobby.battleResults.progressReport.ProgressReportLinkageSelector;
   import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.base.meta.IBaseDAAPIComponentMeta;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import net.wg.infrastructure.interfaces.IRegisteredComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class EpicStats extends UIComponentEx implements IViewStackContent, IRegisteredComponent
   {
      
      private static const LIST_TILE_WIDTH:uint = 150;
      
      private static const LIST_TILE_HEIGHT:uint = 64;
      
      private static const COUNTERS_SCALE:Number = 1;
      
      private static const COUNTERS_SCALE_NO_CRYSTALS:Number = 1.5;
      
      private static const CREDITS_COUNTER_TOP:int = 242;
      
      private static const CREDITS_COUNTER_TOP_NO_CRYSTALS:int = 242;
      
      private static const XP_COUNTER_TOP:int = 276;
      
      private static const XP_COUNTER_TOP_NO_CRYSTALS:int = 288;
      
      private static const CRYSTALS_COUNTER_TOP:int = 310;
      
      private static const TEXT_ICON_OFFSET:int = 10;
      
      private static const COUNTER_LEFT_OFFSET:int = -15;
      
      private static const COUNTER_LEFT_OFFSET_NO_CRYSTALS:int = 5;
      
      private static const CREDITS_ICON_TOP_OFFSET:int = 14;
      
      private static const CREDITS_ICON_TOP_OFFSET_NO_CRYSTALS:int = 25;
      
      private static const XP_ICON_TOP_OFFSET:int = 7;
      
      private static const XP_ICON_TOP_OFFSET_NO_CRYSTALS:int = 17;
      
      private static const CRYSTALS_ICON_TOP_OFFSET:int = 8;
      
      private static const DASH_ELEMENT_STRING:String = "-";
      
      private static const MIN_BTNS_WIDTH:int = 100;
      
      private static const PREMIUM_TEXTFIELD_OFFSET:int = 16;
      
      private static const PREMIUM_BUTTON_OFFSET:int = 4;
      
      private static const MODIFICATION_ICON_GAP:int = 20;
      
      private static const PREMIUM_BONUS_SEPARATOR:String = "  ";
       
      
      public var premiumBonusLabel:TextField;
      
      public var premiumCreditsXpTxt:TextField;
      
      public var getPremBtn:SoundButtonEx;
      
      public var noIncomeAlert:AlertMessage;
      
      public var creditsIcon:UILoaderAlt;
      
      public var xpIcon:UILoaderAlt;
      
      public var crystalsIcon:UILoaderAlt;
      
      public var rankIconLoader:UILoaderAlt;
      
      public var creditsCounter:CounterEx;
      
      public var crystalsCounter:CounterEx;
      
      public var xpCounter:CounterEx;
      
      public var medalsListLeft:BattleResultsMedalsList;
      
      public var medalsListRight:BattleResultsMedalsList;
      
      public var resultLbl:TextField;
      
      public var arenaNameLbl:TextField;
      
      public var arenaCreateDateLbl:TextField;
      
      public var finishReasonLbl:TextField;
      
      public var noEfficiencyLbl:TextField;
      
      public var modificationLbl:TextField;
      
      public var modificationIcon:UILoaderAlt;
      
      public var epicEfficiencyList:SimpleTileList;
      
      public var playerNameLbl:UserNameField;
      
      public var progressInfo:EpicQuestProgressInfo;
      
      public var imageSwitcher:MovieClip;
      
      private var _data:BattleResultsVO;
      
      private var _progressReport:MultiColumnSubtasksList;
      
      private var _creditsCounterNumber:Number;
      
      private var _crystalsCounterNumber:Number;
      
      private var _xpCounterNumber:Number;
      
      private var _unlocksAndQuests:Array;
      
      private var _linkageSelector:ISubtaskListLinkageSelector;
      
      private var _statsUtilsManager:IStatsUtilsManager;
      
      private var _locale:ILocale;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _register:IBaseDAAPIComponentMeta;
      
      private const RANK_IMAGE_LIST:Vector.<String> = new <String>[RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_RECRUIT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_PRIVATE,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_SERGEANT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_LIEUTENANT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_CAPTAIN,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_MAJOR,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_MSG_RANK_GENERAL];
      
      public function EpicStats()
      {
         this._linkageSelector = new ProgressReportLinkageSelector();
         this._statsUtilsManager = StatsUtilsManager.getInstance();
         this._locale = App.utils.locale;
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      private static function getEfficiencyStats(param1:EfficiencyHeaderVO) : Array
      {
         var _loc2_:Array = [];
         if(param1.spotted && param1.spotted != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_SPOTTING,param1.spotted,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSSPOTTED));
         }
         if(param1.armor && param1.armor != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_ARMOR,param1.armor,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSARMOUR));
         }
         if(param1.assist && param1.assist != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_ASSISTANCE,param1.assist,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSASSISTSPOT));
         }
         if(param1.crits && param1.crits != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_CRITS,param1.crits,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSCRITS));
         }
         if(param1.damage && param1.damage != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_DAMAGE,param1.damage,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSDAMAGE));
         }
         if(param1.kill && param1.kill != DASH_ELEMENT_STRING)
         {
            _loc2_.push(new EpicEfficiencyData(EPIC_BATTLE.BATTLERESULTS_KILL,param1.kill,RES_ICONS.MAPS_ICONS_LIBRARY_EPICEFFICIENCY_RIBBONSKILL));
         }
         return _loc2_;
      }
      
      override protected function onDispose() : void
      {
         this.getPremBtn.removeEventListener(ButtonEvent.CLICK,this.onGetPremiumBtnClickHandler);
         this.rankIconLoader.removeEventListener(MouseEvent.MOUSE_OVER,this.onRankIconLoaderMouseOverHandler);
         this.rankIconLoader.removeEventListener(MouseEvent.MOUSE_OUT,this.onRankIconLoaderMouseOutHandler);
         this.tryCleanEfficiencyListDataProvider();
         this.epicEfficiencyList.dispose();
         this.noIncomeAlert.dispose();
         this.medalsListLeft.dispose();
         this.medalsListRight.dispose();
         this.creditsCounter.dispose();
         this.crystalsCounter.dispose();
         this.xpCounter.dispose();
         this._register.unregisterFlashComponentS(EPICBATTLES_ALIASES.EPIC_BATTLES_PROGRESS_INFO_ALIAS);
         this._register = null;
         this.progressInfo = null;
         this.noIncomeAlert = null;
         this.resultLbl = null;
         this.finishReasonLbl = null;
         this.arenaNameLbl = null;
         this.noEfficiencyLbl = null;
         this.modificationLbl = null;
         this.modificationIcon.dispose();
         this.modificationIcon = null;
         this.epicEfficiencyList = null;
         this.imageSwitcher = null;
         this.medalsListLeft = null;
         this.medalsListRight = null;
         this.xpIcon.dispose();
         this.xpIcon = null;
         this.creditsIcon.dispose();
         this.creditsIcon = null;
         this.creditsCounter = null;
         this.crystalsIcon.dispose();
         this.crystalsIcon = null;
         this.crystalsCounter = null;
         this.xpCounter = null;
         this.getPremBtn.dispose();
         this.getPremBtn = null;
         this.rankIconLoader.dispose();
         this.rankIconLoader = null;
         this.playerNameLbl.dispose();
         this.playerNameLbl = null;
         this.premiumBonusLabel = null;
         this.premiumCreditsXpTxt = null;
         this.arenaCreateDateLbl = null;
         this._data = null;
         this._toolTipMgr = null;
         this._progressReport = null;
         App.instance.utils.data.cleanupDynamicObject(this._unlocksAndQuests);
         this._unlocksAndQuests = null;
         this._linkageSelector.dispose();
         this._linkageSelector = null;
         this._locale = null;
         this._statsUtilsManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.arenaCreateDateLbl.autoSize = TextFieldAutoSize.RIGHT;
         this.modificationLbl.autoSize = TextFieldAutoSize.RIGHT;
         this.epicEfficiencyList.visible = false;
         this.xpIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_XPICONBIG_1;
         this.creditsIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_CREDITSICONBIG_1;
         this.crystalsIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_CRYSTAL_48X48;
         this.epicEfficiencyList.itemRenderer = App.utils.classFactory.getClass(Linkages.LINK_EPIC_EFFICIENCY_ITEM_RENDERER);
         this.epicEfficiencyList.tileWidth = LIST_TILE_WIDTH;
         this.epicEfficiencyList.tileHeight = LIST_TILE_HEIGHT;
         this.epicEfficiencyList.directionMode = DirectionMode.HORIZONTAL;
         this.epicEfficiencyList.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.getPremBtn.label = BATTLE_RESULTS.COMMON_DETAILS_GETPREMBTN;
         this.getPremBtn.autoSize = TextFieldAutoSize.LEFT;
         this.getPremBtn.minWidth = MIN_BTNS_WIDTH;
         this.getPremBtn.addEventListener(ButtonEvent.CLICK,this.onGetPremiumBtnClickHandler);
         this.rankIconLoader.addEventListener(MouseEvent.MOUSE_OVER,this.onRankIconLoaderMouseOverHandler);
         this.rankIconLoader.addEventListener(MouseEvent.MOUSE_OUT,this.onRankIconLoaderMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:PersonalDataVO = null;
         var _loc2_:CommonStatsVO = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:PremiumInfoVO = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.personal;
            _loc2_ = this._data.common;
            _loc3_ = AwardExtractor.extract(this._data.quests);
            _loc4_ = this._data.unlocks;
            _loc5_ = 0;
            _loc6_ = _loc1_.premiumInfo;
            this._unlocksAndQuests = this._statsUtilsManager.mergeArrays(_loc4_,_loc3_);
            this.initCounters(_loc1_.creditsStr,_loc1_.xpStr,_loc1_.crystalStr);
            this.initResultText(_loc2_);
            this.imageSwitcher.gotoAndStop(_loc2_.resultShortStr);
            this.arenaNameLbl.htmlText = _loc2_.arenaStr;
            this.arenaCreateDateLbl.text = _loc2_.arenaCreateTimeStr;
            this.arenaNameLbl.x = this.arenaCreateDateLbl.x - this.arenaNameLbl.width | 0;
            _loc7_ = StringUtils.isNotEmpty(_loc2_.modificationStr);
            if(_loc7_)
            {
               this.modificationLbl.htmlText = _loc2_.modificationStr;
               this.modificationIcon.source = _loc2_.modificationIconPath;
               this.modificationIcon.x = this.modificationLbl.x - MODIFICATION_ICON_GAP >> 0;
            }
            this.modificationIcon.visible = this.modificationLbl.visible = _loc7_;
            this.tryCleanMedalListDataProviders();
            this.medalsListLeft.dataProvider = new DataProvider(_loc1_.achievementsLeft);
            this.medalsListRight.dataProvider = new DataProvider(_loc1_.achievementsRight);
            this.getPremBtn.visible = _loc6_.isGetPremium || _loc6_.isUpgradeToPremiumPlus;
            this.getPremBtn.validateNow();
            this.premiumCreditsXpTxt.visible = _loc6_.isGetPremium;
            this.premiumBonusLabel.visible = _loc6_.isGetPremium || _loc6_.isUpgradeToPremiumPlus;
            if(_loc6_.isGetPremium)
            {
               this.premiumBonusLabel.htmlText = _loc6_.premiumBonusStr;
               this.premiumCreditsXpTxt.htmlText = _loc6_.creditsPremiumBonusStr + PREMIUM_BONUS_SEPARATOR + _loc6_.xpPremiumBonusStr;
               App.utils.commons.updateTextFieldSize(this.premiumBonusLabel);
               App.utils.commons.updateTextFieldSize(this.premiumCreditsXpTxt);
               _loc5_ = this.premiumBonusLabel.width + PREMIUM_TEXTFIELD_OFFSET + this.premiumCreditsXpTxt.width + PREMIUM_BUTTON_OFFSET + this.getPremBtn.width;
               this.premiumBonusLabel.x = width - _loc5_ >> 1;
               this.premiumCreditsXpTxt.x = this.premiumBonusLabel.x + this.premiumBonusLabel.width + PREMIUM_TEXTFIELD_OFFSET | 0;
               this.getPremBtn.x = this.premiumCreditsXpTxt.x + this.premiumCreditsXpTxt.width + PREMIUM_BUTTON_OFFSET | 0;
            }
            else if(_loc6_.isUpgradeToPremiumPlus)
            {
               this.premiumBonusLabel.htmlText = _loc6_.premiumBonusStr;
               App.utils.commons.updateTextFieldSize(this.premiumBonusLabel);
               _loc5_ = this.premiumBonusLabel.width + PREMIUM_TEXTFIELD_OFFSET + this.getPremBtn.width;
               this.premiumBonusLabel.x = width - _loc5_ >> 1;
               this.getPremBtn.x = this.premiumBonusLabel.x + this.premiumBonusLabel.width + PREMIUM_TEXTFIELD_OFFSET | 0;
            }
            _loc8_ = _loc1_.showNoIncomeAlert;
            this.setNoIncomeVisible(_loc8_);
            if(_loc8_)
            {
               this.noIncomeAlert.setData(_loc1_.noIncomeAlert);
            }
            this.rankIconLoader.source = this.RANK_IMAGE_LIST[_loc1_.playerRank];
            this.playerNameLbl.userVO = new UserVO({
               "userName":_loc2_.playerRealNameStr,
               "clanAbbrev":_loc2_.clanNameStr,
               "fullName":_loc2_.playerFullNameStr,
               "region":_loc2_.regionNameStr
            });
            this.initEfficiencyList(_loc1_.efficiencyHeader);
            this.medalsListLeft.invalidateData();
            this.medalsListRight.invalidateData();
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
      
      public function registerFlashComponentVia(param1:IBaseDAAPIComponentMeta) : void
      {
         if(!param1.isFlashComponentRegisteredS(EPICBATTLES_ALIASES.EPIC_BATTLES_PROGRESS_INFO_ALIAS))
         {
            this._register = param1;
            param1.registerFlashComponentS(this.progressInfo,EPICBATTLES_ALIASES.EPIC_BATTLES_PROGRESS_INFO_ALIAS);
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = BattleResultsVO(param1);
         invalidateData();
      }
      
      private function initResultText(param1:CommonStatsVO) : void
      {
         var _loc2_:Boolean = !param1.overtime.enabled;
         this.resultLbl.text = param1.resultStr;
         this.finishReasonLbl.visible = _loc2_;
         if(_loc2_)
         {
            this.finishReasonLbl.text = param1.finishReasonStr;
         }
      }
      
      private function showEfficiencyList() : void
      {
         this.epicEfficiencyList.visible = true;
      }
      
      private function tryCleanEfficiencyListDataProvider() : void
      {
         if(this.epicEfficiencyList.dataProvider != null)
         {
            this.epicEfficiencyList.dataProvider.cleanUp();
         }
      }
      
      private function tryCleanMedalListDataProviders() : void
      {
         if(this.medalsListLeft.dataProvider != null)
         {
            this.medalsListLeft.dataProvider.cleanUp();
            this.medalsListLeft.dataProvider = null;
         }
         if(this.medalsListRight.dataProvider != null)
         {
            this.medalsListRight.dataProvider.cleanUp();
            this.medalsListRight.dataProvider = null;
         }
      }
      
      private function initCounters(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:IFormattedInt = null;
         var _loc5_:Boolean = false;
         _loc4_ = this._locale.parseFormattedInteger(param3);
         _loc5_ = _loc4_.value > 0;
         var _loc6_:IFormattedInt = this._locale.parseFormattedInteger(param1);
         this.creditsCounter.init(_loc6_.value,param1,_loc6_.delimiter,this._creditsCounterNumber != _loc6_.value);
         this._creditsCounterNumber = _loc6_.value;
         var _loc7_:IFormattedInt = this._locale.parseFormattedInteger(param2);
         this.xpCounter.init(_loc7_.value,this._locale.cutCharsBeforeNumber(param2),_loc7_.delimiter,this._xpCounterNumber != _loc7_.value);
         this._xpCounterNumber = _loc7_.value;
         var _loc8_:Number = !!_loc5_ ? Number(COUNTERS_SCALE) : Number(COUNTERS_SCALE_NO_CRYSTALS);
         var _loc9_:int = !!_loc5_ ? int(COUNTER_LEFT_OFFSET) : int(COUNTER_LEFT_OFFSET_NO_CRYSTALS);
         if(_loc5_)
         {
            this.crystalsCounter.init(_loc4_.value,param3,_loc4_.delimiter,this._crystalsCounterNumber == _loc4_.value);
            this._crystalsCounterNumber = _loc4_.value;
            this.creditsCounter.y = CREDITS_COUNTER_TOP;
            this.creditsIcon.y = this.creditsCounter.y + CREDITS_ICON_TOP_OFFSET;
            this.xpCounter.y = XP_COUNTER_TOP;
            this.xpIcon.y = this.xpCounter.y + XP_ICON_TOP_OFFSET;
            this.crystalsCounter.y = CRYSTALS_COUNTER_TOP;
            this.crystalsIcon.y = this.crystalsCounter.y + CRYSTALS_ICON_TOP_OFFSET;
            this.crystalsCounter.x = (this.imageSwitcher.width + this.crystalsCounter.metricsWidth >> 1) + _loc9_;
            this.crystalsIcon.x = this.crystalsCounter.x + TEXT_ICON_OFFSET;
         }
         else
         {
            this.creditsCounter.y = CREDITS_COUNTER_TOP_NO_CRYSTALS;
            this.creditsIcon.y = this.creditsCounter.y + CREDITS_ICON_TOP_OFFSET_NO_CRYSTALS;
            this.xpCounter.y = XP_COUNTER_TOP_NO_CRYSTALS;
            this.xpIcon.y = this.xpCounter.y + XP_ICON_TOP_OFFSET_NO_CRYSTALS;
         }
         this.creditsIcon.x = this.creditsCounter.x = (this.imageSwitcher.width + this.creditsCounter.metricsWidth >> 1) + _loc9_;
         this.creditsIcon.x += TEXT_ICON_OFFSET;
         this.xpIcon.x = this.xpCounter.x = (this.imageSwitcher.width + this.xpCounter.metricsWidth >> 1) + _loc9_;
         this.xpIcon.x += TEXT_ICON_OFFSET;
         this.crystalsIcon.visible = _loc5_;
         this.crystalsCounter.visible = _loc5_;
         this.creditsCounter.scaleX = this.creditsCounter.scaleY = _loc8_;
         this.crystalsCounter.scaleX = this.crystalsCounter.scaleY = _loc8_;
         this.xpCounter.scaleX = this.xpCounter.scaleY = _loc8_;
      }
      
      private function setNoIncomeVisible(param1:Boolean) : void
      {
         this.noIncomeAlert.visible = param1;
         var _loc2_:Boolean = !param1;
         if(this._progressReport != null)
         {
            this._progressReport.visible = _loc2_;
         }
      }
      
      private function initEfficiencyList(param1:EfficiencyHeaderVO) : void
      {
         if(param1)
         {
            this.tryCleanEfficiencyListDataProvider();
            this.epicEfficiencyList.dataProvider = new DataProvider(getEfficiencyStats(param1));
            App.utils.scheduler.scheduleOnNextFrame(this.showEfficiencyList);
         }
         else
         {
            this.epicEfficiencyList.visible = false;
         }
      }
      
      private function onRankIconLoaderMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onRankIconLoaderMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FRONTLINE_RANK,null,this._data.personal.playerRank);
      }
      
      private function onGetPremiumBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_DETAILS_PREMIUM));
      }
   }
}
