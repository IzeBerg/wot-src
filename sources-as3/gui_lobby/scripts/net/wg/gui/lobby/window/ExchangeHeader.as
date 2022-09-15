package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.IconText;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
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
      
      private var _actionPrc:Number = 0;
      
      private var _rateLabelFunction:Function;
      
      private var _rate:int;
      
      private var _actionRate:int;
      
      private var _actualRate:int;
      
      private var _infoContainer:Sprite;
      
      private var _locale:ILocale;
      
      private var _useBackDecor:Boolean = true;
      
      private var _useActionOffset:Boolean = true;
      
      public function ExchangeHeader()
      {
         this._infoContainer = new Sprite();
         this._locale = Boolean(App.utils) ? App.utils.locale : null;
         super();
      }
      
      override protected function onDispose() : void
      {
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
         var _loc2_:Number = NaN;
         super.draw();
         var _loc1_:Boolean = false;
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rate != this._actionRate;
            this._actionPrc = !!_loc1_ ? Number(100 * (this._actionRate - this._rate) / this._rate) : Number(0);
            this._actualRate = !!_loc1_ ? int(this._actionRate) : int(this._rate);
            this.discountMc.visible = _loc1_ && this.isActionMode;
            this.actionDecor.visible = _loc1_ && this.isActionMode;
            this.signMc.gotoAndStop(!!_loc1_ ? SIGN_MC_STATE_ACTION : SIGN_MC_STATE_NORMAL);
            this.applyRateText();
            this.actionHitMc.visible = _loc1_ && this.isActionMode;
         }
         if(isInvalid(USUAL_DECOR_INVALID))
         {
            this.usualDecor.visible = this._useBackDecor && !_loc1_;
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
               _loc2_ = this.rateTo.x + this.rateTo.actualWidth;
               this._infoContainer.x = width - _loc2_ >> 1;
               if(_loc1_)
               {
                  if(this._useActionOffset)
                  {
                     this._infoContainer.x += ACTION_CENTER_OFFSET;
                  }
                  this.discountMc.x = this._infoContainer.x + _loc2_ + DISCOUNT_MC_PADDING;
               }
            }
         }
      }
      
      public function setData(param1:ExchangeHeaderVO) : void
      {
         this.rateLabel.htmlText = param1.labelText;
         this.rateFrom.textColor = param1.rateFromTextColor;
         this.rateTo.textColor = param1.rateToTextColor;
         this.rateFrom.icon = param1.rateFromIcon;
         this.rateTo.icon = param1.rateToIcon;
         this.setFilters();
         invalidate(InvalidationType.DATA,LAYOUT_INVALID,USUAL_DECOR_INVALID);
      }
      
      public function setRates(param1:int, param2:int) : void
      {
         this._rate = param1;
         this._actionRate = param2;
         invalidate(InvalidationType.DATA,LAYOUT_INVALID,USUAL_DECOR_INVALID);
      }
      
      private function setFilters() : void
      {
         this.rateFrom.filters = this.rateTo.filters = null;
         this.rateFrom.filters = ExchangeUtils.getGlow(this.rateFrom.icon);
         this.rateTo.filters = ExchangeUtils.getGlow(this.rateTo.icon);
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function showTooltip() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc1_:String = "";
         var _loc2_:Number = this._rate;
         var _loc3_:Number = this._actionRate;
         if(this._actionPrc > 0 && _loc2_ != 0)
         {
            _loc4_ = this.rateFrom.icon;
            _loc5_ = this.rateTo.icon;
            _loc6_ = App.utils.icons.getIcon16StrPath(_loc4_);
            _loc7_ = App.utils.icons.getIcon16StrPath(_loc5_);
            _loc8_ = _loc5_ == IconsTypes.GOLD ? this._locale.gold(Math.abs(_loc3_)) : this._locale.integer(Math.abs(_loc3_));
            _loc9_ = _loc5_ == IconsTypes.GOLD ? this._locale.gold(Math.abs(_loc2_)) : this._locale.integer(Math.abs(_loc2_));
            _loc8_ = " 1" + _loc6_ + "= " + _loc8_ + " " + _loc7_;
            _loc9_ = " 1" + _loc6_ + "= " + _loc9_ + " " + _loc7_;
            _loc1_ = App.toolTipMgr.getNewFormatter().addHeader(this._locale.makeString(TOOLTIPS.ACTIONPRICE_EXCHANGE_HEADER,{})).addBody(this._locale.makeString(TOOLTIPS.ACTIONPRICE_EXCHANGE_BODY,{
               "oldPrice":_loc9_,
               "newPrice":_loc8_
            })).make();
            if(_loc1_.length > 0)
            {
               App.toolTipMgr.showComplex(_loc1_);
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
         this.hideTooltip();
      }
      
      private function onActionHitMcMouseDownHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
