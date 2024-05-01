package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class SoundEvent extends Event
   {
      
      public static const TRIGGER_SOUND:String = "onTriggerSound";
       
      
      public var sndName:String = "";
      
      public function SoundEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.sndName = param2;
      }
      
      override public function clone() : Event
      {
         return new SoundEvent(type,this.sndName,bubbles,cancelable);
      }
   }
}
