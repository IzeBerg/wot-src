package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;
   
   public class CSComponentEvent extends Event
   {
      
      public static const TOGGLE_FREEZE_REQUEST:String = "toggleFreezeRequest";
      
      public static const TOGGLE_STATUS_REQUEST:String = "toggleStatusRequest";
      
      public static const CLICK_CONFIGURE_BUTTON:String = "clickConfigureButton";
      
      public static const LOCK_SLOT_REQUEST:String = "lockSlotRequest";
      
      public static const APPLY_ROSTER_SETTINGS:String = "applyRosterSettings";
      
      public static const CANCEL_ROSTER_SETTINGS:String = "cancelRosterSettings";
      
      public static const CLICK_SLOT_SETTINGS_BTN:String = "clickSlotSettingsBtn";
      
      public static const SHOW_SETTINGS_ROSTER_WND:String = "showSettingsRosterWnd";
      
      public static const SHOW_AUTO_SEARCH_VIEW:String = "showAutoSearchView";
      
      public static const AUTO_SEARCH_APPLY_BTN:String = "autoSearchApplyBtn";
      
      public static const AUTO_SEARCH_CANCEL_BTN:String = "autoSearchCancelBtn";
       
      
      private var _data = null;
      
      public function CSComponentEvent(param1:String, param2:* = null)
      {
         super(param1,true,true);
         this._data = param2;
      }
      
      public function get data() : *
      {
         return this._data;
      }
   }
}
