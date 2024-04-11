package net.wg.gui.lobby.header
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.Aliases;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.FightButton;
   import net.wg.gui.components.controls.MainMenuButton;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.tooltips.ToolTipComplex;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.header.events.HeaderEvents;
   import net.wg.gui.lobby.header.events.PersonalReservesWidgetEvent;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
   import net.wg.gui.lobby.header.interfaces.ILobbyHeader;
   import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
   import net.wg.gui.lobby.header.rankedBattles.SparkAnim;
   import net.wg.gui.lobby.header.vo.AccountDataVo;
   import net.wg.gui.lobby.header.vo.ExtendedSquadInfoVo;
   import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
   import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
   import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
   import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
   import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
   import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
   import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
   import net.wg.gui.lobby.header.vo.HBC_WotPlusDataVO;
   import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
   import net.wg.gui.lobby.header.vo.HeaderButtonVo;
   import net.wg.gui.tutorial.components.TutorialClip;
   import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.IUtils;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Constraints;
   
   public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeader, IStageSizeDependComponent
   {
      
      public static const NARROW_SCREEN:String = "narrowScreen";
      
      public static const WIDE_SCREEN:String = "wideScreen";
      
      public static const MAX_SCREEN:String = "maxScreen";
      
      private static const NARROW_SCREEN_SIZE:int = 1024;
      
      private static const WIDE_SCREEN_SIZE:int = 1280;
      
      private static const MAX_SCREEN_SIZE:int = 1600;
      
      private static const BUBBLE_TOOLTIP_X:int = 16;
      
      private static const BUBBLE_TOOLTIP_Y:int = 7;
      
      private static const EMPTY_ACTION:String = Values.EMPTY_STR;
      
      private static const SPARKS_OFFSET_X:int = 50;
      
      private static const SPARKS_OFFSET_Y:int = -10;
      
      private static const OPTIMIZE_OFFSET:int = 10;
      
      private static const BG_OVERLAY_ONLY:uint = 1;
      
      private static const BUTTON_BAR_ONLY:uint = 2;
      
      private static const ONLINE_COUNTER_ONLY:uint = 4;
       
      
      public var centerBg:TutorialClip = null;
      
      public var centerMenuBg:TutorialClip = null;
      
      public var resizeBg:Sprite = null;
      
      public var sparks:SparkAnim = null;
      
      public var mainMenuGradient:TutorialClip = null;
      
      public var fightBtn:FightButton;
      
      public var mainMenuButtonBar:MainMenuButtonBar;
      
      public var headerButtonBar:HeaderButtonBar;
      
      public var onlineCounter:OnlineCounter;
      
      private var _headerButtonsHelper:HeaderButtonsHelper;
      
      private var _bubbleTooltip:ToolTipComplex;
      
      private var _actualEnabledVal:Boolean;
      
      private var _isInCoolDown:Boolean = false;
      
      private var _fightBtnTooltipStr:String = "";
      
      private var _isFigthButtonSpecialTooltip:Boolean = false;
      
      private var _utils:IUtils = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _canShowSquad:Boolean = false;
      
      private var _isFullscreenBattleSelectorVisible:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _squadId:String = "squad";
      
      public function LobbyHeader()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this._utils = App.utils;
         this._counterManager = this._utils.counterManager;
         this._scheduler = this._utils.scheduler;
         this._headerButtonsHelper = new HeaderButtonsHelper(this.headerButtonBar);
         App.stageSizeMgr.register(this);
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible)
         {
            return null;
         }
         var _loc1_:Rectangle = this.resizeBg.getBounds(App.stage);
         _loc1_.width = App.appWidth;
         _loc1_.height -= OPTIMIZE_OFFSET;
         return new <Rectangle>[_loc1_];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.centerBg.name,this.centerBg,Constraints.CENTER_H);
         constraints.addElement(this.centerMenuBg.name,this.centerMenuBg,Constraints.CENTER_H);
         constraints.addElement(this.resizeBg.name,this.resizeBg,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement(this.fightBtn.name,this.fightBtn,Constraints.CENTER_H);
         constraints.addElement(this.mainMenuButtonBar.name,this.mainMenuButtonBar,Constraints.CENTER_H);
         constraints.addElement(this.mainMenuGradient.name,this.mainMenuGradient,Constraints.CENTER_H);
         this.centerBg.mouseChildren = this.centerBg.mouseEnabled = false;
         this.centerMenuBg.mouseChildren = this.centerMenuBg.mouseEnabled = false;
         this.mainMenuGradient.mouseEnabled = false;
         this.mainMenuGradient.mouseChildren = false;
         this.hitArea = this.resizeBg;
         this.updateSize();
         this._headerButtonsHelper.invalidateAllData();
         this.fightBtn.addEventListener(ButtonEvent.CLICK,this.onFightBtnClickHandler);
         this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
         this.mainMenuButtonBar.addEventListener(ButtonEvent.CLICK,this.onMainMenuButtonBarClickHandler,false,0,true);
         this.headerButtonBar.addEventListener(ButtonEvent.CLICK,this.onHeaderButtonBarClickHandler,false,0,true);
         this.headerButtonBar.addEventListener(ButtonEvent.PRESS,this.onHeaderButtonBarPressHandler,false,0,true);
         this.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION,this.onButtonBarHeaderItemsRepositionHandler);
         this.headerButtonBar.addEventListener(PersonalReservesWidgetEvent.CREATED,this.onPersonalReserveWidgetCreated,false,0,true);
         this.fightBtn.mouseEnabledOnDisabled = true;
         _deferredDispose = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(width,height);
            this.updateSize();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.disposeBubbleToolTip();
         this.mainMenuButtonBar.removeEventListener(ButtonEvent.CLICK,this.onMainMenuButtonBarClickHandler);
         this.headerButtonBar.removeEventListener(ButtonEvent.CLICK,this.onHeaderButtonBarClickHandler);
         this.headerButtonBar.removeEventListener(ButtonEvent.PRESS,this.onHeaderButtonBarPressHandler);
         this.headerButtonBar.removeEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION,this.onButtonBarHeaderItemsRepositionHandler);
         this.headerButtonBar.removeEventListener(PersonalReservesWidgetEvent.CREATED,this.onPersonalReserveWidgetCreated);
         this.fightBtn.removeEventListener(ButtonEvent.CLICK,this.onFightBtnClickHandler);
         this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
         this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
         this.unregisterPR2WidgetBtn();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.sparks = null;
         this._scheduler.cancelTask(this.stopReadyCoolDown);
         var _loc1_:int = this.mainMenuButtonBar.dataProvider.length;
         var _loc2_:MainMenuButton = null;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this.mainMenuButtonBar.getButtonAt(_loc3_) as MainMenuButton;
            this._counterManager.removeCounter(_loc2_.fxTextField1);
            _loc3_++;
         }
         this.mainMenuButtonBar.dispose();
         this.mainMenuButtonBar = null;
         this.headerButtonBar.dispose();
         this.headerButtonBar = null;
         this.fightBtn.dispose();
         this.fightBtn = null;
         this._headerButtonsHelper.dispose();
         this._headerButtonsHelper = null;
         this.onlineCounter.dispose();
         this.onlineCounter = null;
         this.mainMenuGradient.dispose();
         this.mainMenuGradient = null;
         this.resizeBg = null;
         this.centerBg.dispose();
         this.centerBg = null;
         this.centerMenuBg.dispose();
         this.centerMenuBg = null;
         constraints.dispose();
         constraints = null;
         this._counterManager = null;
         this._scheduler = null;
         this._utils = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function setHangarMenuData(param1:DataProvider) : void
      {
         var _loc2_:HangarMenuTabItemVO = null;
         for each(_loc2_ in param1)
         {
            if(this.mainMenuButtonBar.getButtonByValue(_loc2_.value))
            {
               this.removeButtonCounter(_loc2_.value);
            }
         }
         this.mainMenuButtonBar.dataProvider = param1;
         this.mainMenuButtonBar.validateNow();
      }
      
      override protected function setHeaderButtons(param1:Vector.<String>) : void
      {
         this._headerButtonsHelper.setupButtons(param1);
      }
      
      override protected function nameResponse(param1:AccountDataVo) : void
      {
         var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
         if(_loc2_ != null)
         {
            if(param1.userVO != null)
            {
               if(_loc2_.userVO != null)
               {
                  _loc2_.userVO.dispose();
               }
               _loc2_.userVO = new UserVO({
                  "fullName":param1.userVO.fullName,
                  "userName":param1.userVO.userName,
                  "clanAbbrev":param1.userVO.clanAbbrev
               });
            }
            _loc2_.isTeamKiller = param1.isTeamKiller;
            _loc2_.isWarningIconVisible = param1.isWarningIconVisible;
            _loc2_.isWotPlusEnabled = param1.isWotPlusEnabled;
            _loc2_.tooltip = param1.tooltip;
            _loc2_.tooltipType = param1.tooltipType;
            _loc2_.tooltipArgs = param1.tooltipArgs;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
         }
      }
      
      override protected function updateWalletBtn(param1:String, param2:HBC_FinanceVo) : void
      {
         this._headerButtonsHelper.setContentData(param1,param2);
      }
      
      override protected function setWotPlusData(param1:HBC_WotPlusDataVO) : void
      {
         var _loc2_:HBC_WotPlusDataVO = HBC_WotPlusDataVO(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_WOT_PLUS));
         if(_loc2_)
         {
            _loc2_.wotPlusIcon = param1.wotPlusIcon;
            _loc2_.label = param1.label;
            _loc2_.state = param1.state;
            _loc2_.showAsNew = param1.showAsNew;
            _loc2_.tooltip = param1.tooltip;
            _loc2_.tooltipType = param1.tooltipType;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_WOT_PLUS);
         }
      }
      
      override protected function setPremiumParams(param1:HBC_PremDataVo) : void
      {
         var _loc2_:HBC_PremDataVo = HBC_PremDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREM));
         if(_loc2_)
         {
            _loc2_.btnLabel = param1.btnLabel;
            _loc2_.btnLabelShort = param1.btnLabelShort;
            _loc2_.doLabel = param1.doLabel;
            _loc2_.timeLabel = param1.timeLabel;
            _loc2_.isHasAction = param1.isHasAction;
            _loc2_.isPremium = param1.isPremium;
            _loc2_.isSubscription = param1.isSubscription;
            _loc2_.premiumIcon = param1.premiumIcon;
            _loc2_.isWotPlusEnabled = param1.isWotPlusEnabled;
            _loc2_.tooltip = param1.tooltip;
            _loc2_.tooltipType = param1.tooltipType;
            _loc2_.tooltipArgs = param1.tooltipArgs;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREM);
         }
      }
      
      override protected function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         var _loc3_:HBC_AccountDataVo = this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT) as HBC_AccountDataVo;
         if(_loc3_ != null)
         {
            _loc3_.badgeVO = param1;
            _loc3_.selectedBadge = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
         }
      }
      
      override protected function updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String, param6:Boolean, param7:ExtendedSquadInfoVo) : void
      {
         this._squadId = !!this._headerButtonsHelper.hasDataProviderButtonById(HeaderButtonsHelper.ITEM_ID_SQUAD) ? HeaderButtonsHelper.ITEM_ID_SQUAD : HeaderButtonsHelper.ITEM_ID_HBSQUAD;
         var _loc8_:HBC_SquadDataVo = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(this._squadId));
         _loc8_.isInSquad = param1;
         _loc8_.tooltip = param2;
         _loc8_.tooltipType = param3;
         _loc8_.isEvent = param4;
         _loc8_.icon = param5;
         _loc8_.hasPopover = param6;
         if(_loc8_.squadExtendInfoVo != null)
         {
            _loc8_.squadExtendInfoVo.dispose();
         }
         _loc8_.squadExtendInfoVo = new ExtendedSquadInfoVo({
            "platoonState":param7.platoonState,
            "squadManStates":param7.squadManStates,
            "commanderIndex":param7.commanderIndex
         });
         this._headerButtonsHelper.invalidateDataById(this._squadId);
      }
      
      public function as_disableFightButton(param1:Boolean) : void
      {
         this._actualEnabledVal = !param1;
         this.fightBtn.enabled = !this._isInCoolDown ? Boolean(this._actualEnabledVal) : Boolean(!this._isInCoolDown);
         this.fightBtn.validateNow();
      }
      
      public function as_doDeselectHeaderButton(param1:String) : void
      {
         this.mainMenuButtonBar.deselectHeaderButton(param1);
      }
      
      public function as_doDisableHeaderButton(param1:String, param2:Boolean) : void
      {
         this._headerButtonsHelper.setButtonEnabled(param1,param2);
      }
      
      public function as_doDisableNavigation() : void
      {
         this.mainMenuButtonBar.setDisableNav(true);
      }
      
      public function as_doSoftDisableHeaderButton(param1:String, param2:Boolean) : void
      {
         this._headerButtonsHelper.setButtonSoftDisable(param1,param2);
      }
      
      public function as_hideMenu(param1:Boolean) : void
      {
         this.centerMenuBg.visible = !param1;
         this.onlineCounter.visible = !param1;
         this.mainMenuGradient.visible = !param1;
         this.mainMenuButtonBar.visible = !param1;
      }
      
      public function as_initOnlineCounter(param1:Boolean) : void
      {
         this.onlineCounter.initVisible(param1);
      }
      
      public function as_removeButtonCounter(param1:String) : void
      {
         this.removeButtonCounter(param1);
      }
      
      public function as_setButtonCounter(param1:String, param2:String) : void
      {
         var _loc3_:MainMenuButton = this.mainMenuButtonBar.getButtonByValue(param1);
         if(_loc3_ == null)
         {
            this.mainMenuButtonBar.validateNow();
            _loc3_ = this.mainMenuButtonBar.getButtonByValue(param1);
         }
         this.assertMainMenuButtonWasntFound(_loc3_,param1);
         this._counterManager.setCounter(_loc3_.hitMc,param2);
      }
      
      public function as_setButtonHighlight(param1:String, param2:Boolean) : void
      {
         var _loc3_:MainMenuButton = this.mainMenuButtonBar.getButtonByValue(param1);
         if(_loc3_ == null)
         {
            this.mainMenuButtonBar.validateNow();
            _loc3_ = this.mainMenuButtonBar.getButtonByValue(param1);
         }
         this.assertMainMenuButtonWasntFound(_loc3_,param1);
         _loc3_.isHighlighted = param2;
      }
      
      public function as_setCoolDownForReady(param1:uint) : void
      {
         this._isInCoolDown = true;
         this._scheduler.cancelTask(this.stopReadyCoolDown);
         this.fightBtn.enabled = false;
         this._scheduler.scheduleTask(this.stopReadyCoolDown,param1 * 1000);
      }
      
      public function as_setFightBtnTooltip(param1:String, param2:Boolean) : void
      {
         if(StringUtils.isNotEmpty(param1))
         {
            this._fightBtnTooltipStr = param1;
            this._isFigthButtonSpecialTooltip = param2;
            this.fightBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
            this.fightBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
         }
         else
         {
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
         }
      }
      
      public function as_setFightButton(param1:String) : void
      {
         this.fightBtn.label = param1;
         this.fightBtn.validateNow();
      }
      
      public function as_setGoldFishEnabled(param1:Boolean, param2:Boolean, param3:String, param4:String) : void
      {
         var _loc5_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(CURRENCIES_CONSTANTS.GOLD));
         if(_loc5_)
         {
            _loc5_.isDiscountEnabled = param1;
            _loc5_.playDiscountAnimation = param2;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.GOLD);
         }
      }
      
      public function as_setIsFullscreenBattleSelectorShowing(param1:Boolean) : void
      {
         var _loc2_:HeaderButton = this._headerButtonsHelper.searchButtonById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
         if(_loc2_ != null)
         {
            if(param1)
            {
               _loc2_.onPopoverOpen();
            }
            else
            {
               _loc2_.onPopoverClose();
            }
         }
         this._isFullscreenBattleSelectorVisible = param1;
      }
      
      public function as_setIsPlatoonDropdownShowing(param1:Boolean) : void
      {
         var _loc2_:HeaderButton = this._headerButtonsHelper.searchButtonById(this._squadId);
         if(_loc2_ != null)
         {
            if(param1)
            {
               _loc2_.onPopoverOpen();
            }
            else
            {
               _loc2_.onPopoverClose();
            }
         }
         this._canShowSquad = false;
      }
      
      public function as_setPremShopData(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:HBC_PremShopVO = HBC_PremShopVO(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP));
         if(_loc5_)
         {
            _loc5_.iconSrc = param1;
            _loc5_.premShopText = param2;
            _loc5_.tooltip = param3;
            _loc5_.tooltipType = param4;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP);
         }
      }
      
      public function as_setScreen(param1:String) : void
      {
         this.mainMenuButtonBar.setDisableNav(false);
         this.mainMenuButtonBar.setCurrent(param1);
      }
      
      public function as_setServer(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
         if(_loc4_)
         {
            _loc4_.serverName = param1;
            _loc4_.tooltip = param2;
            _loc4_.tooltipType = param3;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
         }
      }
      
      public function as_setServerName(param1:String) : void
      {
         this.onlineCounter.setServerName(param1);
      }
      
      public function as_setWalletStatus(param1:Object) : void
      {
         this._utils.voMgr.walletStatusVO.update(param1);
         this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.GOLD);
         this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.FREE_XP);
         this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.CRYSTAL);
      }
      
      public function as_showBubbleTooltip(param1:String, param2:int) : void
      {
         this.disposeBubbleToolTip();
         var _loc3_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,BUBBLE_TOOLTIP_X,BUBBLE_TOOLTIP_Y);
         this._bubbleTooltip = this._utils.classFactory.getComponent(Linkages.TOOL_TIP_COMPLEX,ToolTipComplex);
         parent.addChild(this._bubbleTooltip);
         this._bubbleTooltip.build(param1,_loc3_);
         this._scheduler.scheduleTask(this.hideBubbleTooltip,param2);
      }
      
      public function as_toggleVisibilityMenu(param1:uint) : void
      {
         this.mainMenuGradient.visible = this.centerMenuBg.visible = Boolean(param1 & BG_OVERLAY_ONLY);
         this.mainMenuButtonBar.visible = Boolean(param1 & BUTTON_BAR_ONLY);
         this.onlineCounter.visible = Boolean(param1 & ONLINE_COUNTER_ONLY);
      }
      
      public function as_updateAnonymizedState(param1:Boolean) : void
      {
         var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
         if(_loc2_ != null)
         {
            _loc2_.isAnonymized = param1;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
         }
      }
      
      public function as_updateBattleType(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : void
      {
         var _loc11_:HBC_BattleTypeVo = HBC_BattleTypeVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR));
         if(_loc11_)
         {
            _loc11_.battleTypeName = param1;
            _loc11_.battleTypeIcon = param2;
            _loc11_.battleTypeID = param6;
            _loc11_.tooltip = param4;
            _loc11_.tooltipType = param5;
            _loc11_.eventBgEnabled = param7;
            _loc11_.showLegacySelector = param9;
            _loc11_.hasNew = param10;
            if(param8)
            {
               this.sparks.play();
            }
            else
            {
               this.sparks.stop();
            }
            this.sparks.visible = param8;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
            this.as_doDisableHeaderButton(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR,param3);
         }
      }
      
      public function as_updateOnlineCounter(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         this.onlineCounter.updateCount(param1,param2,param3,param4);
      }
      
      public function as_updatePingStatus(param1:int, param2:Boolean) : void
      {
         var _loc3_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
         if(_loc3_)
         {
            _loc3_.pingStatus = param1;
            _loc3_.isColorBlind = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
         }
      }
      
      public function getTabRenderer(param1:String) : HeaderButton
      {
         var _loc2_:IDataProvider = this.headerButtonBar.dataProvider;
         var _loc3_:HeaderButtonVo = null;
         var _loc4_:int = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = HeaderButtonVo(_loc2_.requestItemAt(_loc5_));
            if(_loc3_.id == param1)
            {
               return HeaderButton(this.headerButtonBar.getButtonAt(_loc5_));
            }
            _loc5_++;
         }
         return null;
      }
      
      public function setHeaderButtonsHelper(param1:HeaderButtonsHelper) : void
      {
         if(this._headerButtonsHelper != null)
         {
            this._headerButtonsHelper.dispose();
         }
         this._headerButtonsHelper = param1;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.mainMenuButtonBar.isSmallWidth = param1 < StageSizeBoundaries.WIDTH_1366;
      }
      
      private function removeButtonCounter(param1:String) : void
      {
         var _loc2_:MainMenuButton = this.mainMenuButtonBar.getButtonByValue(param1);
         this.assertMainMenuButtonWasntFound(_loc2_,param1);
         this._counterManager.removeCounter(_loc2_.hitMc);
      }
      
      private function assertMainMenuButtonWasntFound(param1:Button, param2:String) : void
      {
         this._utils.asserter.assertNotNull(param1,"Main menu button alias:" + param2 + Errors.WASNT_FOUND);
      }
      
      private function updateSize() : void
      {
         this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
         var _loc1_:String = WIDE_SCREEN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = App.appWidth;
         if(_loc4_ <= NARROW_SCREEN_SIZE)
         {
            _loc1_ = NARROW_SCREEN;
         }
         else if(_loc4_ >= WIDE_SCREEN_SIZE)
         {
            _loc1_ = MAX_SCREEN;
            _loc2_ = 1;
            _loc3_ = Math.min((_loc4_ - WIDE_SCREEN_SIZE) / (MAX_SCREEN_SIZE - WIDE_SCREEN_SIZE),1);
         }
         else
         {
            _loc2_ = Math.min((_loc4_ - NARROW_SCREEN_SIZE) / (WIDE_SCREEN_SIZE - NARROW_SCREEN_SIZE),1);
         }
         this.headerButtonBar.updateScreen(_loc1_,_loc4_,_loc2_,_loc3_);
         this.sparks.x = this.fightBtn.x + SPARKS_OFFSET_X;
         this.sparks.y = this.fightBtn.y + SPARKS_OFFSET_Y;
         movePlatoonPopoverS(this.getSquadButtonMiddleXPosition(this._headerButtonsHelper.searchButtonById(this._squadId)));
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      private function stopReadyCoolDown() : void
      {
         this.fightBtn.enabled = this._actualEnabledVal;
         this._isInCoolDown = false;
      }
      
      private function disposeBubbleToolTip() : void
      {
         if(this._bubbleTooltip)
         {
            this._scheduler.cancelTask(this.hideBubbleTooltip);
            this._utils.tweenAnimator.removeAnims(this._bubbleTooltip);
            parent.removeChild(this._bubbleTooltip);
            this._bubbleTooltip.dispose();
            this._bubbleTooltip = null;
         }
      }
      
      private function hideBubbleTooltip() : void
      {
         if(this._bubbleTooltip)
         {
            this._utils.tweenAnimator.addFadeOutAnim(this._bubbleTooltip,null);
         }
      }
      
      private function getSquadButtonMiddleXPosition(param1:HeaderButton) : int
      {
         if(param1 != null)
         {
            return width - this.fightBtn.hitMc.width - param1.width >> 1;
         }
         return 0;
      }
      
      private function unregisterPR2WidgetBtn() : void
      {
         if(isFlashComponentRegisteredS(HANGAR_ALIASES.PERSONAL_RESERVES_WIDGET_INJECT))
         {
            unregisterFlashComponentS(HANGAR_ALIASES.PERSONAL_RESERVES_WIDGET_INJECT);
         }
      }
      
      private function onHeaderButtonBarPressHandler(param1:ButtonEvent) : void
      {
         var _loc4_:HBC_SquadDataVo = null;
         var _loc2_:HeaderButton = HeaderButton(param1.target);
         var _loc3_:HeaderButtonVo = HeaderButtonVo(_loc2_.data);
         if(_loc3_.id == this._squadId)
         {
            _loc4_ = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(this._squadId));
            if(!_loc4_.isEvent)
            {
               this._canShowSquad = true;
            }
         }
      }
      
      private function onHeaderButtonBarClickHandler(param1:ButtonEvent) : void
      {
         var _loc4_:HBC_SquadDataVo = null;
         var _loc5_:HBC_BattleTypeVo = null;
         var _loc2_:HeaderButton = HeaderButton(param1.target);
         var _loc3_:HeaderButtonVo = HeaderButtonVo(_loc2_.data);
         switch(_loc3_.id)
         {
            case HeaderButtonsHelper.ITEM_ID_SETTINGS:
               showLobbyMenuS();
               break;
            case HeaderButtonsHelper.ITEM_ID_ACCOUNT:
               showDashboardS();
               break;
            case HeaderButtonsHelper.ITEM_ID_WOT_PLUS:
               showWotPlusViewS();
               break;
            case HeaderButtonsHelper.ITEM_ID_PREM:
               showPremiumViewS();
               break;
            case HeaderButtonsHelper.ITEM_ID_PREMSHOP:
               onPremShopClickS();
               break;
            case this._squadId:
               _loc4_ = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(this._squadId));
               if(_loc4_.isEvent)
               {
                  App.popoverMgr.show(_loc2_,Aliases.SQUAD_TYPE_SELECT_POPOVER,null,_loc2_);
               }
               else
               {
                  if(this._canShowSquad)
                  {
                     showSquadS(this.getSquadButtonMiddleXPosition(_loc2_));
                  }
                  this._canShowSquad = false;
               }
               break;
            case HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR:
               _loc5_ = HBC_BattleTypeVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR));
               if(_loc5_)
               {
                  if(_loc5_.showLegacySelector)
                  {
                     App.popoverMgr.show(_loc2_,Aliases.BATTLE_TYPE_SELECT_POPOVER,null,_loc2_);
                  }
                  else if(this._isFullscreenBattleSelectorVisible)
                  {
                     closeFullscreenBattleSelectorS();
                  }
                  else
                  {
                     openFullscreenBattleSelectorS();
                  }
               }
               break;
            case CURRENCIES_CONSTANTS.GOLD:
               onPaymentS();
               break;
            case CURRENCIES_CONSTANTS.CREDITS:
               showExchangeWindowS();
               break;
            case CURRENCIES_CONSTANTS.FREE_XP:
               showExchangeXPWindowS();
               break;
            case CURRENCIES_CONSTANTS.CRYSTAL:
               onCrystalClickS();
               break;
            case HeaderButtonsHelper.ITEM_ID_PERSONAL_RESERVES_WIDGET:
               onReservesClickS();
         }
      }
      
      private function onMainMenuButtonBarClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
         var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_loc2_.data);
         if(_loc3_ != null)
         {
            menuItemClickS(_loc3_.value);
         }
      }
      
      private function onFightBtnClickHandler(param1:ButtonEvent) : void
      {
         fightClickS(0,EMPTY_ACTION);
      }
      
      private function onFightBtnMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onButtonBarHeaderItemsRepositionHandler(param1:HeaderEvents) : void
      {
         movePlatoonPopoverS(this.getSquadButtonMiddleXPosition(this._headerButtonsHelper.searchButtonById(this._squadId)));
      }
      
      private function onFightBtnMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._isFigthButtonSpecialTooltip)
         {
            this._tooltipMgr.showSpecial(this._fightBtnTooltipStr,null);
         }
         else
         {
            this._tooltipMgr.showComplex(this._fightBtnTooltipStr);
         }
      }
      
      private function onPersonalReserveWidgetCreated(param1:PersonalReservesWidgetEvent) : void
      {
         param1.preventDefault();
         param1.stopImmediatePropagation();
         this.unregisterPR2WidgetBtn();
         registerFlashComponentS(IDAAPIModule(param1.target),HANGAR_ALIASES.PERSONAL_RESERVES_WIDGET_INJECT);
      }
   }
}
