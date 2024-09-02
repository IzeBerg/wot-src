package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ConfirmExchangeBlockEvent extends Event
   {
      
      public static const VALUE_CHANGED:String = "valueChanged";
      
      public static const ON_INFO_WARNING_BTN:String = "onInfoWarningBtn";
       
      
      private var _isNull:Boolean;
      
      private var _goldValue:int;
      
      private var _needItemsValue:int;
      
      public function ConfirmExchangeBlockEvent(param1:String, param2:Boolean = true, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this._isNull = param2;
         this._goldValue = param3;
         this._needItemsValue = param4;
      }
      
      override public function clone() : Event
      {
         return new ConfirmExchangeBlockEvent(type,this._isNull,this._goldValue,this._needItemsValue);
      }
      
      public function get isNull() : Boolean
      {
         return this._isNull;
      }
      
      public function get goldValue() : int
      {
         return this._goldValue;
      }
      
      public function get needItemsValue() : int
      {
         return this._needItemsValue;
      }
   }
}
