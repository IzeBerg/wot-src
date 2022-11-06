package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class LifeCycleEvent extends Event
   {
      
      public static const ON_BEFORE_POPULATE:String = "onBeforePopulate";
      
      public static const ON_AFTER_POPULATE:String = "onAfterPopulate";
      
      public static const ON_POPULATE:String = ON_AFTER_POPULATE;
      
      public static const ON_GRAPHICS_RECTANGLES_UPDATE:String = "onGraphicsRectanglesUpdate";
      
      public static const ON_BEFORE_DISPOSE:String = "onBefireDispose";
      
      public static const ON_AFTER_DISPOSE:String = "onAfterDispose";
      
      public static const ON_DISPOSE:String = ON_BEFORE_DISPOSE;
       
      
      public function LifeCycleEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new LifeCycleEvent(type,bubbles,cancelable);
      }
   }
}
