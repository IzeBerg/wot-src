package net.wg.gui.lobby.profile
{
   import flash.events.Event;
   
   public class ProfileOpenInfoEvent extends Event
   {
      
      public static const CLAN:String = "clan";
       
      
      public var id:Number = NaN;
      
      public function ProfileOpenInfoEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
