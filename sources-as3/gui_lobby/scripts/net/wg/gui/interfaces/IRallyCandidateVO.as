package net.wg.gui.interfaces
{
   public interface IRallyCandidateVO extends IExtendedUserVO
   {
       
      
      function get isCommander() : Boolean;
      
      function get color() : Number;
      
      function get rating() : String;
      
      function get isOffline() : Boolean;
      
      function set isOffline(param1:Boolean) : void;
      
      function get isPlayerSpeaking() : Boolean;
      
      function set isPlayerSpeaking(param1:Boolean) : void;
   }
}
