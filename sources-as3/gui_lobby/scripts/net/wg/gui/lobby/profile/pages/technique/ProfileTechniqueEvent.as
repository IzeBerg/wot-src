package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   
   public class ProfileTechniqueEvent extends Event
   {
      
      public static const VIEW_RATING_BTN_CLICK:String = "viewRatingBtnClick";
      
      public static const PRESTIGE_WIDGET_ENABLED:String = "prestigeWidgetEnabled";
      
      public static const PRESTIGE_WIDGET_DISABLED:String = "prestigeWidgetDisabled";
       
      
      public function ProfileTechniqueEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ProfileTechniqueEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ProfileTechniqueEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
