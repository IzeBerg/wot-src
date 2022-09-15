package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class PersonalMissionDetailedViewEvent extends Event
   {
      
      public static const ON_PAUSE_CLICKED:String = "onPauseClicked";
      
      public static const USE_SHEET_CLICKED:String = "useSheetClicked";
      
      public static const START_CLICKED:String = "startClicked";
      
      public static const RETRY_CLICKED:String = "retryClicked";
      
      public static const DISCARD_CLICKED:String = "discardClicked";
      
      public static const OBTAIN_AWARD_CLICKED:String = "obtainAwardClicked";
      
      public static const CONTROLS_VISIBLE_SET:String = "controlsVisibleSet";
       
      
      private var _eventID:String;
      
      public function PersonalMissionDetailedViewEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._eventID = param2;
      }
      
      override public function clone() : Event
      {
         return new PersonalMissionDetailedViewEvent(type,this.eventID,bubbles,cancelable);
      }
      
      public function get eventID() : String
      {
         return this._eventID;
      }
   }
}
