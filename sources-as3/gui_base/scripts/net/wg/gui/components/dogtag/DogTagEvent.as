package net.wg.gui.components.dogtag
{
   import flash.events.Event;
   
   public class DogTagEvent extends Event
   {
      
      public static const ON_VICTIM_DOGTAG_FADE_OUT:String = "onVictimDogTagFadeOut";
      
      public static const ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START:String = "onDogtagComponentAnimateHideStart";
       
      
      public function DogTagEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new DogTagEvent(type,bubbles,cancelable);
      }
   }
}
