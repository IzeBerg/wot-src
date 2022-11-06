package net.wg.gui.events
{
   import flash.events.Event;
   
   public class TrainingEvent extends Event
   {
      
      public static const OPEN_TRAINING_ROOM:String = "openTrainingRoom";
       
      
      public var initObj:Object;
      
      public var initArr:Array;
      
      public function TrainingEvent(param1:String, param2:Object = null, param3:Array = null)
      {
         super(param1,true,true);
         this.initObj = param2;
         this.initArr = param3;
      }
      
      override public function clone() : Event
      {
         return new TrainingEvent(type,this.initObj,this.initArr);
      }
   }
}
