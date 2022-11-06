package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class UserInfoTextEvent extends Event
   {
      
      public static const USER_NAME_CHANGED:String = "userNameChanged";
      
      public static const USER_RATING_CHANGED:String = "userRatingChanged";
       
      
      public function UserInfoTextEvent(param1:String)
      {
         super(param1,true,true);
      }
   }
}
