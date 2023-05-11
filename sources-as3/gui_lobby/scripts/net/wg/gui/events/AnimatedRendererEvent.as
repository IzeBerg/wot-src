package net.wg.gui.events
{
   import flash.events.Event;
   
   public class AnimatedRendererEvent extends Event
   {
      
      public static const RENERER_ANIMATION_FINISHED:String = "rendererAnimationFinished";
      
      public static const ANIMATION_FINISHED:String = "animationFinished";
       
      
      public var index:uint = 0;
      
      public function AnimatedRendererEvent(param1:String, param2:uint = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.index = param2;
      }
      
      override public function clone() : Event
      {
         return new AnimatedRendererEvent(type,this.index,bubbles,cancelable);
      }
   }
}
