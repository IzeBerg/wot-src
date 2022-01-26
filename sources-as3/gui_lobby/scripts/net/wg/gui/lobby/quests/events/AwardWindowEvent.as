package net.wg.gui.lobby.quests.events
{
   import flash.events.Event;
   
   public class AwardWindowEvent extends Event
   {
      
      public static const AWARD_RENDERER_READY:String = "awardRendererReady";
       
      
      public function AwardWindowEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}
