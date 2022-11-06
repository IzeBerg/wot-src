package net.wg.gui.components.controls.price
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DiscountBG extends UIComponentEx
   {
      
      public static const ONLY_BG_STATE:String = "camouflage";
      
      public static const PERCENT_BG_STATE:String = "percentBG";
      
      public static const UNLOCK_BG_TYPE:String = "unlock";
      
      public static const BUY_BG_TYPE:String = "buy";
      
      private static const SEPARATION_FRAME_SYMBOL:String = "_";
       
      
      private var _type:String = "buy";
      
      private var _state:String = "percentBG";
      
      public function DiscountBG()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            gotoAndStop(this._type + SEPARATION_FRAME_SYMBOL + this._state);
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         invalidateState();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidateState();
      }
   }
}
