package net.wg.gui.lobby.battleResults.cs
{
   import flash.events.Event;
   
   public class CsTeamEvent extends Event
   {
      
      public static var TO_TEAM_CARD_CLICK:String = "toTeamCardClick";
       
      
      public var teamDBID:Number = -1;
      
      public function CsTeamEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = -1)
      {
         super(param1,param2,param3);
         this.teamDBID = param4;
      }
      
      override public function clone() : Event
      {
         return new CsTeamEvent(type,bubbles,cancelable,this.teamDBID);
      }
      
      override public function toString() : String
      {
         return formatToString("CsTeamEvent","type","bubbles","cancelable","eventPhase","teamDBID");
      }
   }
}
