package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   
   public class MissionHeaderEvent extends Event
   {
      
      public static const COLLAPSE:String = "MissionCollapseEvent";
      
      public static const MOVE_TO_ACTION:String = "MissionMoveToActionEvent";
      
      public static const OPEN_INFO_PAGE:String = "MissionOpenInfoPageEvent";
       
      
      public var actionId:String;
      
      public var missionId:String;
      
      public var isCollapsed:Boolean = true;
      
      public function MissionHeaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:MissionHeaderEvent = new MissionHeaderEvent(type,bubbles,cancelable);
         _loc1_.actionId = this.actionId;
         _loc1_.missionId = this.missionId;
         _loc1_.isCollapsed = this.isCollapsed;
         return _loc1_;
      }
   }
}
