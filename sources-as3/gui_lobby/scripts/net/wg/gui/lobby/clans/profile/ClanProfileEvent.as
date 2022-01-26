package net.wg.gui.lobby.clans.profile
{
   import flash.events.Event;
   
   public class ClanProfileEvent extends Event
   {
      
      public static const HEADER_BUTTON_CLICK:String = "actionButtonClick";
      
      public static const SHOW_WAITING:String = "showWaiting";
      
      public static const HIDE_WAITING:String = "hideWaiting";
      
      public static const NAVIGATION_BY_LINKAGE:String = "navigationByLinkage";
       
      
      private var _actionId:String = null;
      
      private var _targetLinkage:String = "";
      
      public function ClanProfileEvent(param1:String, param2:String, param3:String)
      {
         super(param1,true);
         this._actionId = param2;
         this._targetLinkage = param3;
      }
      
      public function getActionID() : String
      {
         return this._actionId;
      }
      
      public function getTargetLinkage() : String
      {
         return this._targetLinkage;
      }
   }
}
