package net.wg.gui.lobby.battleRoyale.events
{
   import flash.events.Event;
   
   public class BattleTypeSelectorEvent extends Event
   {
      
      public static const BATTLE_TYPE_SELECTOR_VISIBILITY_CHANGED:String = "visibilityChanged";
       
      
      private var _isVisible:Boolean;
      
      public function BattleTypeSelectorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true)
      {
         this._isVisible = param4;
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BattleTypeSelectorEvent(type,bubbles,cancelable,this.isVisible);
      }
      
      override public function toString() : String
      {
         return formatToString("BattleTypeSelectorEvent","type","bubbles","cancelable","isVisible");
      }
      
      public function get isVisible() : Boolean
      {
         return this._isVisible;
      }
   }
}
