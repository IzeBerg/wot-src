package net.wg.gui.components.controls.price
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class Price extends UIComponentEx
   {
      
      public static const ICON_ALIGN_LEFT:String = "left";
      
      public static const ICON_ALIGN_RIGHT:String = "right";
      
      public static const ACTION_STATE_SIMPLE:String = Discount.PERCENT_BG_STATE;
      
      public static const ACTION_STATE_SHOW_VALUE:String = Discount.WITH_VALUE_STATE;
      
      public static const ACTION_STATE_ONLY_BG:String = Discount.ONLY_BG_STATE;
      
      public static const ACTION_MODE_DISABLED:String = "disabled";
      
      public static const ACTION_MODE_ENABLED:String = "enabled";
      
      public static const ACTION_MODE_ALWAYS_SHOW:String = "alwaysShow";
      
      public static const OLD_PRICE_ALIGN_TOP:String = "oldPriceAlignTop";
      
      public static const OLD_PRICE_ALIGN_BOTTOM:String = "oldPriceAlignBottom";
      
      public static const OLD_PRICE_ALIGN_LEFT:String = "oldPriceAlignLeft";
      
      private static const ENABLE_ALPHA:Number = 1;
      
      private static const DISABLE_ALPHA:Number = 0.6;
      
      private static const SIZE_POSTFIX_DEFAULT:String = "";
      
      private static const SIZE_POSTFIX_BIG:String = "Big";
      
      private static const ERROR_POSTFIX:String = "Error";
      
      private static const DEFAULT_ICON_GAP:int = 1;
      
      private static const DEFAULT_ICON_OFFSET_Y_SMALL:int = 3;
      
      private static const DEFAULT_ICON_OFFSET_Y_BIG:int = 12;
      
      private static const TOOLTIP_W:int = 230;
      
      private static const OLD_PRICE_LINE_COLOR:uint = 9211006;
      
      private static const OLD_PRICE_HEIGHT_OFFSET:int = -4;
      
      private static const OLD_PRICE_OFFSET_SMALL_TOP:Point = new Point(0,8);
      
      private static const OLD_PRICE_OFFSET_BIG_TOP:Point = new Point(0,8);
      
      private static const OLD_PRICE_OFFSET_SMALL_BOTTOM:Point = new Point(0,-6);
      
      private static const OLD_PRICE_OFFSET_BIG_BOTTOM:Point = new Point(0,-6);
      
      private static const OLD_PRICE_OFFSET_SMALL_LEFT:Point = new Point(-5,0);
      
      private static const OLD_PRICE_OFFSET_BIG_LEFT:Point = new Point(-5,8);
       
      
      public var textField:TextField = null;
      
      public var icon:MovieClip = null;
      
      public var actionCmp:Discount = null;
      
      public var oldPriceTF:TextField = null;
      
      private var _data:PriceVO = null;
      
      private var _defaultData:PriceVO = null;
      
      private var _actionData:PriceVO = null;
      
      private var _isEnough:Boolean = true;
      
      private var _couponDiscount:int = 0;
      
      private var _actionMode:String = "enabled";
      
      private var _actionState:String;
      
      private var _iconAlign:String = "right";
      
      private var _iconOffset:Point;
      
      private var _actionOffset:Point;
      
      private var _sizePostfix:String = "";
      
      private var _contentWidth:int = 0;
      
      private var _contentHeight:int = 0;
      
      private var _bigFonts:Boolean = false;
      
      private var _actionTooltipEnabled:Boolean = false;
      
      private var _customActionTooltip:String = "";
      
      private var _oldPriceVisible:Boolean = false;
      
      private var _oldPriceLine:Sprite = null;
      
      private var _oldPriceAlign:String = "oldPriceAlignBottom";
      
      private var _oldPriceOffsetCustom:Point = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function Price()
      {
         this._actionState = ACTION_STATE_SIMPLE;
         this._iconOffset = new Point(0,0);
         this._actionOffset = new Point(0,0);
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(MouseEvent.ROLL_OVER,this.onActionCmpRollOverHandler,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onActionCmpRollOutHandler,false,0,true);
         this._oldPriceLine = new Sprite();
         addChild(this._oldPriceLine);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         super.draw();
         if(!this._data)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA,InvalidationType.STATE))
         {
            if(this._actionMode != ACTION_MODE_DISABLED && this._actionData)
            {
               this.actionCmp.data = this._actionData;
               this.actionCmp.state = this._actionState;
               this.actionCmp.visible = true;
               this.actionCmp.validateNow();
            }
            else if(this._actionMode == ACTION_MODE_ALWAYS_SHOW)
            {
               this.actionCmp.state = this._actionState != ACTION_STATE_SHOW_VALUE ? this._actionState : ACTION_STATE_SIMPLE;
               this.actionCmp.visible = true;
               this.actionCmp.validateNow();
            }
            else
            {
               this.actionCmp.visible = false;
            }
            _loc1_ = this._data.name;
            _loc2_ = _loc1_ + this._sizePostfix;
            if(!this._isEnough)
            {
               _loc2_ += ERROR_POSTFIX;
            }
            gotoAndStop(_loc2_);
            if(_baseDisposed)
            {
               return;
            }
            _loc3_ = _loc1_.indexOf(ERROR_POSTFIX);
            if(_loc3_ != Values.DEFAULT_INT)
            {
               _loc1_ = _loc1_.substring(0,_loc3_);
            }
            this.icon.gotoAndStop(_loc1_ + this._sizePostfix);
            if(_baseDisposed)
            {
               return;
            }
            this.textField.text = App.utils.locale.integer(this._data.value);
            App.utils.commons.updateTextFieldSize(this.textField);
            this._oldPriceLine.graphics.clear();
            if(this._defaultData && this._oldPriceVisible)
            {
               this.oldPriceTF.visible = this._oldPriceLine.visible = true;
               this.oldPriceTF.text = App.utils.locale.integer(this._defaultData.value);
               App.utils.commons.updateTextFieldSize(this.oldPriceTF);
               this._oldPriceLine.graphics.lineStyle(1,OLD_PRICE_LINE_COLOR);
               this._oldPriceLine.graphics.moveTo(0,0);
               this._oldPriceLine.graphics.lineTo(this.oldPriceTF.width,0);
            }
            else
            {
               this.oldPriceTF.visible = this._oldPriceLine.visible = false;
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
            dispatchEvent(new Event(Event.RESIZE,false,true));
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onActionCmpRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onActionCmpRollOutHandler);
         this.textField = null;
         this.icon = null;
         this.actionCmp.dispose();
         this.actionCmp = null;
         this.oldPriceTF = null;
         this._data = null;
         this._defaultData = null;
         this._actionData = null;
         this._iconOffset = null;
         this._actionOffset = null;
         this._toolTipMgr = null;
         if(this._oldPriceLine)
         {
            this._oldPriceLine.graphics.clear();
            removeChild(this._oldPriceLine);
            this._oldPriceLine = null;
         }
         this._oldPriceOffsetCustom = null;
         super.onDispose();
      }
      
      public function setData(param1:PriceVO, param2:PriceVO = null, param3:PriceVO = null) : void
      {
         this._data = param1;
         this._actionData = this._data && param2 && param2.value != 0 ? param2 : null;
         this._defaultData = this._data && param3 && param3.value != this._data.value ? param3 : null;
         invalidateData();
      }
      
      private function updateLayout() : void
      {
         var _loc4_:Point = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = null;
         if(this.oldPriceTF.visible)
         {
            _loc4_ = this.oldPriceOffset;
            if(this._oldPriceAlign == OLD_PRICE_ALIGN_LEFT)
            {
               this.oldPriceTF.x = 0;
               _loc1_ = this.oldPriceTF.width - _loc4_.x;
            }
            else if(this._oldPriceAlign == OLD_PRICE_ALIGN_TOP)
            {
               this.oldPriceTF.y = 0;
               _loc2_ = this.oldPriceTF.height - _loc4_.y;
            }
         }
         if(this._iconAlign == ICON_ALIGN_LEFT)
         {
            this.icon.x = _loc1_;
            this.textField.x = this.icon.x + this.icon.width + DEFAULT_ICON_GAP + this._iconOffset.x | 0;
            _loc3_ = this.textField.x + this.textField.width;
         }
         else
         {
            this.textField.x = _loc1_;
            this.icon.x = this.textField.x + this.textField.width + this._iconOffset.x + DEFAULT_ICON_GAP | 0;
            _loc3_ = this.icon.x + this.icon.width;
         }
         this.textField.y = _loc2_;
         var _loc5_:int = _loc2_ + this.textField.height;
         this.icon.y = _loc2_ + this._iconOffset.y + (!!this._bigFonts ? DEFAULT_ICON_OFFSET_Y_BIG : DEFAULT_ICON_OFFSET_Y_SMALL);
         var _loc6_:InteractiveObject = this._iconAlign == ICON_ALIGN_LEFT ? this.textField : this.icon;
         if(this.actionCmp && this.actionCmp.visible)
         {
            this.actionCmp.x = _loc6_.x + _loc6_.width + this._actionOffset.x | 0;
            this.actionCmp.y = this.textField.y + (this.textField.height >> 1) + this._actionOffset.y | 0;
            _loc5_ = Math.max(_loc5_,this.actionCmp.contentHeight);
            _loc3_ = this.actionCmp.x + this.actionCmp.contentWidth;
         }
         if(this.oldPriceTF.visible)
         {
            if(this._oldPriceAlign == OLD_PRICE_ALIGN_TOP)
            {
               this.oldPriceTF.x = this.textField.x + _loc4_.x | 0;
            }
            else if(this._oldPriceAlign == OLD_PRICE_ALIGN_BOTTOM)
            {
               this.oldPriceTF.x = this.textField.x + _loc4_.x | 0;
               this.oldPriceTF.y = this.textField.y + this.textField.height + _loc4_.y | 0;
               _loc5_ = this.oldPriceTF.y + this.oldPriceTF.height + OLD_PRICE_HEIGHT_OFFSET;
            }
            else if(this._oldPriceAlign == OLD_PRICE_ALIGN_LEFT)
            {
               this.oldPriceTF.y = _loc4_.y | 0;
            }
            this._oldPriceLine.x = this.oldPriceTF.x;
            this._oldPriceLine.y = this.oldPriceTF.y + 0.5 * this.oldPriceTF.height | 0;
         }
         this._contentWidth = _loc3_;
         this._contentHeight = _loc5_;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         alpha = !!param1 ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
         super.enabled = param1;
      }
      
      public function set actionTooltipEnabled(param1:Boolean) : void
      {
         this._actionTooltipEnabled = param1;
      }
      
      public function set customActionTooltip(param1:String) : void
      {
         this._customActionTooltip = param1;
      }
      
      public function set bigFonts(param1:Boolean) : void
      {
         if(this._bigFonts == param1)
         {
            return;
         }
         this._bigFonts = param1;
         this._sizePostfix = !!param1 ? SIZE_POSTFIX_BIG : SIZE_POSTFIX_DEFAULT;
         invalidateState();
      }
      
      public function set actionState(param1:String) : void
      {
         if(param1 == this._actionState)
         {
            return;
         }
         this._actionState = param1;
         if(this._actionMode != ACTION_MODE_DISABLED)
         {
            invalidateState();
         }
      }
      
      public function set actionMode(param1:String) : void
      {
         if(param1 == this._actionMode)
         {
            return;
         }
         this._actionMode = param1;
         invalidateState();
      }
      
      public function get iconOffset() : Point
      {
         return this._iconOffset;
      }
      
      public function set iconOffset(param1:Point) : void
      {
         if(param1 == null)
         {
            param1 = new Point();
         }
         if(!this._iconOffset.equals(param1))
         {
            this._iconOffset = param1;
            invalidateSize();
         }
      }
      
      public function set iconAlign(param1:String) : void
      {
         if(this._iconAlign == param1)
         {
            return;
         }
         this._iconAlign = param1;
         invalidateSize();
      }
      
      public function get contentWidth() : int
      {
         return this._contentWidth;
      }
      
      public function get contentHeight() : int
      {
         return this._contentHeight;
      }
      
      public function set actionOffset(param1:Point) : void
      {
         if(param1 == null)
         {
            param1 = new Point();
         }
         if(!this._actionOffset.equals(param1))
         {
            this._actionOffset = param1;
            invalidateSize();
         }
      }
      
      public function get oldPriceOffset() : Point
      {
         if(this._oldPriceOffsetCustom == null)
         {
            switch(this._oldPriceAlign)
            {
               case OLD_PRICE_ALIGN_LEFT:
                  return !!this._bigFonts ? OLD_PRICE_OFFSET_BIG_LEFT : OLD_PRICE_OFFSET_SMALL_LEFT;
               case OLD_PRICE_ALIGN_TOP:
                  return !!this._bigFonts ? OLD_PRICE_OFFSET_BIG_TOP : OLD_PRICE_OFFSET_SMALL_TOP;
               case OLD_PRICE_ALIGN_BOTTOM:
            }
            return !!this._bigFonts ? OLD_PRICE_OFFSET_BIG_BOTTOM : OLD_PRICE_OFFSET_SMALL_BOTTOM;
         }
         return this._oldPriceOffsetCustom;
      }
      
      public function set isEnough(param1:Boolean) : void
      {
         if(this._isEnough == param1)
         {
            return;
         }
         this._isEnough = param1;
         invalidateState();
      }
      
      public function get itemType() : String
      {
         if(this._data)
         {
            return this._data.name;
         }
         return Values.EMPTY_STR;
      }
      
      public function set oldPriceVisible(param1:Boolean) : void
      {
         if(this._oldPriceVisible != param1)
         {
            this._oldPriceVisible = param1;
            invalidateState();
         }
      }
      
      public function set oldPriceAlign(param1:String) : void
      {
         if(this._oldPriceAlign != param1)
         {
            this._oldPriceAlign = param1;
            if(this._oldPriceVisible)
            {
               invalidateState();
            }
         }
      }
      
      public function set couponDiscount(param1:Number) : void
      {
         this._couponDiscount = param1;
      }
      
      private function onActionCmpRollOverHandler(param1:MouseEvent) : void
      {
         if(this._actionTooltipEnabled)
         {
            if(StringUtils.isNotEmpty(this._customActionTooltip))
            {
               this._toolTipMgr.showComplex(this._customActionTooltip);
            }
            else if(this._defaultData != null)
            {
               if(this._couponDiscount > 0)
               {
                  this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FRONTLINE_PRICE_DISCOUNT,new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,0,0,TOOLTIP_W),this._data.value,this._defaultData.value,this._defaultData.name,this._couponDiscount);
               }
               else
               {
                  this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.PRICE_DISCOUNT,null,this._data.value,this._defaultData.value,this._defaultData.name);
               }
            }
         }
      }
      
      private function onActionCmpRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
