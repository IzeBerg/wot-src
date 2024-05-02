package net.wg.gui.rally.events
{
   import flash.events.Event;
   
   public class RallyViewsEvent extends Event
   {
      
      public static const CHOOSE_VEHICLE:String = "chooseVehicle";
      
      public static const LOAD_VIEW_REQUEST:String = "loadViewRequest";
      
      public static const BACK_NAVIGATION_REQUEST:String = "backNavigationRequest";
      
      public static const JOIN_RALLY_REQUEST:String = "joinRallyRequest";
      
      public static const ASSIGN_SLOT_REQUEST:String = "takePlaceRequest";
      
      public static const CREATE_CLAN_BATTLE_ROOM:String = "createClanBattleRoom";
      
      public static const INVITE_FRIEND_REQUEST:String = "inviteFriendRequest";
      
      public static const IGNORE_USER_REQUEST:String = "ignoreUserRequest";
      
      public static const TOGGLE_READY_STATE_REQUEST:String = "toggleReadyStateRequest";
      
      public static const EDIT_RALLY_DESCRIPTION:String = "editRallyDescription";
      
      public static const SHOW_FAQ_WINDOW:String = "showFAQWindow";
      
      public static const LEAVE_SLOT_REQUEST:String = "leavePlaceRequest";
      
      public static const ASSIGN_FREE_SLOT_REQUEST:String = "assignFreeSlotRequest";
      
      public static const VEH_BTN_ROLL_OVER:String = "vehBtnRollOver";
      
      public static const VEH_BTN_ROLL_OUT:String = "vehBtnRollOut";
      
      public static const VEH_UNFREEZE_REQUEST:String = "vehUnfreezeRequest";
       
      
      public var data;
      
      public function RallyViewsEvent(param1:String, param2:* = null)
      {
         super(param1,true,false);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new RallyViewsEvent(type,this.data);
      }
   }
}
