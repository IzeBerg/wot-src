package net.wg.gui.crewOperations
{
   import flash.events.Event;
   
   public class CrewOperationEvent extends Event
   {
      
      public static const OPERATION_CHANGED:String = "crewOperChanged";
       
      
      public var operationName:String;
      
      public function CrewOperationEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.operationName = param2;
      }
      
      override public function clone() : Event
      {
         return new CrewOperationEvent(type,this.operationName,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CrewOperationEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
