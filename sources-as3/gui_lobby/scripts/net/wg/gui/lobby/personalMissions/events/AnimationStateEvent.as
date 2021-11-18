package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class AnimationStateEvent extends Event
   {
      
      public static const FADE_IN_COMPLETE:String = "fadeInComplete";
      
      public static const FADE_OUT_COMPLETE:String = "fadeOutComplete";
      
      public static const ANIM_COMPLETE:String = "animComplete";
      
      public static const MOVE_START:String = "moveStart";
       
      
      public function AnimationStateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new AnimationStateEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("AnimationStateEvent","type","bubbles","cancelable");
      }
   }
}
