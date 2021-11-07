package net.wg.gui.lobby.settings.events
{
   import flash.events.Event;
   
   public class SettingViewEvent extends Event
   {
      
      public static var ON_CONTROL_CHANGED:String = "on_control_changed";
      
      public static var ON_AUTO_DETECT_QUALITY:String = "on_auto_detect_quality";
      
      public static var ON_AUTO_DETECT_ACOUSTIC:String = "on_auto_detect_acoustic";
      
      public static var ON_SOUND_SPEAKER_CHANGE:String = "on_sound_speaker_change";
      
      public static var ON_VIVOX_TEST:String = "on_vivox_test";
      
      public static var ON_UPDATE_CAPTURE_DEVICE:String = "on_update_capture_device";
      
      public static var ON_PTT_CONTROL_CHANGED:String = "on_relate_control_changed";
      
      public static var ON_PTT_SOUND_CONTROL_CHANGED:String = "on_ptt_sound_control_changed";
      
      public static var ON_CONTROL_NEW_COUNTERS_VISITED:String = "on_control_new_counter_visited";
      
      public static var ON_GAMMA_SETTING_OPEN:String = "on_gamma_setting_open";
      
      public static var ON_COLOR_SETTING_OPEN:String = "on_color_setting_open";
       
      
      public var viewId:String;
      
      public var controlId:String;
      
      public var subViewId:String;
      
      public var controlValue:Object;
      
      public function SettingViewEvent(param1:String, param2:String, param3:String = null, param4:String = "", param5:Object = null, param6:Boolean = true, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.viewId = param2;
         this.subViewId = param3;
         this.controlId = param4;
         this.controlValue = param5;
      }
      
      override public function clone() : Event
      {
         return new SettingViewEvent(type,this.viewId,this.subViewId,this.controlId,this.controlValue,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("SettingViewEvent","type","viewId","subViewId","controlId","controlValue","bubbles","cancelable","eventPhase");
      }
   }
}
