package net.wg.gui.lobby.window
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.VO.ConfirmExchangeBlockVO;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.events.ConfirmExchangeBlockEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class ConfirmExchangeBlockNotification extends UIComponentEx
   {
      
      private static const INFO_TEXT_MAX_NUM_LINES:uint = 2;
      
      private static const INFO_TEXT_DEFAULT_Y:uint = 12;
      
      private static const INFO_TEXT_ALIGN_MID_Y:uint = 18;
      
      private static const INFO_TEXT_BORDER_SIE:uint = 2;
      
      private static const INFO_ORANGE_ICON_OFFSET_Y:uint = 11;
      
      private static const INFO_WARNING_BTN_Y:uint = 2;
      
      private static const INFO_WARNING_BTN_OFFSET_Y:uint = 22;
      
      private static const INFO_WARNING_BTN_ALIGN_MID_Y:uint = 8;
      
      private static const INFO_WARNING_BTN_GAP_X:uint = 3;
      
      private static const INFO_WARNING_BTN_GAP_Y:uint = 1;
      
      private static const INFO_ICON_Y:uint = 17;
      
      private static const INFO_TEXT_DEFAULT_WIDTH:uint = 320;
      
      private static const INFO_WARNING_BTN_BORDER_X:uint = 356;
      
      private static const INV_STATE:String = "invState";
      
      private static const FADE_DURATION:uint = 250;
       
      
      public var infoText:TextField = null;
      
      public var infoOrangeIcon:Sprite = null;
      
      public var infoWarningBtn:InfoWarningBtn = null;
      
      private var _actionIsActive:Boolean = false;
      
      private var _discountsAmountLimitExceed:Boolean = false;
      
      private var _needItemsType:String = null;
      
      private var _goldValue:Number = 0;
      
      private var _data:ConfirmExchangeBlockVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _tween:Tween = null;
      
      private var _isFadeOut:Boolean = false;
      
      private var _isFadeIn:Boolean = false;
      
      public function ConfirmExchangeBlockNotification()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Rectangle = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = null;
            this.infoWarningBtn.label = this._data.limitRestrictionsBtnText;
            if(this._discountsAmountLimitExceed)
            {
               this.updateInfoText(this._data.discountLimitOverExceededText);
               if(this.infoText.numLines < INFO_TEXT_MAX_NUM_LINES)
               {
                  this.infoWarningBtn.x = this.infoText.x + this.infoText.textWidth + INFO_WARNING_BTN_GAP_X | 0;
                  this.infoWarningBtn.y = INFO_WARNING_BTN_Y;
                  if(this.infoWarningBtn.x + this.infoWarningBtn.actualWidth > INFO_WARNING_BTN_BORDER_X)
                  {
                     this.infoWarningBtn.x = this.infoText.x;
                     this.infoWarningBtn.y += INFO_WARNING_BTN_OFFSET_Y;
                  }
                  else
                  {
                     this.infoText.y = INFO_TEXT_ALIGN_MID_Y;
                     this.infoWarningBtn.y = INFO_WARNING_BTN_ALIGN_MID_Y;
                  }
               }
               else
               {
                  _loc1_ = this.infoText.getCharBoundaries(this.infoText.length - 1);
                  this.infoWarningBtn.x = _loc1_.x + _loc1_.width + INFO_WARNING_BTN_GAP_X | 0;
                  this.infoWarningBtn.y = _loc1_.y + INFO_WARNING_BTN_GAP_Y | 0;
               }
            }
            if(this._actionIsActive)
            {
               this.updateInfoText(this._data.discountLimitText);
               if(this.infoText.numLines < INFO_TEXT_MAX_NUM_LINES)
               {
                  this.infoText.y = INFO_TEXT_ALIGN_MID_Y;
                  this.infoOrangeIcon.x = this.infoText.x + this.infoText.textWidth + INFO_TEXT_BORDER_SIE | 0;
                  this.infoOrangeIcon.y = INFO_ICON_Y;
               }
               else
               {
                  _loc1_ = this.infoText.getCharBoundaries(this.infoText.length - 1);
                  this.infoOrangeIcon.x = _loc1_.x + _loc1_.width | 0;
                  this.infoOrangeIcon.y = _loc1_.y + INFO_ORANGE_ICON_OFFSET_Y | 0;
               }
            }
         }
         if(isInvalid(INV_STATE))
         {
            if(this._discountsAmountLimitExceed)
            {
               this.infoText.visible = true;
               this.infoWarningBtn.visible = true;
               this.infoOrangeIcon.visible = false;
               this.updateInfoText(this._data.discountLimitOverExceededText);
               if(this.infoText.numLines < INFO_TEXT_MAX_NUM_LINES)
               {
                  if(this.infoWarningBtn.x + this.infoWarningBtn.actualWidth < INFO_WARNING_BTN_BORDER_X)
                  {
                     this.infoText.y = INFO_TEXT_ALIGN_MID_Y;
                  }
               }
            }
            else if(this._actionIsActive)
            {
               this.infoText.visible = true;
               this.infoWarningBtn.visible = false;
               this.infoOrangeIcon.visible = true;
               this.updateInfoText(this._data.discountLimitText);
               if(this.infoText.numLines < INFO_TEXT_MAX_NUM_LINES)
               {
                  this.infoText.y = INFO_TEXT_ALIGN_MID_Y;
               }
            }
            else
            {
               this.infoText.visible = false;
               this.infoWarningBtn.visible = false;
               this.infoOrangeIcon.visible = false;
            }
            super.dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.tryClearTween();
         this.infoText.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler);
         this.infoText.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoRollOutHandler);
         this.infoText = null;
         this.infoOrangeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler);
         this.infoOrangeIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoRollOutHandler);
         this.infoOrangeIcon = null;
         this.infoWarningBtn.removeEventListener(MouseEvent.CLICK,this.onInfoWarningBtnClickHandler);
         this.infoWarningBtn.dispose();
         this.infoWarningBtn = null;
         this._data = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoText.addEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler);
         this.infoText.addEventListener(MouseEvent.ROLL_OUT,this.onInfoRollOutHandler);
         this.infoOrangeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoRollOverHandler);
         this.infoOrangeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onInfoRollOutHandler);
         this.infoWarningBtn.addEventListener(MouseEvent.CLICK,this.onInfoWarningBtnClickHandler);
      }
      
      public function fadeIn(param1:Boolean, param2:uint = 0) : void
      {
         if(this._isFadeIn)
         {
            return;
         }
         if(this._isFadeOut)
         {
            this.tryClearTween();
            this._isFadeOut = false;
         }
         visible = true;
         if(!param1)
         {
            this._isFadeIn = true;
            return;
         }
         alpha = 0;
         this.tryClearTween();
         this._isFadeIn = true;
         this._tween = new Tween(FADE_DURATION,this,{"alpha":1},{
            "delay":param2,
            "paused":false,
            "onComplete":this.onFadeInComplete,
            "ease":Strong.easeInOut
         });
      }
      
      public function fadeOut(param1:Boolean, param2:uint = 0) : void
      {
         if(this._isFadeOut)
         {
            return;
         }
         if(this._isFadeIn)
         {
            this.tryClearTween();
            this._isFadeIn = false;
         }
         if(!param1)
         {
            visible = false;
            return;
         }
         alpha = 1;
         this.tryClearTween();
         this._isFadeOut = true;
         this._tween = new Tween(FADE_DURATION,this,{"alpha":0},{
            "delay":param2,
            "paused":false,
            "onComplete":this.onFadeOutComplete,
            "ease":Strong.easeInOut
         });
      }
      
      public function setData(param1:ConfirmExchangeBlockVO, param2:String) : void
      {
         this._data = param1;
         this._needItemsType = param2;
         invalidateData();
      }
      
      private function onFadeInComplete(param1:Tween) : void
      {
         this.tryClearTween();
      }
      
      private function onFadeOutComplete(param1:Tween) : void
      {
         this.tryClearTween();
         visible = false;
         this._isFadeOut = false;
      }
      
      private function tryClearTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function updateInfoText(param1:String) : void
      {
         this.infoText.y = INFO_TEXT_DEFAULT_Y;
         this.infoText.width = INFO_TEXT_DEFAULT_WIDTH;
         this.infoText.text = param1;
         App.utils.commons.updateTextFieldSize(this.infoText,true,true);
      }
      
      override public function get height() : Number
      {
         return this.infoText.height;
      }
      
      public function set actionIsActive(param1:Boolean) : void
      {
         if(this._actionIsActive == param1)
         {
            return;
         }
         this._actionIsActive = param1;
         invalidate(INV_STATE);
      }
      
      public function set discountsAmountLimitExceed(param1:Boolean) : void
      {
         if(this._discountsAmountLimitExceed == param1)
         {
            return;
         }
         this._discountsAmountLimitExceed = param1;
         invalidate(INV_STATE);
      }
      
      public function set goldValue(param1:Number) : void
      {
         this._goldValue = param1;
      }
      
      private function onInfoRollOverHandler(param1:MouseEvent) : void
      {
         if(this._discountsAmountLimitExceed)
         {
            return;
         }
         if(this._actionIsActive)
         {
            this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EXCHANGE_RATE_LIMITED_DISCOUNT_INFO,this._needItemsType,this._goldValue);
         }
         else
         {
            this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EXCHANGE_RATE_DISCOUNT_INFO,this._needItemsType);
         }
      }
      
      private function onInfoRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onInfoWarningBtnClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ConfirmExchangeBlockEvent(ConfirmExchangeBlockEvent.ON_INFO_WARNING_BTN,true,0,0,true));
      }
   }
}
