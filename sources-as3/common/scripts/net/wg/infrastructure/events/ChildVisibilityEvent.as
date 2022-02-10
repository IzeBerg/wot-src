package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class ChildVisibilityEvent extends Event
   {
      
      public static const CHILD_SHOWN:String = "childShown";
      
      public static const CHILD_HIDDEN:String = "childHidden";
       
      
      public function ChildVisibilityEvent(param1:String)
      {
         super(param1,true,true);
      }
      
      override public function clone() : Event
      {
         return new ChildVisibilityEvent(type);
      }
   }
}
