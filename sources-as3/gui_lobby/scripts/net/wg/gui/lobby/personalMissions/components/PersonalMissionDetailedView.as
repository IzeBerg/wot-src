package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.MISSIONS_STATES;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   import net.wg.gui.components.questProgress.components.headerProgress.HeaderProgressContainer;
   import net.wg.gui.components.questProgress.events.QuestProgressComponentEvent;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.BaseMissionDetailedView;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionDetailedViewVO;
   import net.wg.gui.lobby.personalMissions.events.PersonalMissionDetailedViewEvent;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalMissionDetailedView extends BaseMissionDetailedView
   {
      
      public static const CONTENT_ADDITIONAL_HEIGHT:int = 50;
      
      private static const INVALIDATE_CONDITIONS_LAYOUT:String = "invalidate_conditions_layout";
      
      private static const VERTICAL_POINT_INV:String = "onVerticalCheckPointInvalid";
      
      private static const AWARDS_FULLY_WIDTH:int = 340;
      
      private static const AWARDS_WIDTH:int = 442;
      
      private static const INFO_ICON_GAP:int = 10;
      
      private static const CONDITIONS_START_Y_SHORT:int = 0;
      
      private static const CONDITIONS_START_Y_WIDE:int = 5;
      
      private static const CONDITIONS_START_X_MAIN:int = 0;
      
      private static const CONDITIONS_START_X_ADD:int = 492;
      
      private static const ITEMS_GAP:int = 25;
      
      private static const MOUSE_WHEEL_DELTA_FACTOR:int = 2;
      
      private static const BTNS_GAP:int = 11;
      
      private static const START_BTNS_LEFT_X:int = -162;
      
      private static const TABLE_HEADERS_Y_POS_SHORT:int = 60;
      
      private static const TABLE_HEADERS_Y_POS_WIDE:int = 100;
      
      private static const PAGE_SCROLL_SIZE:int = 5;
      
      private static const HEADERS_PROGRESS_Y_POS_SHORT:int = 104;
      
      private static const HEADERS_PROGRESS_Y_POS_WIDE:int = 144;
      
      private static const TABLE_Y_POS_SHORT:int = 171;
      
      private static const TABLE_Y_POS_WIDE:int = 211;
      
      private static const TABLE_HEIGHT_SHORT:int = 214;
      
      private static const TABLE_HEIGHT_WIDE:int = 224;
      
      private static const TABLE_AWARDS_BG_Y_POS_SHORT:int = 389;
      
      private static const TABLE_AWARDS_BG_Y_POS_WIDE:int = 439;
      
      private static const TABLE_BOTTOM_BUTTONS_Y_POS_SHORT:int = 520;
      
      private static const TABLE_BOTTOM_BUTTONS_Y_POS_WIDE:int = 580;
      
      private static const TABLE_BOTTOM_STATUS_Y_POS_SHORT:int = 521;
      
      private static const TABLE_BOTTOM_STATUS_Y_POS_WIDE:int = 581;
      
      private static const TABLE_BOTTOM_STATUS2_Y_POS_SHORT:int = 563;
      
      private static const TABLE_BOTTOM_STATUS2_Y_POS_WIDE:int = 623;
      
      private static const AWARDS_Y_SHIFT:int = -7;
      
      private static const FULLY_AWARDS_Y_SHIFT:int = -2;
      
      private static const TABLE_SCROLLBAR_Y_POS_SHIFT:int = -14;
      
      private static const BOTTOM_STATUS_ICO_Y_GAP:int = 10;
      
      private static const BOTTOM_STATUS_ICO_X_GAP:int = 13;
      
      private static const BIG_AWARDS_SMALL_GAP:int = 15;
      
      private static const BIG_AWARDS_MAX_NUM:int = 3;
      
      private static const HEADER_X_SHIFT:int = -16;
      
      private static const STATUS_X_SHIFT:int = 10;
      
      private static const STATUS_ICON_GAP:int = 15;
      
      private static const TITLE_TF_WIDTH:int = 666;
      
      private static const PLAY_PAUSE_BTN_WIDTH:int = 32;
      
      private static const PLAY_PAUSE_BTN_NAME_FOR_TUTOR:String = "playPauseBtn";
      
      private static const HOLD_AWARD_SHEET_BTN_WIDTH:int = 158;
      
      private static const HOLD_AWARD_SHEET_BTN_NAME_FOR_TUTOR:String = "holdAwardSheetBtn";
      
      private static const LOCK_X_SHIFT:int = -2;
      
      private static const LOCK_Y_SHIFT:int = -3;
       
      
      public var awardsFullyCompletedGroup:IGroupEx;
      
      public var mainConditionsTf:TextField;
      
      public var addConditionsTf:TextField;
      
      public var startBtn:ISoundButtonEx;
      
      public var retryBtn:ISoundButtonEx;
      
      public var obtainAwardBtn:ISoundButtonEx;
      
      public var discardBtn:ISoundButtonEx;
      
      public var conditionsContainer:Sprite;
      
      public var headerContainer:HeaderProgressContainer;
      
      public var conditionsContainerHitMc:Sprite;
      
      public var maskMc:Sprite;
      
      public var scrollBar:ScrollBar;
      
      public var statusIcon:QuestProgressAtlasSprite;
      
      public var bottomStatus2Icon:QuestProgressAtlasSprite;
      
      public var statusBg:FrameStateCmpnt;
      
      public var lock:UILoaderAlt = null;
      
      private var _holdAwardSheetBtn:UniversalBtn;
      
      private var _playPauseBtn:UniversalBtn;
      
      private var _isPlayPauseBtnInDisplayList:Boolean = false;
      
      private var _isHoldAwardSheetBtnInDisplayList:Boolean = false;
      
      private var _vo:PersonalMissionDetailedViewVO;
      
      private var _bodyConditions:Vector.<IQPItemRenderer> = null;
      
      private var _orConditions:Vector.<IQPItemOrConditionIcon> = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      private var _conditionsReady:Boolean = false;
      
      private var _isViewVerticalWide:Boolean = false;
      
      private var _contentAdditionalHeight:int = 0;
      
      private var _containerStartYPosition:int = 171;
      
      private var _containerHeightPosition:int = 214;
      
      private var _hasLockedItem:Boolean = false;
      
      public function PersonalMissionDetailedView()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
         addItemToContentList(DisplayObject(this.awardsFullyCompletedGroup));
         addItemToContentList(DisplayObject(this.startBtn));
         addItemToContentList(DisplayObject(this.retryBtn));
         addItemToContentList(DisplayObject(this.discardBtn));
         addItemToContentList(DisplayObject(this.obtainAwardBtn));
         addItemToContentList(this.conditionsContainer);
         addItemToContentList(this.headerContainer);
         addItemToContentList(this.scrollBar);
         addItemToContentList(this.statusIcon);
         addItemToContentList(this.statusBg);
         addItemToContentList(this.bottomStatus2Icon);
         addItemToContentList(this.mainConditionsTf);
         addItemToContentList(this.addConditionsTf);
         addItemToContentList(this.lock);
      }
      
      private static function layoutConditions(param1:Vector.<IQPItemRenderer>, param2:int, param3:Vector.<IQPItemOrConditionIcon>) : void
      {
         var _loc6_:IQPItemRenderer = null;
         var _loc7_:IQPItemOrConditionIcon = null;
         var _loc4_:int = param2;
         var _loc5_:int = param2;
         for each(_loc6_ in param1)
         {
            if(_loc6_.orderType == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE)
            {
               _loc6_.x = CONDITIONS_START_X_MAIN;
               _loc6_.y = _loc4_;
               _loc4_ += _loc6_.height + ITEMS_GAP;
            }
            else
            {
               _loc6_.x = CONDITIONS_START_X_ADD;
               _loc6_.y = _loc5_;
               _loc5_ += _loc6_.height + ITEMS_GAP;
            }
         }
         for each(_loc7_ in param3)
         {
            _loc7_.x = _loc7_.previousItem.x + (_loc7_.previousItem.chartMetrics.width >> 1);
            _loc7_.y = _loc7_.item.y + _loc7_.previousItem.y + _loc7_.previousItem.chartMetrics.height >> 1;
         }
      }
      
      override public function getFocusItem() : InteractiveObject
      {
         if(this._vo)
         {
            if(this._vo.discardBtnVisible && this._vo.discardBtnEnabled)
            {
               return InteractiveObject(this.discardBtn);
            }
            if(this._vo.startBtnVisible && this._vo.startBtnEnabled)
            {
               return InteractiveObject(this.startBtn);
            }
            if(this._vo.retryBtnVisible && this._vo.retryBtnEnabled)
            {
               return InteractiveObject(this.retryBtn);
            }
            if(this._vo.holdAwardSheetBtnVisible && this._vo.holdAwardSheetBtnEnabled && this._holdAwardSheetBtn)
            {
               return InteractiveObject(this._holdAwardSheetBtn);
            }
         }
         return super.getFocusItem();
      }
      
      override public function setContentVisible(param1:Boolean) : void
      {
         super.setContentVisible(param1);
         this.discardBtn.alpha = 1;
      }
      
      override public function setData(param1:BaseMissionDetailedViewVO) : void
      {
         if(this._vo && this._vo.eventID == param1.eventID && this._vo.blockID == param1.blockID)
         {
            this.conditionsContainer.visible = false;
         }
         this._toolTipMgr.hide();
         super.setData(param1);
         this._vo = PersonalMissionDetailedViewVO(param1);
         this._contentAdditionalHeight = !!this._vo.isHeaderHasProgress ? int(Values.ZERO) : int(CONTENT_ADDITIONAL_HEIGHT);
      }
      
      override public function updateVerticalCheckPoint(param1:Boolean) : void
      {
         if(this._isViewVerticalWide != param1)
         {
            this._isViewVerticalWide = param1;
            invalidate(VERTICAL_POINT_INV);
         }
      }
      
      override protected function getTitleWidth() : int
      {
         return TITLE_TF_WIDTH;
      }
      
      override protected function getAwardsWidth() : int
      {
         return AWARDS_WIDTH;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.createDynamicBtns();
         this.mainConditionsTf.text = PERSONAL_MISSIONS.DETAILEDVIEW_CONDITIONSLABEL;
         this._commons.updateTextFieldSize(this.mainConditionsTf);
         this.addConditionsTf.text = PERSONAL_MISSIONS.DETAILEDVIEW_CONDITIONSFULLYLABEL;
         this._commons.updateTextFieldSize(this.addConditionsTf);
         this.statusIcon.isCentralize = true;
         this.bottomStatus2Icon.isCentralize = true;
         this.awardsFullyCompletedGroup.layout = new CenterAlignedGroupLayout(BIG_AWARD_RENDERER_SIZE,BIG_AWARD_RENDERER_SIZE);
         this.awardsFullyCompletedGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
         this.startBtn.label = PERSONAL_MISSIONS.DETAILEDVIEW_STARTBTNLABEL;
         this.discardBtn.label = PERSONAL_MISSIONS.DETAILEDVIEW_DISCARDBTNLABEL;
         this.obtainAwardBtn.label = PERSONAL_MISSIONS.DETAILEDVIEW_RECRUITBTNLABEL;
         this.discardBtn.dynamicSizeByText = true;
         this.discardBtn.changeSizeOnlyUpwards = true;
         this.startBtn.minWidth = this.startBtn.width;
         this.mainConditionsTf.addEventListener(MouseEvent.MOUSE_OVER,this.onConditionsTfMouseOverHandler);
         this.mainConditionsTf.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.addConditionsTf.addEventListener(MouseEvent.MOUSE_OVER,this.onConditionsFullyTfMouseOverHandler);
         this.addConditionsTf.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.startBtn.addEventListener(ButtonEvent.CLICK,this.onStartBtnClickHandler);
         this.startBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onStartBtnMouseOverHandler);
         this.startBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.retryBtn.addEventListener(ButtonEvent.CLICK,this.onRetryBtnClickHandler);
         this.retryBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onRetryBtnMouseOverHandler);
         this.retryBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.retryBtn.mouseEnabledOnDisabled = true;
         this.obtainAwardBtn.addEventListener(ButtonEvent.CLICK,this.onObtainAwardBtnClickHandler);
         this.obtainAwardBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onObtainAwardBtnMouseOverHandler);
         this.obtainAwardBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.discardBtn.addEventListener(ButtonEvent.CLICK,this.onDiscardBtnClickHandler);
         this.discardBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onDiscardBtnMouseOverHandler);
         this.discardBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         bottomStatus2Tf.addEventListener(MouseEvent.ROLL_OVER,this.onBottomStatus2LabelTfRollOverHandler);
         bottomStatus2Tf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.conditionsContainer.hitArea = this.conditionsContainerHitMc;
         this.conditionsContainer.addEventListener(MouseEvent.MOUSE_WHEEL,this.onConditionsContainerMouseWheelHandler);
         this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.lock.addEventListener(MouseEvent.ROLL_OVER,this.onLockRollOverHandler);
         this.lock.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.lock.source = RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_LOCK_PROGRESS;
      }
      
      override protected function onDispose() : void
      {
         this._vo = null;
         this.removeDynamicBtns();
         this.mainConditionsTf.removeEventListener(MouseEvent.MOUSE_OVER,this.onConditionsTfMouseOverHandler);
         this.mainConditionsTf.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.addConditionsTf.removeEventListener(MouseEvent.MOUSE_OVER,this.onConditionsFullyTfMouseOverHandler);
         this.addConditionsTf.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.startBtn.removeEventListener(ButtonEvent.CLICK,this.onStartBtnClickHandler);
         this.startBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onStartBtnMouseOverHandler);
         this.startBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.startBtn.dispose();
         this.startBtn = null;
         this.retryBtn.removeEventListener(ButtonEvent.CLICK,this.onRetryBtnClickHandler);
         this.retryBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onRetryBtnMouseOverHandler);
         this.retryBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.retryBtn.dispose();
         this.retryBtn = null;
         this.discardBtn.removeEventListener(ButtonEvent.CLICK,this.onDiscardBtnClickHandler);
         this.discardBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onDiscardBtnMouseOverHandler);
         this.discardBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.discardBtn.dispose();
         this.discardBtn = null;
         this.obtainAwardBtn.removeEventListener(ButtonEvent.CLICK,this.onObtainAwardBtnClickHandler);
         this.obtainAwardBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onObtainAwardBtnMouseOverHandler);
         this.obtainAwardBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.obtainAwardBtn.dispose();
         this.obtainAwardBtn = null;
         bottomStatus2Tf.removeEventListener(MouseEvent.ROLL_OVER,this.onBottomStatus2LabelTfRollOverHandler);
         bottomStatus2Tf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.conditionsContainer.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onConditionsContainerMouseWheelHandler);
         this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.headerContainer.dispose();
         this.headerContainer = null;
         this.cleanConditions(this._bodyConditions);
         this._bodyConditions = null;
         this.cleanOrConditions(this._orConditions);
         this._orConditions = null;
         this.awardsFullyCompletedGroup.dispose();
         this.awardsFullyCompletedGroup = null;
         this.mainConditionsTf = null;
         this.addConditionsTf = null;
         this.conditionsContainer = null;
         this.conditionsContainerHitMc = null;
         this.maskMc = null;
         this.statusIcon = null;
         this.bottomStatus2Icon = null;
         this.statusBg.dispose();
         this.statusBg = null;
         this._toolTipMgr = null;
         this._commons = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.lock.removeEventListener(MouseEvent.ROLL_OVER,this.onLockRollOverHandler);
         this.lock.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.lock.dispose();
         this.lock = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ISoundButtonEx = null;
         var _loc2_:int = 0;
         super.draw();
         if(this._vo != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._holdAwardSheetBtn.visible = this._vo.holdAwardSheetBtnVisible;
               if(this._vo.holdAwardSheetBtnVisible)
               {
                  this._holdAwardSheetBtn.enabled = this._vo.holdAwardSheetBtnEnabled;
                  this._holdAwardSheetBtn.label = this._vo.completeBtnLabel;
                  SoundButtonEx(this._holdAwardSheetBtn).initialized = true;
                  this._holdAwardSheetBtn.validateNow();
                  this._holdAwardSheetBtn.dynamicSizeByText = this._holdAwardSheetBtn.width > HOLD_AWARD_SHEET_BTN_WIDTH;
                  if(this._holdAwardSheetBtn.width < HOLD_AWARD_SHEET_BTN_WIDTH)
                  {
                     this._holdAwardSheetBtn.width = HOLD_AWARD_SHEET_BTN_WIDTH;
                  }
               }
               this.retryBtn.label = this._vo.retryBtnLabel;
               this.retryBtn.enabled = this._vo.retryBtnEnabled;
               this.retryBtn.visible = this._vo.retryBtnVisible;
               this.discardBtn.visible = this._vo.discardBtnVisible;
               this.discardBtn.enabled = this._vo.discardBtnEnabled;
               this.startBtn.visible = this._vo.startBtnVisible;
               this.startBtn.enabled = this._vo.startBtnEnabled;
               this.obtainAwardBtn.visible = this._vo.obtainAwardBtnVisible;
               this.headerContainer.setData(this._vo.headerConditions,CONDITIONS_START_X_MAIN,CONDITIONS_START_X_ADD);
               this.cleanOrConditions(this._orConditions);
               this._orConditions = new Vector.<IQPItemOrConditionIcon>();
               this.cleanConditions(this._bodyConditions);
               this._bodyConditions = new Vector.<IQPItemRenderer>(0);
               this.createConditions(this._bodyConditions,this._vo.bodyConditions,this._orConditions);
               _loc1_ = null;
               if(this.startBtn.visible)
               {
                  _loc1_ = this.startBtn;
               }
               else if(this.discardBtn.visible)
               {
                  _loc1_ = this.discardBtn;
               }
               if(_loc1_)
               {
                  if(this._vo.holdAwardSheetBtnVisible)
                  {
                     _loc1_.x = START_BTNS_LEFT_X - (this._holdAwardSheetBtn.width - HOLD_AWARD_SHEET_BTN_WIDTH >> 1);
                     this._holdAwardSheetBtn.x = _loc1_.x + _loc1_.width + BTNS_GAP | 0;
                  }
                  else
                  {
                     _loc1_.x = -_loc1_.width >> 1;
                  }
               }
               else if(this._vo.holdAwardSheetBtnVisible)
               {
                  this._holdAwardSheetBtn.x = -this._holdAwardSheetBtn.width >> 1;
               }
               if(this._vo.pauseBtnVisible)
               {
                  this._playPauseBtn.iconSource = this._vo.onPauseBtnIcon;
                  if(!_loc1_)
                  {
                     if(this._vo.holdAwardSheetBtnVisible)
                     {
                        _loc1_ = this._holdAwardSheetBtn;
                     }
                     else if(this.retryBtn.visible)
                     {
                        _loc1_ = this.retryBtn;
                     }
                  }
                  if(_loc1_)
                  {
                     this._playPauseBtn.x = _loc1_.x - this._playPauseBtn.width - BTNS_GAP;
                  }
               }
               else
               {
                  this.removePlayPauseBtnFromDisplayList();
               }
               if(this._vo.statusLabel)
               {
                  this.statusBg.frameLabel = this._vo.status;
                  switch(this._vo.status)
                  {
                     case MISSIONS_STATES.COMPLETED:
                        this.statusIcon.imageName = QUESTSPROGRESS.QUEST_DONE;
                        break;
                     case MISSIONS_STATES.FULL_COMPLETED:
                        this.statusIcon.imageName = QUESTSPROGRESS.QUEST_DONE_PERFECTLY;
                        break;
                     case MISSIONS_STATES.IN_PROGRESS:
                        this.statusIcon.imageName = QUESTSPROGRESS.QUEST_IN_PROGRESS;
                        break;
                     case MISSIONS_STATES.NOT_AVAILABLE:
                        this.statusIcon.imageName = QUESTSPROGRESS.QUEST_NOT_AVAILABLE;
                        break;
                     case MISSIONS_STATES.IS_ON_PAUSE:
                        this.statusIcon.imageName = QUESTSPROGRESS.QUEST_ON_PAUSE;
                  }
                  this.statusIcon.x = -(statusLabelTf.textWidth >> 1) - STATUS_ICON_GAP + STATUS_X_SHIFT;
                  statusLabelTf.x = -(statusLabelTf.width >> 1) + STATUS_X_SHIFT;
                  this.statusBg.visible = this.statusIcon.visible = statusLabelTf.visible = true;
               }
               else
               {
                  this.statusBg.visible = this.statusIcon.visible = statusLabelTf.visible = false;
               }
               this.updateAwardsFull();
               invalidate(VERTICAL_POINT_INV);
            }
            if(isInvalid(VERTICAL_POINT_INV))
            {
               this.onUpdateVerticalCheckPoint(this._isViewVerticalWide);
               if(!this._isPlayPauseBtnInDisplayList && this._vo.pauseBtnVisible)
               {
                  this.addChild(DisplayObject(this._playPauseBtn));
                  this._playPauseBtn.validateNow();
                  this._isPlayPauseBtnInDisplayList = true;
               }
               if(!this._isHoldAwardSheetBtnInDisplayList && this._vo.holdAwardSheetBtnVisible)
               {
                  this.addChild(DisplayObject(this._holdAwardSheetBtn));
                  SoundButtonEx(this._holdAwardSheetBtn).initialized = false;
                  this._holdAwardSheetBtn.validateNow();
                  this._isHoldAwardSheetBtnInDisplayList = true;
               }
               invalidate(INVALIDATE_CONDITIONS_LAYOUT);
            }
            if(isInvalid(InvalidationType.DATA,VERTICAL_POINT_INV))
            {
               dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.CONTROLS_VISIBLE_SET,this._vo.eventID));
            }
            if(this._conditionsReady && isInvalid(INVALIDATE_CONDITIONS_LAYOUT))
            {
               _loc2_ = !!this._isViewVerticalWide ? int(CONDITIONS_START_Y_WIDE) : int(CONDITIONS_START_Y_SHORT);
               layoutConditions(this._bodyConditions,_loc2_,this._orConditions);
               this.conditionsContainer.visible = true;
               this.updateScrollBar();
               this.scrollBar.position = 0;
               this.playFadeInTween();
            }
         }
      }
      
      override protected function showInfoTooltip() : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.PERSONAL_MISSION_INFO,null,this._vo.eventID);
      }
      
      override protected function updateInfoIconParams() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._vo.titleTooltip);
         infoIcon.visible = _loc1_;
         if(_loc1_)
         {
            infoIcon.source = RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_QUESTION_ICON;
            infoIcon.x = (titleTf.textWidth >> 1) + INFO_ICON_GAP + HEADER_X_SHIFT;
            titleTf.x = -(titleTf.width >> 1) + HEADER_X_SHIFT;
         }
      }
      
      override protected function playFadeOutTween() : void
      {
         this.awardsFullyCompletedGroup.enabled = false;
         super.playFadeOutTween();
      }
      
      override protected function playFadeInTween() : void
      {
         if(this._conditionsReady)
         {
            super.playFadeInTween();
            this._conditionsReady = false;
            this.awardsFullyCompletedGroup.enabled = true;
         }
      }
      
      override protected function updateBottomStates() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._vo.bottomStatusText);
         var _loc2_:Boolean = StringUtils.isNotEmpty(this._vo.addBottomStatusText);
         bottomStatusTf.visible = _loc1_;
         bottomStatus2Tf.visible = _loc2_;
         if(_loc1_)
         {
            bottomStatusTf.htmlText = this._vo.bottomStatusText;
         }
         this.bottomStatus2Icon.visible = _loc2_ && this._vo.showIcon;
         if(_loc2_)
         {
            bottomStatus2Tf.htmlText = this._vo.addBottomStatusText;
            this.bottomStatus2Icon.x = -(bottomStatus2Tf.textWidth >> 1) - BOTTOM_STATUS_ICO_X_GAP;
            this.bottomStatus2Icon.imageName = QUESTSPROGRESS.QUEST_NOT_AVAILABLE;
         }
      }
      
      override protected function updateAwardsLayout() : void
      {
         super.updateAwardsLayout();
         var _loc1_:int = awardsBg.y + (awardsBg.height - awardsGroup.height >> 1);
         awardsGroup.y = _loc1_ + AWARDS_Y_SHIFT;
         this.awardsFullyCompletedGroup.y = _loc1_ + FULLY_AWARDS_Y_SHIFT;
      }
      
      protected function onUpdateVerticalCheckPoint(param1:Boolean) : void
      {
         var _loc2_:int = -TABLE_SCROLLBAR_Y_POS_SHIFT + this._contentAdditionalHeight;
         var _loc3_:int = TABLE_SCROLLBAR_Y_POS_SHIFT - this._contentAdditionalHeight;
         if(param1)
         {
            this.mainConditionsTf.y = TABLE_HEADERS_Y_POS_WIDE;
            this.addConditionsTf.y = TABLE_HEADERS_Y_POS_WIDE;
            this.headerContainer.y = HEADERS_PROGRESS_Y_POS_WIDE;
            _loc3_ += TABLE_Y_POS_WIDE;
            _loc2_ += TABLE_HEIGHT_WIDE;
            awardsBg.y = TABLE_AWARDS_BG_Y_POS_WIDE;
            this._holdAwardSheetBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            this.obtainAwardBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            this.retryBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            this.startBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            this.discardBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            if(this._playPauseBtn)
            {
               this._playPauseBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_WIDE;
            }
            bottomStatusTf.y = TABLE_BOTTOM_STATUS_Y_POS_WIDE;
            bottomStatus2Tf.y = TABLE_BOTTOM_STATUS2_Y_POS_WIDE;
         }
         else
         {
            this.mainConditionsTf.y = TABLE_HEADERS_Y_POS_SHORT;
            this.addConditionsTf.y = TABLE_HEADERS_Y_POS_SHORT;
            this.headerContainer.y = HEADERS_PROGRESS_Y_POS_SHORT;
            _loc3_ += TABLE_Y_POS_SHORT;
            _loc2_ += TABLE_HEIGHT_SHORT;
            awardsBg.y = TABLE_AWARDS_BG_Y_POS_SHORT;
            this._holdAwardSheetBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            this.obtainAwardBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            this.retryBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            this.startBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            this.discardBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            if(this._playPauseBtn)
            {
               this._playPauseBtn.y = TABLE_BOTTOM_BUTTONS_Y_POS_SHORT;
            }
            bottomStatusTf.y = TABLE_BOTTOM_STATUS_Y_POS_SHORT;
            bottomStatus2Tf.y = TABLE_BOTTOM_STATUS2_Y_POS_SHORT;
         }
         this.conditionsContainerHitMc.y = _loc3_;
         this.maskMc.y = _loc3_;
         this.scrollBar.y = _loc3_;
         this.conditionsContainerHitMc.height = _loc2_;
         this.maskMc.height = _loc2_;
         this.scrollBar.height = _loc2_;
         this.bottomStatus2Icon.y = bottomStatus2Tf.y + BOTTOM_STATUS_ICO_Y_GAP;
         this._containerStartYPosition = _loc3_ - TABLE_SCROLLBAR_Y_POS_SHIFT;
         this._containerHeightPosition = _loc2_ + TABLE_SCROLLBAR_Y_POS_SHIFT;
         this.updateScrollBar();
         this.updateContainerPosByScroll();
         this.updateAwardsLayout();
         this.lock.visible = this._hasLockedItem;
         if(this._hasLockedItem)
         {
            this.lock.x = this.addConditionsTf.x + this.addConditionsTf.textWidth + LOCK_X_SHIFT;
            this.lock.y = this.addConditionsTf.y + LOCK_Y_SHIFT;
         }
      }
      
      private function createDynamicBtns() : void
      {
         if(!this._playPauseBtn)
         {
            this._playPauseBtn = App.utils.classFactory.getComponent(Linkages.BUTTON_UNIVERSAL_HEAVY,UniversalBtn);
            addItemToContentList(DisplayObject(this._playPauseBtn));
            this._playPauseBtn.addEventListener(ButtonEvent.CLICK,this.onPlayPauseBtnClickHandler);
            this._playPauseBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onPlayPauseBtnMouseOverHandler);
            this._playPauseBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
            this._playPauseBtn.mouseEnabledOnDisabled = true;
            this._playPauseBtn.width = PLAY_PAUSE_BTN_WIDTH;
            this._playPauseBtn.name = PLAY_PAUSE_BTN_NAME_FOR_TUTOR;
            this._playPauseBtn.iconAlign = TextFieldAutoSize.CENTER;
            App.utils.universalBtnStyles.setStyle(this._playPauseBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         }
         if(!this._holdAwardSheetBtn)
         {
            this._holdAwardSheetBtn = App.utils.classFactory.getComponent(Linkages.BUTTON_UNIVERSAL_HEAVY,UniversalBtn);
            addItemToContentList(DisplayObject(this._holdAwardSheetBtn));
            this._holdAwardSheetBtn.addEventListener(ButtonEvent.CLICK,this.onHoldAwardSheetBtnClickHandler);
            this._holdAwardSheetBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onHoldAwardSheetBtnMouseOverHandler);
            this._holdAwardSheetBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
            this._holdAwardSheetBtn.useHtmlText = true;
            this._holdAwardSheetBtn.mouseEnabledOnDisabled = true;
            this._holdAwardSheetBtn.dynamicSizeByText = true;
            this._holdAwardSheetBtn.name = HOLD_AWARD_SHEET_BTN_NAME_FOR_TUTOR;
            App.utils.universalBtnStyles.setStyle(this._holdAwardSheetBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         }
      }
      
      private function removeDynamicBtns() : void
      {
         this.removePlayPauseBtnFromDisplayList();
         if(this._isHoldAwardSheetBtnInDisplayList)
         {
            this.removeChild(DisplayObject(this._holdAwardSheetBtn));
            this._isHoldAwardSheetBtnInDisplayList = false;
         }
         if(this._playPauseBtn)
         {
            this._playPauseBtn.removeEventListener(ButtonEvent.CLICK,this.onPlayPauseBtnClickHandler);
            this._playPauseBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onPlayPauseBtnMouseOverHandler);
            this._playPauseBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
            this._playPauseBtn.dispose();
            this._playPauseBtn = null;
         }
         if(this._holdAwardSheetBtn)
         {
            this._holdAwardSheetBtn.removeEventListener(ButtonEvent.CLICK,this.onHoldAwardSheetBtnClickHandler);
            this._holdAwardSheetBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onHoldAwardSheetBtnMouseOverHandler);
            this._holdAwardSheetBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
            this._holdAwardSheetBtn.dispose();
            this._holdAwardSheetBtn = null;
         }
      }
      
      private function removePlayPauseBtnFromDisplayList() : void
      {
         if(this._isPlayPauseBtnInDisplayList)
         {
            this.removeChild(DisplayObject(this._playPauseBtn));
            this._isPlayPauseBtnInDisplayList = false;
         }
      }
      
      private function updateScrollBar() : void
      {
         if(this.conditionsContainer.height > this._containerHeightPosition + PAGE_SCROLL_SIZE)
         {
            this.scrollBar.visible = true;
            this.scrollBar.setScrollProperties(this._containerHeightPosition,0,this.conditionsContainer.height - this._containerHeightPosition,0);
         }
         else
         {
            this.scrollBar.visible = false;
         }
      }
      
      private function createConditions(param1:Vector.<IQPItemRenderer>, param2:Vector.<IQuestProgressItemData>, param3:Vector.<IQPItemOrConditionIcon>) : void
      {
         var _loc6_:IQuestProgressItemData = null;
         var _loc7_:IQPItemRenderer = null;
         var _loc4_:IQPItemRenderer = null;
         var _loc5_:IQPItemOrConditionIcon = null;
         this._hasLockedItem = false;
         for each(_loc6_ in param2)
         {
            if(_loc6_ && _loc6_.initData && _loc6_.progressData && _loc6_.progressData.metricsValue)
            {
               _loc7_ = App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.QP_VIEW_RENDERER_TAB,IQPItemRenderer);
               _loc7_.addEventListener(QuestProgressComponentEvent.LAYOUT_COMPLETED,this.onItemRendererLayoutCompletedHandler);
               _loc7_.viewType = QUEST_PROGRESS_BASE.VIEW_TYPE_TAB;
               _loc7_.id = _loc6_.id;
               _loc7_.init(_loc6_.initData);
               _loc7_.initMetrics(_loc6_.progressData.metricsValue,_loc6_.progressData.state);
               _loc7_.update(_loc6_.progressData);
               if(!this._hasLockedItem && _loc6_.progressData.isLocked)
               {
                  this._hasLockedItem = true;
               }
               param1.push(_loc7_);
               this.conditionsContainer.addChild(DisplayObject(_loc7_));
               if(_loc4_ && _loc4_.isInOrGroup && _loc7_.isInOrGroup && _loc4_.orderType == _loc7_.orderType)
               {
                  _loc5_ = App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.QP_OR_CONDITION_ICON_TAB,IQPItemOrConditionIcon);
                  this.conditionsContainer.addChild(DisplayObject(_loc5_));
                  _loc5_.setItems(_loc4_,_loc7_);
                  param3.push(_loc5_);
               }
               _loc4_ = _loc7_;
            }
         }
      }
      
      private function updateAwardsFull() : void
      {
         var _loc1_:int = this._vo.awardsFullyCompleted.length <= BIG_AWARDS_MAX_NUM ? int(BIG_AWARDS_GAP) : int(BIG_AWARDS_SMALL_GAP);
         var _loc2_:CenterAlignedGroupLayout = CenterAlignedGroupLayout(this.awardsFullyCompletedGroup.layout);
         _loc2_.gap = _loc1_;
         _loc2_.rendererWidth = _loc2_.rendererHeight = BIG_AWARD_RENDERER_SIZE;
         this.awardsFullyCompletedGroup.dataProvider = this._vo.awardsFullyCompleted;
         this.awardsFullyCompletedGroup.width = AWARDS_FULLY_WIDTH;
         this.awardsFullyCompletedGroup.height = BIG_AWARDS_HEIGHT;
         this.updateAwardsLayout();
      }
      
      private function cleanConditions(param1:Vector.<IQPItemRenderer>) : void
      {
         var _loc2_:IUIComponentEx = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               _loc2_.removeEventListener(QuestProgressComponentEvent.LAYOUT_COMPLETED,this.onItemRendererLayoutCompletedHandler);
               this.conditionsContainer.removeChild(DisplayObject(_loc2_));
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      private function cleanOrConditions(param1:Vector.<IQPItemOrConditionIcon>) : void
      {
         var _loc2_:IQPItemOrConditionIcon = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               this.conditionsContainer.removeChild(DisplayObject(_loc2_));
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      private function updateContainerPosByScroll() : void
      {
         this.conditionsContainer.y = this._containerStartYPosition - this.scrollBar.position;
      }
      
      private function onPlayPauseBtnMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = TOOLTIPS.PERSONALMISSIONS_ONPAUSEBTN_DISABLED;
         if(this._playPauseBtn.enabled)
         {
            _loc2_ = this._vo.status == MISSIONS_STATES.IS_ON_PAUSE ? TOOLTIPS.PERSONALMISSIONS_ONPAUSEBTN_TURNOFFPAUSE : TOOLTIPS.PERSONALMISSIONS_ONPAUSEBTN_TURNONPAUSE;
         }
         this._toolTipMgr.showComplex(_loc2_);
      }
      
      private function onPlayPauseBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.ON_PAUSE_CLICKED,this._vo.eventID));
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onBottomStatus2LabelTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._vo)
         {
            showTooltip(this._vo.bottomStatusTooltipData);
         }
      }
      
      private function onObtainAwardBtnMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_RECRUITBTN);
      }
      
      private function onObtainAwardBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.OBTAIN_AWARD_CLICKED,this._vo.eventID));
      }
      
      private function onHoldAwardSheetBtnMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._vo)
         {
            showTooltip(this._vo.holdAwardSheetBtnTooltipData);
         }
      }
      
      private function onDiscardBtnMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_DISCARDBTN);
      }
      
      private function onRetryBtnMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._vo)
         {
            this._toolTipMgr.showComplex(this._vo.retryBtnTooltip);
         }
      }
      
      private function onStartBtnMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_STARTBTN);
      }
      
      private function onConditionsFullyTfMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_ADDITIONALCONDITIONS);
      }
      
      private function onConditionsTfMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_COMMONCONDITIONS);
      }
      
      private function onComponentMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onDiscardBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.DISCARD_CLICKED,this._vo.eventID));
      }
      
      private function onRetryBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.RETRY_CLICKED,this._vo.eventID));
      }
      
      private function onStartBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.START_CLICKED,this._vo.eventID));
      }
      
      private function onHoldAwardSheetBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalMissionDetailedViewEvent(PersonalMissionDetailedViewEvent.USE_SHEET_CLICKED,this._vo.eventID));
      }
      
      private function onConditionsContainerMouseWheelHandler(param1:MouseEvent) : void
      {
         if(this.scrollBar.visible)
         {
            this.scrollBar.position -= param1.delta * MOUSE_WHEEL_DELTA_FACTOR | 0;
            this.updateContainerPosByScroll();
         }
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         this.updateContainerPosByScroll();
      }
      
      private function onItemRendererLayoutCompletedHandler(param1:QuestProgressComponentEvent) : void
      {
         this._conditionsReady = true;
         invalidate(INVALIDATE_CONDITIONS_LAYOUT);
      }
      
      private function onLockRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.show(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_LOCKED);
      }
   }
}
