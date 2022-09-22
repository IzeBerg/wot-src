package net.wg.gui.lobby.battleResults.cs
{
   import flash.events.Event;
   import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
   
   public class CsTeamEmblemEvent extends Event
   {
      
      public static var TEAM_EMBLEM_REQUEST:String = "teamEmblemRequest";
       
      
      public var teamDBID:Number = -1;
      
      public var requestID:String = "";
      
      public var delegate:IEmblemLoadedDelegate = null;
      
      public function CsTeamEmblemEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = -1, param5:String = "", param6:IEmblemLoadedDelegate = null)
      {
         super(param1,param2,param3);
         this.teamDBID = param4;
         this.requestID = param5;
         this.delegate = param6;
      }
      
      override public function clone() : Event
      {
         return new CsTeamEmblemEvent(type,bubbles,cancelable,this.teamDBID,this.requestID,this.delegate);
      }
      
      override public function toString() : String
      {
         return formatToString("CsTeamEmblemEvent","type","bubbles","cancelable","eventPhase","teamDBID","requestID","callbackFn");
      }
   }
}
