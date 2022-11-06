package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class ColorSchemeEvent extends Event
   {
      
      public static const SCHEMAS_UPDATED:String = "schemas";
       
      
      public function ColorSchemeEvent(param1:String)
      {
         super(param1);
      }
   }
}
