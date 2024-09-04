package net.wg.gui.lobby.window
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.IconText;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class ExchangeHeader extends UIComponentEx implements IExchangeHeader
   {
      
      private static const CENTER_PADDING:uint = 20;
      
      private static const ACTION_CENTER_OFFSET:int = -8;
      
      private static const EQUALS_SIGN_PADDING:int = -2;
      
      private static const DISCOUNT_MC_PADDING:int = -5;
      
      private static const RATE_LABEL_OFFSET:int = -42;
      
      private static const RATE_FROM_DEFAULT_TEXT:String = "1";
      
      private static const SIGN_MC_STATE_NORMAL:String = "normal";
      
      private static const SIGN_MC_STATE_ACTION:String = "action";
      
      private static const LAYOUT_INVALID:String = "layout_invalid";
      
      private static const USUAL_DECOR_INVALID:String = "usual_decor_invalid";
      
      private static const FADE_DURATION:uint = 250;
       
      
      public var rateFrom:IconText;
      
      public var rateTo:IconText;
      
      public var signMc:MovieClip;
      
      public var rateLabel:TextField;
      
      public var actionDecor:MovieClip;
      
      public var usualDecor:MovieClip;
      
      public var discountMc:MovieClip;
      
      public var actionHitMc:Sprite;
      
      public var actionPriceBg:ActionPriceBg;
      
      public var isForFreeMode:Boolean = false;
      
      public var isActionMode:Boolean = false;
      
      private var _rateLabelFunction:Function;
      
      private var _rate:int;
      
      private var _actionRate:int;
      
      private var _actualRate:int;
      
      private var _infoContainer:Sprite;
      
      private var _locale:ILocale;
      
      private var _useBackDecor:Boolean = true;
      
      private var _useActionOffset:Boolean = true;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _needItemsType:String = null;
      
      private var _isDiscountLimited:Boolean = false;
      
      private var _goldValue:int = 0;
      
      private var _tween:Tween = null;
      
      private var _isFadeOut:Boolean = false;
      
      private var _isFadeIn:Boolean = false;
      
      public function ExchangeHeader()
      {
         this._infoContainer = new Sprite();
         this._locale = Boolean(App.utils) ? App.utils.locale : null;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tryClearTween();
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onActionHitMcMouseOverHandler);
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onActionHitMcMouseOutHandler);
         this.actionHitMc.removeEventListener(MouseEvent.MOUSE_DOWN,this.onActionHitMcMouseDownHandler);
         this.rateFrom.dispose();
         this.rateFrom = null;
         this.rateTo.dispose();
         this.actionPriceBg = null;
         this.rateTo = null;
         this.signMc = null;
         this.rateLabel = null;
         this.actionDecor = null;
         this.usualDecor = null;
         this.discountMc = null;
         this.actionHitMc = null;
         this._infoContainer = null;
         this._rateLabelFunction = null;
         this._locale = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rateLabel.autoSize = TextFieldAutoSize.LEFT;
         this.rateTo.textField.autoSize = this.rateFrom.textField.autoSize = TextFieldAutoSize.LEFT;
         this.rateFrom.text = RATE_FROM_DEFAULT_TEXT;
         this.rateFrom.validateNow();
         this._infoContainer.addChild(this.rateLabel);
         this._infoContainer.addChild(this.rateFrom);
         this._infoContainer.addChild(this.signMc);
         this._infoContainer.addChild(this.rateTo);
         addChild(this._infoContainer);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onActionHitMcMouseOverHandler);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onActionHitMcMouseOutHandler);
         this.actionHitMc.addEventListener(MouseEvent.MOUSE_DOWN,this.onActionHitMcMouseDownHandler);
         this.setChildIndex(this.actionHitMc,this.numChildren - 1);
         this.actionPriceBg.visible = false;
         this.actionPriceBg.state = ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP;
         this.actionPriceBg.mouseChildren = false;
         this.actionPriceBg.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this._actualRate = !!this.isActionMode ? int(this._actionRate) : int(this._rate);
            this.discountMc.visible = this.isActionMode;
            this.actionDecor.visible = this.isActionMode;
            this.signMc.gotoAndStop(!!this.isActionMode ? SIGN_MC_STATE_ACTION : SIGN_MC_STATE_NORMAL);
            this.applyRateText();
         }
         if(isInvalid(USUAL_DECOR_INVALID))
         {
            this.usualDecor.visible = this._useBackDecor && !this.isActionMode;
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.rateFrom.visible = !this.isForFreeMode;
            this.rateTo.visible = !this.isForFreeMode;
            this.signMc.visible = !this.isForFreeMode;
            if(this.isForFreeMode)
            {
               this.rateLabel.x = this.width - (this.rateLabel.width + this.actionPriceBg.width + RATE_LABEL_OFFSET) >> 1 ^ 0;
               if(!this.isActionMode)
               {
                  this.actionPriceBg.x = this.rateLabel.x + this.rateLabel.width + this.actionPriceBg.width + RATE_LABEL_OFFSET ^ 0;
                  this.actionPriceBg.visible = true;
               }
            }
            else
            {
               this.rateFrom.x = this.rateLabel.width + CENTER_PADDING ^ 0;
               this.signMc.x = this.rateFrom.x + this.rateFrom.actualWidth + EQUALS_SIGN_PADDING ^ 0;
               this.rateTo.x = this.signMc.x + this.signMc.width + EQUALS_SIGN_PADDING ^ 0;
               _loc1_ = this.rateTo.x + this.rateTo.actualWidth;
               this._infoContainer.x = width - _loc1_ >> 1;
               if(this.isActionMode)
               {
                  if(this._useActionOffset)
                  {
                     this._infoContainer.x += ACTION_CENTER_OFFSET;
                  }
                  this.discountMc.x = this._infoContainer.x + _loc1_ + DISCOUNT_MC_PADDING;
               }
            }
         }
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
      
      public function setData(param1:ExchangeHeaderVO, param2:String, param3:Boolean) : void
      {
         this.rateLabel.htmlText = param1.labelText;
         this.rateFrom.textColor = param1.rateFromTextColor;
         this.rateTo.textColor = param1.rateToTextColor;
         this.rateFrom.icon = param1.rateFromIcon;
         this.rateTo.icon = param1.rateToIcon;
         this._needItemsType = param2;
         this.setFilters();
         invalidate(InvalidationType.DATA,LAYOUT_INVALID,USUAL_DECOR_INVALID);
      }
      
      public function setRates(param1:int, param2:int, param3:Boolean, param4:int) : void
      {
         this._rate = param1;
         this._actionRate = param2;
         this._isDiscountLimited = param3;
         this._goldValue = param4;
         invalidate(InvalidationType.DATA,LAYOUT_INVALID,USUAL_DECOR_INVALID);
      }
      
      private function setFilters() : void
      {
         this.rateFrom.filters = this.rateTo.filters = null;
         this.rateFrom.filters = ExchangeUtils.getGlow(this.rateFrom.icon);
         this.rateTo.filters = ExchangeUtils.getGlow(this.rateTo.icon);
      }
      
      private function showTooltip() : void
      {
         if(this.isActionMode)
         {
            if(this._isDiscountLimited)
            {
               this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EXCHANGE_RATE_LIMITED_DISCOUNT_INFO,this._needItemsType,this._goldValue);
            }
            else
            {
               this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EXCHANGE_RATE_DISCOUNT_INFO,this._needItemsType);
            }
         }
      }
      
      private function applyRateText() : void
      {
         if(this._rateLabelFunction != null)
         {
            this.rateTo.text = this._rateLabelFunction(this._actualRate);
         }
         else
         {
            this.rateTo.text = this._locale.gold(this._actualRate);
         }
         this.rateTo.validateNow();
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
      
      public function set useBackDecor(param1:Boolean) : void
      {
         this._useBackDecor = param1;
         invalidate(USUAL_DECOR_INVALID);
      }
      
      public function set useActionOffset(param1:Boolean) : void
      {
         this._useActionOffset = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      private function onActionHitMcMouseOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      private function onActionHitMcMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onActionHitMcMouseDownHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
