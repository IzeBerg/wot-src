package net.wg.gui.components.controls.price
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class Discount extends UIComponentEx
   {
      
      public static const ONLY_BG_STATE:String = DiscountBG.ONLY_BG_STATE;
      
      public static const PERCENT_BG_STATE:String = DiscountBG.PERCENT_BG_STATE;
      
      public static const WITH_VALUE_STATE:String = "withValue";
      
      private static const UNLOCK_VALUE_FRAME:String = "unlockValue";
      
      private static const BUY_VALUE_FRAME:String = "buyValue";
       
      
      public var bg:DiscountBG = null;
      
      public var hit:Sprite = null;
      
      public var valueTF:TextField = null;
      
      private var _state:String = "camouflage";
      
      private var _data:PriceVO = null;
      
      public function Discount()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.STATE,InvalidationType.DATA))
         {
            if(this._state != WITH_VALUE_STATE)
            {
               gotoAndStop(this._state);
               this.bg.state = this._state;
            }
            if(this._data)
            {
               _loc1_ = this._data.name == CURRENCIES_CONSTANTS.XP_COST;
               if(this._state == WITH_VALUE_STATE)
               {
                  if(_loc1_)
                  {
                     gotoAndStop(UNLOCK_VALUE_FRAME);
                  }
                  else
                  {
                     gotoAndStop(BUY_VALUE_FRAME);
                  }
                  this.bg.state = DiscountBG.PERCENT_BG_STATE;
                  this.valueTF.text = App.utils.locale.integer(this._data.value);
               }
               this.bg.type = !!_loc1_ ? DiscountBG.UNLOCK_BG_TYPE : DiscountBG.BUY_BG_TYPE;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg.dispose();
         this.bg = null;
         this.hit = null;
         this.valueTF = null;
         this._data = null;
         super.onDispose();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         invalidateState();
      }
      
      public function get data() : PriceVO
      {
         return this._data;
      }
      
      public function set data(param1:PriceVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function get contentHeight() : Number
      {
         if(this.hit)
         {
            return this.hit.height;
         }
         return Values.ZERO;
      }
      
      public function get contentWidth() : Number
      {
         if(this.hit)
         {
            return this.hit.width;
         }
         return Values.ZERO;
      }
   }
}
