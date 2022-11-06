package net.wg.gui.battle.views.actionMarkers
{
   public class ActionMarkerStates
   {
      
      public static const PING_CREATE_STATE:int = 0;
      
      public static const REPLIED_ME:int = 1;
      
      public static const REPLIED_ALLY:int = 2;
      
      public static const NEUTRAL:int = 3;
      
      public static const STATE_INT_TO_STRING:Object = {
         0:"create",
         1:"repliedMe",
         2:"repliedAlly",
         3:"neutral"
      };
      
      public static const STATE_INT_TO_STRING_STICKY_OUT:Object = {
         0:"createOffScreen",
         1:"repliedMe",
         2:"repliedAlly",
         3:"neutral"
      };
       
      
      public function ActionMarkerStates()
      {
         super();
      }
   }
}
