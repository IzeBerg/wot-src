package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class TutorialUbComponentEvent extends Event
   {
      
      private static const TUTORIAL_UB_COMPONENT_PROP_CHANGE:String = "tutorialUbComponentPropChange";
      
      public static const ENABLED:String = "isEnabledForTutorial";
       
      
      public var propertyName:String = null;
      
      public var propertyValue:Object = null;
      
      public function TutorialUbComponentEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(TUTORIAL_UB_COMPONENT_PROP_CHANGE,param3,param4);
         this.propertyName = param1;
         this.propertyValue = param2;
      }
      
      override public function clone() : Event
      {
         return new TutorialUbComponentEvent(this.propertyName,this.propertyValue,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("TutorialUbComponentEvent","propertyName","propertyValue","bubbles","cancelable","eventPhase");
      }
   }
}
