package net.wg.gui.battle.comp7.stats.components.events
{
   import flash.events.Event;
   
   public class VoiceChatActivationEvent extends Event
   {
      
      public static const CONTROL_CLICKED:String = "VoiceChatControlClicked";
       
      
      public function VoiceChatActivationEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new VoiceChatActivationEvent(type,bubbles,cancelable);
      }
   }
}
