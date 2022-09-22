package net.wg.gui.lobby.badges.events
{
   import flash.events.Event;
   
   public class BadgesEvent extends Event
   {
      
      public static const BACK_BUTTON_CLICK:String = "backButtonClick";
      
      public static const BADGE_CHANGE:String = "badgeChange";
      
      public static const BADGE_RENDERER_CLICK:String = "badgeRendererClick";
      
      public static const BADGE_DESELECT:String = "badgeDeselect";
      
      public static const SUFFIX_BADGE_DESELECT:String = "suffixBadgeDeselect";
      
      public static const SUFFIX_BADGE_SELECT:String = "suffixBadgeSelect";
       
      
      public var badgeID:int = -1;
      
      public var selected:Boolean;
      
      public function BadgesEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1)
      {
         this.badgeID = param4;
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BadgesEvent(type,bubbles,cancelable,this.badgeID);
      }
      
      override public function toString() : String
      {
         return formatToString("BadgesEvent","type","bubbles","cancelable","badgeID");
      }
   }
}
