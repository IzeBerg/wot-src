package net.wg.gui.lobby.profile.pages.formations
{
   import flash.events.Event;
   
   public class ShowTeamEvent extends Event
   {
      
      public static const TYPE:String = "ShowTeamEvent";
       
      
      private var _teamId:int;
      
      public function ShowTeamEvent(param1:int)
      {
         super(TYPE,true,false);
         this._teamId = param1;
      }
      
      public function get teamId() : int
      {
         return this._teamId;
      }
   }
}
