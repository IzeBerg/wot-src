package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.events.Event;
   
   public class UnlockLinkEvent extends Event
   {
      
      public static const TYPE:String = "BATTLE_RESULTS_UNLOCK_LINK_BTN_EVENT";
       
      
      private var _unlockType:String;
      
      private var _itemId:int;
      
      public function UnlockLinkEvent(param1:String, param2:int)
      {
         this._unlockType = param1;
         this._itemId = param2;
         super(TYPE,true);
      }
      
      public function get unlockType() : String
      {
         return this._unlockType;
      }
      
      public function get itemId() : int
      {
         return this._itemId;
      }
   }
}
