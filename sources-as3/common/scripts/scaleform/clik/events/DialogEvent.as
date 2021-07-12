package scaleform.clik.events
{
   import flash.events.Event;
   
   public class DialogEvent extends Event
   {
      
      public static const CLOSE:String = "dialogClose";
      
      public static const SUBMIT:String = "dialogSubmit";
       
      
      public function DialogEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}
