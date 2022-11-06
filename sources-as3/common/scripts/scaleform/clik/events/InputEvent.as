package scaleform.clik.events
{
   import flash.events.Event;
   import scaleform.clik.ui.InputDetails;
   
   public class InputEvent extends Event
   {
      
      public static const INPUT:String = "input";
       
      
      public var details:InputDetails;
      
      public function InputEvent(param1:String, param2:InputDetails)
      {
         super(param1,true,true);
         this.details = param2;
      }
      
      public function get handled() : Boolean
      {
         return isDefaultPrevented();
      }
      
      public function set handled(param1:Boolean) : void
      {
         if(param1)
         {
            preventDefault();
         }
      }
      
      override public function clone() : Event
      {
         return new InputEvent(type,this.details);
      }
      
      override public function toString() : String
      {
         return formatToString("InputEvent","type","details");
      }
   }
}
