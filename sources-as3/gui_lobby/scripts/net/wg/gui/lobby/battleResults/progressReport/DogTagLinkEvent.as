package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.events.Event;
   
   public class DogTagLinkEvent extends Event
   {
      
      public static const BATTLE_RESULTS_DOG_TAG_LINK_BTN_EVENT:String = "battle_results_dog_tag_link_btn_event";
       
      
      private var _unlockType:String;
      
      private var _componentId:int;
      
      public function DogTagLinkEvent(param1:int)
      {
         this._componentId = param1;
         super(BATTLE_RESULTS_DOG_TAG_LINK_BTN_EVENT,true);
      }
      
      public function get unlockType() : String
      {
         return this._unlockType;
      }
      
      public function get componentId() : int
      {
         return this._componentId;
      }
   }
}
