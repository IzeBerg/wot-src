package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   
   public class MissionViewEvent extends Event
   {
      
      public static const SHOW_WAITING:String = "showWaiting";
      
      public static const NY_BANNER_GOTO_DAILY:String = "nyBannerGotoQuests";
      
      public static const NY_BANNER_GOTO_CHALLENGE:String = "nyBannerGotoChallenge";
       
      
      public var isWaiting:Boolean;
      
      public function MissionViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:MissionViewEvent = new MissionViewEvent(type,bubbles,cancelable);
         _loc1_.isWaiting = this.isWaiting;
         return _loc1_;
      }
   }
}
