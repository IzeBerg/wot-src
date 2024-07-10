package net.wg.gui.lobby.hangar.alertMessage
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.ALERTMESSAGE_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   import net.wg.infrastructure.base.meta.IAlertMessageBlockMeta;
   import net.wg.infrastructure.base.meta.impl.AlertMessageBlockMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class AlertMessageBlock extends AlertMessageBlockMeta implements IPopOverCaller, IAlertMessageBlockMeta
   {
      
      private static const ALERT_TO_MESSAGE_GAP:int = 5;
      
      private static const MESSAGE_ICON_GAP:int = 9;
      
      private static const BTN_TEXT_PADDING:int = 15;
      
      private static const ADDITIONAL_ALPHA_NORMAL:Number = 0.8;
      
      private static const ADDITIONAL_ALPHA_OVER:int = 1;
      
      private static const HOVER_SUFFIX:String = "_hover";
      
      private static const FILTER_SMALL:DropShadowFilter = new DropShadowFilter(0,0,16711680,1,8,8,1.5,3);
      
      private static const FILTER_FULL:DropShadowFilter = new DropShadowFilter(0,0,16711680,1,16,16,2,3);
       
      
      public var bg:MovieClip = null;
      
      public var alertIcon:Image = null;
      
      public var messageTF:TextField = null;
      
      public var additionalTF:TextField = null;
      
      public var popoverIconButton:UniversalBtn = null;
      
      public var tooltipArea:Sprite = null;
      
      private var _data:AlertMessageBlockVO = null;
      
      private var _originalBtnW:int = 0;
      
      private var _btnClickHandler:Function = null;
      
      private var _utils:IUtils;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _isInfoState:Boolean = false;
      
      private var _isShadowFilterVisible:Boolean = false;
      
      public function AlertMessageBlock()
      {
         this._utils = App.utils;
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function onDispose() : void
      {
         this.tooltipArea.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.tooltipArea.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.tooltipArea.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.alertIcon.removeEventListener(Event.CHANGE,this.onAlertIconChangeHandler);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.popoverIconButton.removeEventListener(ButtonEvent.CLICK,this.onIconButtonClickHandler);
         this.popoverIconButton.dispose();
         this.popoverIconButton = null;
         this.messageTF = null;
         this.additionalTF = null;
         this.bg = null;
         this.tooltipArea = null;
         this._data = null;
         this._btnClickHandler = null;
         this._utils = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.alertIcon.addEventListener(Event.CHANGE,this.onAlertIconChangeHandler);
         this._utils.universalBtnStyles.setStyle(this.popoverIconButton,UniversalBtnStylesConst.STYLE_SLIM_GREEN);
         this._originalBtnW = this.popoverIconButton.width;
         this.popoverIconButton.addEventListener(ButtonEvent.CLICK,this.onIconButtonClickHandler);
         this.tooltipArea.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.tooltipArea.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.tooltipArea.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._data != null)
         {
            _loc1_ = this._data.buttonVisible;
            if(isInvalid(InvalidationType.DATA))
            {
               this.bg.visible = this._data.bgVisible;
               this.popoverIconButton.visible = _loc1_;
               this._isInfoState = this._data.state === ALERTMESSAGE_CONSTANTS.ALERT_MESSAGE_STATE_INFO;
               this._isShadowFilterVisible = this._data.shadowFilterVisible;
               this.messageTF.htmlText = this._data.statusText;
               this._utils.commons.updateTextFieldSize(this.messageTF,true,false);
               if(this._data.state === ALERTMESSAGE_CONSTANTS.ALERT_MESSAGE_STATE_DEFAULT)
               {
                  if(_loc1_)
                  {
                     this.popoverIconButton.tooltip = this._data.buttonTooltip;
                     this.popoverIconButton.iconSource = this._data.buttonIcon;
                     if(StringUtils.isNotEmpty(this._data.buttonLabel))
                     {
                        this.popoverIconButton.label = this._data.buttonLabel;
                        this.popoverIconButton.dynamicSizeByText = true;
                        this.popoverIconButton.paddingHorizontal = BTN_TEXT_PADDING;
                     }
                     else
                     {
                        this.popoverIconButton.width = this._originalBtnW;
                     }
                     this.popoverIconButton.validateNow();
                  }
                  if(StringUtils.isNotEmpty(this._data.alertIcon))
                  {
                     this.alertIcon.source = this._data.alertIcon;
                  }
               }
               else if(this._data.state === ALERTMESSAGE_CONSTANTS.ALERT_MESSAGE_STATE_INFO)
               {
                  this.additionalTF.htmlText = this._data.additionalText;
                  this._utils.commons.updateTextFieldSize(this.additionalTF,true,false);
               }
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               if(this._data.state === ALERTMESSAGE_CONSTANTS.ALERT_MESSAGE_STATE_DEFAULT)
               {
                  _loc5_ = !!_loc1_ ? int(MESSAGE_ICON_GAP + this.popoverIconButton.width) : int(0);
                  _loc2_ = this.alertIcon.width + ALERT_TO_MESSAGE_GAP + this.messageTF.width;
                  _loc3_ = this.bg.width - _loc2_ - _loc5_ >> 1;
                  this.alertIcon.x = _loc4_ = _loc3_;
                  _loc3_ += this.alertIcon.width + ALERT_TO_MESSAGE_GAP;
                  this.messageTF.x = _loc3_;
                  if(_loc1_)
                  {
                     _loc3_ += this.messageTF.width + MESSAGE_ICON_GAP;
                     this.popoverIconButton.x = _loc3_;
                  }
               }
               else if(this._data.state === ALERTMESSAGE_CONSTANTS.ALERT_MESSAGE_STATE_INFO)
               {
                  _loc2_ = this.additionalTF.width + ALERT_TO_MESSAGE_GAP + this.messageTF.width;
                  _loc3_ = this.bg.width - _loc2_ >> 1;
                  this.additionalTF.x = _loc4_ = _loc3_;
                  this.messageTF.x = _loc3_ + this.additionalTF.width + ALERT_TO_MESSAGE_GAP >> 0;
               }
               this.alertIcon.visible = !this._isInfoState;
               this.additionalTF.visible = this._isInfoState;
               this.setLabelsStyle(!this._isInfoState);
               this.tooltipArea.useHandCursor = this.tooltipArea.buttonMode = this._isInfoState;
               this.bg.gotoAndStop(this._data.state);
               if(this._data.tooltip)
               {
                  this.tooltipArea.x = _loc4_;
                  this.tooltipArea.y = Math.min(this.alertIcon.y,this.messageTF.y);
                  this.tooltipArea.width = _loc2_;
                  this.tooltipArea.height = Math.max(this.alertIcon.height,this.messageTF.height);
               }
            }
         }
      }
      
      override protected function setData(param1:AlertMessageBlockVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.popoverIconButton;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.popoverIconButton;
      }
      
      public function setLocalData(param1:AlertMessageBlockVO) : void
      {
         this.setData(param1);
      }
      
      override public function get height() : Number
      {
         return this.messageTF.height;
      }
      
      public function set btnClickHandler(param1:Function) : void
      {
         this._btnClickHandler = param1;
      }
      
      private function onAlertIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function setLabelsStyle(param1:Boolean) : void
      {
         if(this._isShadowFilterVisible)
         {
            this.messageTF.filters = !!param1 ? [FILTER_SMALL] : [FILTER_FULL];
         }
         else
         {
            this.messageTF.filters = [];
         }
         this.additionalTF.alpha = !!param1 ? Number(ADDITIONAL_ALPHA_OVER) : Number(ADDITIONAL_ALPHA_NORMAL);
      }
      
      private function onIconButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this._data.popoverAlias)
         {
            App.popoverMgr.show(this,this._data.popoverAlias,null);
         }
         else if(this._btnClickHandler != null)
         {
            this._btnClickHandler();
         }
         else
         {
            onButtonClickS();
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data && this._data.tooltip)
         {
            if(this._data.isSimpleTooltip)
            {
               this._tooltipMgr.showComplex(this._data.tooltip);
            }
            else
            {
               this._tooltipMgr.showSpecial(this._data.tooltip,null,null);
            }
            if(this._isInfoState)
            {
               this.setLabelsStyle(true);
            }
            this.bg.gotoAndStop(this._data.state + HOVER_SUFFIX);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._data && this._data.tooltip)
         {
            this._tooltipMgr.hide();
            if(this._isInfoState)
            {
               this.setLabelsStyle(false);
            }
            this.bg.gotoAndStop(this._data.state);
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         onBlockClickS();
      }
   }
}
