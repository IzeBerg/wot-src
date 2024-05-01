package net.wg.gui.lobby.messengerBar
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventPhase;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CONTACTS_ALIASES;
   import net.wg.data.constants.generated.SESSION_STATS_CONSTANTS;
   import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
   import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnim;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
   import net.wg.infrastructure.base.meta.IMessengerBarMeta;
   import net.wg.infrastructure.base.meta.impl.MessengerBarMeta;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class MessengerBar extends MessengerBarMeta implements IMessengerBarMeta, IDAAPIModule, IHelpLayoutComponent
   {
      
      public static const BAR_VISIBLE_HEIGHT:int = 35;
      
      private static const BAR_HEIGHT:int = 45;
      
      private static const LAYOUT_INVALID:String = "layoutInv";
      
      private static const INV_VEHICLE_CMP_VISIBLE:String = "InvVehicleCmpVisible";
      
      private static const INV_SESSION_STATS_VISIBLE:String = "InvSessionStatsVisible";
      
      private static const INV_SESSION_STATS_ENABLE:String = "InvSessionStatsEnable";
      
      private static const INV_REFERRAL_BUTTON:String = "InvReferralButton";
      
      private static const INV_SESSION_STATS_COUNTERS:String = "InvSessionStatsCounters";
      
      private static const UNDERSCORE:String = "_";
      
      private static const BUTTONS_OFFSET_X:uint = 3;
      
      private static const NOTIFICATION_SHIFT_X:int = 7;
      
      private static const NOTIFICATION_SHIFT_Y:int = 1;
      
      private static const CONTACTS_SHIFT_X:int = 1;
      
      private static const CONTACTS_HEIGHT_INCREMENT:int = -2;
      
      private static const CHANNEL_SHIFT_X:int = 3;
      
      private static const CHANNEL_SHIFT_Y:int = 3;
      
      private static const CHANNEL_WIDTH_INCREMENT:int = -20;
      
      private static const CHANNEL_HEIGHT_INCREMENT:int = -5;
      
      private static const VEHICLE_COMPARE_SHIFT_X:int = -5;
      
      private static const VEHICLE_COMPARE_WIDTH_INCREMENT:int = -2;
      
      private static const SESSION_STATS_SHIFT_X:int = -4;
      
      private static const RIGHT_SIDE_BTNS_GAP:int = 3;
      
      private static const RIGHT_SIDE_BTNS_START:int = 11;
      
      private static const HELP_LAYOUT_HIGHT_OFFSET:int = -2;
      
      private static const HELP_LAYOUT_ID_CONTACTS_BUTTON:String = "contactsButton";
      
      private static const HELP_LAYOUT_ID_CHANNELS_CAROUSEL:String = "channelsCarousel";
      
      private static const HELP_LAYOUT_ID_VEHICLE_COMPARE_BUTTON:String = "vehicleCompareButton";
      
      private static const HELP_LAYOUT_ID_SESSION_STATS_BUTTON:String = "sessionStatsButton";
      
      private static const HELP_LAYOUT_ID_NOTIFICATIONS_BUTTON:String = "notificationsButton";
       
      
      public var channelCarousel:ChannelCarousel;
      
      public var notificationListBtn:NotificationListButton;
      
      public var channelButton:IconTextBigButton;
      
      public var contactsListBtn:ButtonWithCounter;
      
      public var referralBtn:IconTextBigButton;
      
      public var vehicleCompareCartBtn:ButtonWithCounter;
      
      public var sessionStatsBtn:ButtonWithCounter;
      
      public var bg:Sprite;
      
      public var fakeChnlBtn:MovieClip;
      
      public var animPlacer:Sprite;
      
      private var _counterManager:ICounterManager;
      
      private var _initData:MessegerBarInitVO;
      
      private var _anim:VehicleCompareAnim;
      
      private var _stageDimensions:Point;
      
      private var _paddingLeft:uint = 0;
      
      private var _paddingRight:uint = 0;
      
      private var _paddingBottom:uint = 0;
      
      private var _paddingTop:uint = 0;
      
      private var _vehicleCmpBtnVisible:Boolean = false;
      
      private var _sessionStatsBtnVisible:Boolean = false;
      
      private var _sessionStatsBtnEnable:Boolean = false;
      
      private var _sessionStatsBtnTooltip:String = "";
      
      private var _isSessionStatsCounterShow:Boolean = false;
      
      private var _sessionStatsCounter:String = "";
      
      private var _rightSideBtnsOrder:Vector.<IDisplayObject> = null;
      
      private var _referralBtnTooltipProps:ITooltipProps;
      
      public function MessengerBar()
      {
         this._counterManager = App.utils.counterManager;
         this._stageDimensions = new Point();
         this._referralBtnTooltipProps = new TooltipProps("INFO",0,0,0,-1,0,310);
         super();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._rightSideBtnsOrder = new <IDisplayObject>[this.notificationListBtn,this.sessionStatsBtn,this.vehicleCompareCartBtn];
         registerFlashComponentS(this.notificationListBtn,Aliases.NOTIFICATION_LIST_BUTTON);
         registerFlashComponentS(this.contactsListBtn,Aliases.CONTACTS_LIST_BUTTON);
         registerFlashComponentS(this.vehicleCompareCartBtn,Aliases.VEHICLE_COMPARE_CART_BUTTON);
         registerFlashComponentS(this.channelCarousel,Aliases.CHANNEL_CAROUSEL);
         registerFlashComponentS(this.sessionStatsBtn,SESSION_STATS_CONSTANTS.SESSION_STATS_BUTTON_ALIAS);
         this.channelButton.addEventListener(ButtonEvent.CLICK,this.onChannelButtonClickHandler);
         this.contactsListBtn.addEventListener(ButtonEvent.CLICK,this.onContactsButtonClickHandler);
         this.referralBtn.addEventListener(ButtonEvent.CLICK,this.onReferralButtonClickHandler);
         this.vehicleCompareCartBtn.addEventListener(ButtonEvent.CLICK,this.onVehicleCmpBtnClickHandler);
         this.sessionStatsBtn.visible = this._sessionStatsBtnVisible;
         this.sessionStatsBtn.addEventListener(ButtonEvent.CLICK,this.onSessionStatsBtnClickHandler);
         App.stage.addEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW,this.onStagePinChannelsWindowHandler);
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this.referralBtn);
         this._counterManager.removeCounter(this.sessionStatsBtn);
         this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onFakeChnlBtnRollOverHandler);
         this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onFakeChnlBtnRollOutHandler);
         this.fakeChnlBtn.removeEventListener(MouseEvent.CLICK,this.onFakeChnlBtnClickHandler);
         this.fakeChnlBtn = null;
         App.utils.commons.removeOverlayFromBtn(this.referralBtn);
         this.channelButton.removeEventListener(ButtonEvent.CLICK,this.onChannelButtonClickHandler);
         this.referralBtn.removeEventListener(ButtonEvent.CLICK,this.onReferralButtonClickHandler);
         this.contactsListBtn.removeEventListener(ButtonEvent.CLICK,this.onContactsButtonClickHandler);
         this.vehicleCompareCartBtn.removeEventListener(ButtonEvent.CLICK,this.onVehicleCmpBtnClickHandler);
         this.sessionStatsBtn.removeEventListener(ButtonEvent.CLICK,this.onSessionStatsBtnClickHandler);
         App.stage.removeEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW,this.onStagePinChannelsWindowHandler);
         this._rightSideBtnsOrder.length = 0;
         this._rightSideBtnsOrder = null;
         this._counterManager = null;
         this.channelCarousel = null;
         this.notificationListBtn = null;
         this.referralBtn.dispose();
         this.referralBtn = null;
         this.channelButton.dispose();
         this.channelButton = null;
         this.contactsListBtn = null;
         this.vehicleCompareCartBtn = null;
         this.sessionStatsBtn = null;
         this._stageDimensions = null;
         this.bg = null;
         if(this._anim)
         {
            this.animPlacer.removeChild(this._anim);
            this._anim.addFrameScript(this._anim.totalFrames - 1,null);
            this._anim.dispose();
            this._anim = null;
         }
         this.animPlacer = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.addElement(this.notificationListBtn.name,this.notificationListBtn,Constraints.RIGHT);
         constraints.addElement(this.channelButton.name,this.channelButton,Constraints.LEFT);
         constraints.addElement(this.referralBtn.name,this.referralBtn,Constraints.LEFT);
         constraints.addElement(this.fakeChnlBtn.name,this.fakeChnlBtn,Constraints.LEFT);
         constraints.addElement(this.contactsListBtn.name,this.contactsListBtn,Constraints.LEFT);
         constraints.addElement(this.vehicleCompareCartBtn.name,this.vehicleCompareCartBtn,Constraints.RIGHT);
         constraints.addElement(this.sessionStatsBtn.name,this.sessionStatsBtn,Constraints.RIGHT);
         constraints.addElement(this.animPlacer.name,this.animPlacer,Constraints.RIGHT);
         this.animPlacer.mouseEnabled = false;
         this.animPlacer.mouseChildren = false;
         var _loc1_:Boolean = App.globalVarsMgr.isInRoamingS();
         this.channelButton.enabled = !_loc1_;
         this.channelButton.tooltip = TOOLTIPS.LOBY_MESSENGER_CHANNELS_BUTTON;
         this.fakeChnlBtn.visible = _loc1_;
         this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OVER,this.onFakeChnlBtnRollOverHandler);
         this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OUT,this.onFakeChnlBtnRollOutHandler);
         this.fakeChnlBtn.addEventListener(MouseEvent.CLICK,this.onFakeChnlBtnClickHandler);
         this.fakeChnlBtn.x = this.channelButton.x;
         this.fakeChnlBtn.width = this.channelButton.width;
         this.fakeChnlBtn.height = this.channelButton.height;
         this.sessionStatsBtn.button.mouseEnabledOnDisabled = true;
         App.utils.helpLayout.registerComponent(this);
         var _loc2_:Sprite = new Sprite();
         addChild(_loc2_);
         this.bg.hitArea = _loc2_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.channelButton.htmlIconStr = this._initData.channelsHtmlIcon;
               this.contactsListBtn.icon = this._initData.contactsHtmlIcon;
               this.contactsListBtn.tooltip = this._initData.contactsTooltip;
               this.vehicleCompareCartBtn.icon = this._initData.vehicleCompareHtmlIcon;
               this.vehicleCompareCartBtn.tooltip = this._initData.vehicleCompareTooltip;
               this.sessionStatsBtn.icon = this._initData.sessionStatsHtmlIcon;
            }
            if(isInvalid(INV_REFERRAL_BUTTON))
            {
               this.referralBtn.visible = this._initData.isReferralEnabled;
               if(this._initData.isReferralEnabled)
               {
                  if(this._initData.referralCounter > 0)
                  {
                     this._counterManager.setCounter(this.referralBtn,this._initData.referralCounter.toString());
                  }
                  else
                  {
                     this._counterManager.removeCounter(this.referralBtn);
                  }
                  if(this._initData.isReferralFirstIndication)
                  {
                     App.utils.commons.addOverlayToBtn(this.referralBtn,Linkages.BTN_FX_OVERLAY_CIRCLE,new Point(0.24,0.24),new Padding(1,2,4,1));
                  }
                  else
                  {
                     App.utils.commons.removeOverlayFromBtn(this.referralBtn);
                  }
                  if(StringUtils.isEmpty(this.referralBtn.htmlIconStr))
                  {
                     this.referralBtn.htmlIconStr = this._initData.referralHtmlIcon;
                  }
                  if(StringUtils.isEmpty(this.referralBtn.tooltip))
                  {
                     this.referralBtn.tooltip = this._initData.referralTooltip;
                     if(this._initData.isSpecialReferralTooltip)
                     {
                        this.referralBtn.tooltipProps = this._referralBtnTooltipProps;
                     }
                  }
                  constraints.addElement(this.referralBtn.name,this.referralBtn,Constraints.LEFT);
                  this.referralBtn.addEventListener(ButtonEvent.CLICK,this.onReferralButtonClickHandler);
               }
               else
               {
                  this._counterManager.removeCounter(this.referralBtn);
                  constraints.removeElement(this.referralBtn.name);
                  this.referralBtn.removeEventListener(ButtonEvent.CLICK,this.onReferralButtonClickHandler);
               }
               invalidate(InvalidationType.SIZE);
            }
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            y = this._stageDimensions.y - this.height - this.paddingBottom;
            x = this.paddingLeft;
            width = this._stageDimensions.x - this.paddingLeft - this.paddingRight;
            this.bg.x = -this.paddingLeft;
            this.bg.width = this._stageDimensions.x;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.channelButton.x = (!!this.referralBtn.visible ? this.referralBtn.x + this.referralBtn.width : this.contactsListBtn.x + this.contactsListBtn.width) + BUTTONS_OFFSET_X;
            this.channelCarousel.x = Boolean(this.channelButton) ? Number(this.channelButton.x + this.channelButton.width) : (Boolean(this.channelButton) ? Number(this.channelButton.x + this.channelButton.width) : Number(0));
            App.utils.commons.invalidateOverlayPosition(this.referralBtn);
         }
         if(isInvalid(INV_VEHICLE_CMP_VISIBLE))
         {
            this.vehicleCompareCartBtn.visible = this._vehicleCmpBtnVisible;
         }
         if(isInvalid(INV_SESSION_STATS_VISIBLE) && this.sessionStatsBtn.visible != this._sessionStatsBtnVisible)
         {
            this.sessionStatsBtn.visible = this._sessionStatsBtnVisible;
            invalidate(INV_SESSION_STATS_COUNTERS);
         }
         if(isInvalid(INV_VEHICLE_CMP_VISIBLE,INV_SESSION_STATS_VISIBLE,InvalidationType.SIZE))
         {
            this.updateChannelCarouselWidth();
         }
         if(isInvalid(INV_SESSION_STATS_ENABLE))
         {
            this.sessionStatsBtn.enabled = this._sessionStatsBtnEnable;
            this.sessionStatsBtn.tooltip = this._sessionStatsBtnTooltip;
         }
         if(isInvalid(INV_SESSION_STATS_COUNTERS))
         {
            if(this._isSessionStatsCounterShow && this.sessionStatsBtn.visible && StringUtils.isNotEmpty(this._sessionStatsCounter))
            {
               this._counterManager.setCounter(this.sessionStatsBtn,this._sessionStatsCounter);
            }
            else
            {
               this._counterManager.removeCounter(this.sessionStatsBtn);
            }
         }
      }
      
      override protected function setInitData(param1:MessegerBarInitVO) : void
      {
         this._initData = param1;
         invalidateData();
         invalidate(INV_REFERRAL_BUTTON);
      }
      
      override protected function showAddVehicleCompareAnim(param1:VehicleCompareAnimVO) : void
      {
         this.createAnimIfNeed();
         this._anim.gotoAndStop(0);
         this._anim.visible = true;
         this._anim.setData(param1);
         this._anim.x = -this._anim.width >> 1;
         this.animPlacer.visible = true;
         this._anim.play();
      }
      
      public function as_enableReferralRecruterEffect(param1:Boolean) : void
      {
         if(this._initData.isReferralFirstIndication != param1)
         {
            this._initData.isReferralFirstIndication = param1;
            invalidate(INV_REFERRAL_BUTTON);
         }
      }
      
      public function as_openVehicleCompareCartPopover(param1:Boolean) : void
      {
         if(param1)
         {
            this.showVehicleCmpPopover();
         }
         else if(this.vehicleCompareCartBtn == App.popoverMgr.popoverCaller.getTargetButton())
         {
            App.popoverMgr.hide();
         }
      }
      
      public function as_setReferralBtnCounter(param1:int) : void
      {
         if(this._initData.referralCounter != param1)
         {
            this._initData.referralCounter = param1;
            invalidate(INV_REFERRAL_BUTTON);
         }
      }
      
      public function as_setReferralButtonEnabled(param1:Boolean) : void
      {
         this.referralBtn.enabled = param1;
      }
      
      public function as_setReferralProgramButtonVisible(param1:Boolean) : void
      {
         if(this._initData.isReferralEnabled != param1)
         {
            this._initData.isReferralEnabled = param1;
            invalidate(INV_REFERRAL_BUTTON);
         }
      }
      
      public function as_setReferralProgramButtonTooltip(param1:String, param2:Boolean) : void
      {
         if(this.referralBtn.tooltip != param1)
         {
            this.referralBtn.tooltip = param1;
            if(param2)
            {
               this.referralBtn.tooltipProps = this._referralBtnTooltipProps;
            }
            else
            {
               this.referralBtn.tooltipProps = null;
            }
         }
      }
      
      public function as_setSessionStatsButtonEnable(param1:Boolean, param2:String) : void
      {
         if(this._sessionStatsBtnEnable != param1 || this._sessionStatsBtnTooltip != param2)
         {
            this._sessionStatsBtnEnable = param1;
            this._sessionStatsBtnTooltip = param2;
            invalidate(INV_SESSION_STATS_ENABLE);
         }
      }
      
      public function as_setSessionStatsButtonSettingsUpdate(param1:Boolean, param2:String) : void
      {
         this._isSessionStatsCounterShow = param1;
         this._sessionStatsCounter = param2;
         invalidate(INV_SESSION_STATS_COUNTERS);
      }
      
      public function as_setSessionStatsButtonVisible(param1:Boolean) : void
      {
         if(this._sessionStatsBtnVisible != param1)
         {
            this._sessionStatsBtnVisible = param1;
            invalidate(INV_SESSION_STATS_VISIBLE);
         }
      }
      
      public function as_setVehicleCompareCartButtonVisible(param1:Boolean) : void
      {
         if(this._vehicleCmpBtnVisible != param1)
         {
            this._vehicleCmpBtnVisible = param1;
            invalidate(INV_VEHICLE_CMP_VISIBLE);
         }
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
         _loc1_.push(this.createHelpLayoutVO(HELP_LAYOUT_ID_CONTACTS_BUTTON,LOBBY_HELP.CHAT_CONTACTS_CHANNEL,this.contactsListBtn.x + CONTACTS_SHIFT_X,this.contactsListBtn.y,this.channelButton.x + this.channelButton.width - this.contactsListBtn.x - CONTACTS_SHIFT_X,this.contactsListBtn.height + CONTACTS_HEIGHT_INCREMENT + HELP_LAYOUT_HIGHT_OFFSET));
         _loc1_.push(this.createHelpLayoutVO(HELP_LAYOUT_ID_CHANNELS_CAROUSEL,LOBBY_HELP.CHANNELCAROUSEL_CHANNELS,this.channelCarousel.x + CHANNEL_SHIFT_X,this.channelCarousel.y + CHANNEL_SHIFT_Y,this.channelCarousel.width + CHANNEL_WIDTH_INCREMENT,this.channelCarousel.height + CHANNEL_HEIGHT_INCREMENT));
         if(this._vehicleCmpBtnVisible)
         {
            _loc1_.push(this.createHelpLayoutVO(HELP_LAYOUT_ID_VEHICLE_COMPARE_BUTTON,LOBBY_HELP.VEHICLE_COMPARE,this.vehicleCompareCartBtn.x + VEHICLE_COMPARE_SHIFT_X,this.vehicleCompareCartBtn.y,this.vehicleCompareCartBtn.width + VEHICLE_COMPARE_WIDTH_INCREMENT,this.notificationListBtn.height + HELP_LAYOUT_HIGHT_OFFSET));
         }
         if(this._sessionStatsBtnVisible)
         {
            _loc1_.push(this.createHelpLayoutVO(HELP_LAYOUT_ID_SESSION_STATS_BUTTON,LOBBY_HELP.HANGAR_SESSIONSTATS,this.sessionStatsBtn.x + SESSION_STATS_SHIFT_X,this.sessionStatsBtn.y,this.sessionStatsBtn.width + VEHICLE_COMPARE_WIDTH_INCREMENT,this.notificationListBtn.height + HELP_LAYOUT_HIGHT_OFFSET));
         }
         _loc1_.push(this.createHelpLayoutVO(HELP_LAYOUT_ID_NOTIFICATIONS_BUTTON,LOBBY_HELP.CHAT_SERVICE_CHANNEL,this.notificationListBtn.x + NOTIFICATION_SHIFT_X,this.notificationListBtn.y + NOTIFICATION_SHIFT_Y,this.notificationListBtn.width,this.notificationListBtn.height + HELP_LAYOUT_HIGHT_OFFSET));
         return _loc1_;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageDimensions.x = param1;
         this._stageDimensions.y = param2;
         invalidate(LAYOUT_INVALID);
      }
      
      private function createHelpLayoutVO(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int) : HelpLayoutVO
      {
         var _loc7_:HelpLayoutVO = new HelpLayoutVO();
         _loc7_.extensibilityDirection = Directions.LEFT;
         _loc7_.scope = this;
         _loc7_.message = param2;
         _loc7_.id = name + UNDERSCORE + param1;
         _loc7_.x = param3;
         _loc7_.y = param4;
         _loc7_.width = param5;
         _loc7_.height = param6;
         return _loc7_;
      }
      
      private function updateChannelCarouselWidth() : void
      {
         var _loc2_:IDisplayObject = null;
         var _loc1_:int = this._rightSideBtnsOrder.length;
         var _loc3_:int = this._stageDimensions.x - RIGHT_SIDE_BTNS_START;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this._rightSideBtnsOrder[_loc4_];
            if(_loc2_)
            {
               if(_loc2_.visible)
               {
                  _loc3_ -= _loc2_.width + RIGHT_SIDE_BTNS_GAP;
                  _loc2_.x = _loc3_;
               }
            }
            _loc4_++;
         }
         this.channelCarousel.width = _loc3_ - this.channelCarousel.x - 1;
      }
      
      private function handlePinWindow(param1:MessengerBarEvent, param2:DisplayObject) : void
      {
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         var _loc3_:IAbstractWindowView = param1.target as IAbstractWindowView;
         App.utils.asserter.assertNotNull(_loc3_,"view" + Errors.CANT_NULL);
         var _loc4_:IManagedContent = _loc3_.window;
         var _loc5_:Point = localToGlobal(new Point(param2.x + WindowOffsetsInBar.WINDOW_LEFT_OFFSET,-_loc4_.height));
         _loc4_.x = _loc5_.x;
         _loc4_.y = _loc5_.y;
      }
      
      private function showVehicleCmpPopover() : void
      {
         App.popoverMgr.show(this.vehicleCompareCartBtn,VEHICLE_COMPARE_CONSTANTS.VEHICLE_COMPARE_CART_POPOVER);
      }
      
      private function createAnimIfNeed() : void
      {
         if(this._anim == null)
         {
            this._anim = App.utils.classFactory.getComponent(Linkages.VEHICLE_COMPARE_ANIM,VehicleCompareAnim);
            this._anim.addFrameScript(this._anim.totalFrames - 1,this.onAnimLastFlameCallback);
            this.animPlacer.addChild(this._anim);
         }
      }
      
      private function onAnimLastFlameCallback() : void
      {
         this.animPlacer.visible = false;
      }
      
      override public function get height() : Number
      {
         return BAR_HEIGHT;
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get paddingLeft() : uint
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:uint) : void
      {
         this._paddingLeft = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get paddingRight() : uint
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:uint) : void
      {
         this._paddingRight = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get paddingBottom() : uint
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:uint) : void
      {
         this._paddingBottom = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get paddingTop() : uint
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:uint) : void
      {
         this._paddingTop = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      private function onReferralButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this._initData.isReferralFirstIndication)
         {
            this._initData.isReferralFirstIndication = false;
            invalidate(INV_REFERRAL_BUTTON);
         }
         referralButtonClickS();
      }
      
      private function onChannelButtonClickHandler(param1:ButtonEvent) : void
      {
         channelButtonClickS();
      }
      
      private function onContactsButtonClickHandler(param1:ButtonEvent) : void
      {
         App.popoverMgr.show(this.contactsListBtn,CONTACTS_ALIASES.CONTACTS_POPOVER);
      }
      
      private function onVehicleCmpBtnClickHandler(param1:ButtonEvent) : void
      {
         this.showVehicleCmpPopover();
      }
      
      private function onSessionStatsBtnClickHandler(param1:ButtonEvent) : void
      {
         App.popoverMgr.show(this.sessionStatsBtn,SESSION_STATS_CONSTANTS.SESSION_STATS_POPOVER);
         sessionStatsButtonClickS();
      }
      
      private function onStagePinChannelsWindowHandler(param1:MessengerBarEvent) : void
      {
         this.handlePinWindow(param1,this.channelButton);
      }
      
      private function onFakeChnlBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(TOOLTIPS.LOBY_MESSENGER_CHANNEL_BUTTON_INROAMING);
      }
      
      private function onFakeChnlBtnRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onFakeChnlBtnClickHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
