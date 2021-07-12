package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ModuleInfoEvent extends Event
   {
      
      public static const SHOW_INFO:String = "showInfo";
       
      
      public var id:String;
      
      public function ModuleInfoEvent(param1:String, param2:String)
      {
         super(param1,true,true);
         this.id = param2;
      }
      
      override public function clone() : Event
      {
         return new ModuleInfoEvent(type,this.id);
      }
   }
}
