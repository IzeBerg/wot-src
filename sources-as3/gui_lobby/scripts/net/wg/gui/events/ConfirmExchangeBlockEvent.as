package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ConfirmExchangeBlockEvent extends Event
   {
      
      public static const VALUE_CHANGED:String = "valueChanged";
       
      
      private var _isEnough:Boolean;
      
      private var _isNull:Boolean;
      
      public function ConfirmExchangeBlockEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._isEnough = param2;
         this._isNull = param3;
      }
      
      public function get isEnough() : Boolean
      {
         return this._isEnough;
      }
      
      public function get isNull() : Boolean
      {
         return this._isNull;
      }
   }
}
