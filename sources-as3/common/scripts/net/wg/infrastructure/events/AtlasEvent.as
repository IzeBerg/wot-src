package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class AtlasEvent extends Event
   {
      
      public static const ATLAS_INITIALIZED:String = "atlasInitializedEvent";
       
      
      public function AtlasEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new AtlasEvent(type,bubbles,cancelable);
      }
   }
}
