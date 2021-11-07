package net.wg.gui.lobby.colorSettings.events
{
   import flash.events.Event;
   
   public class ColorSettingsSliderEvent extends Event
   {
      
      public static const FILTER_POWER_SLIDER_CHANGE:String = "FILTER_POWER_SLIDER_CHANGE";
      
      public static const BRIGHTNESS_SLIDER_CHANGE:String = "BRIGHTNESS_SLIDER_CHANGE";
      
      public static const CONTRAST_SLIDER_CHANGE:String = "CONTRAST_SLIDER_CHANGE";
      
      public static const SATURATION_SLIDER_CHANGE:String = "SATURATION_SLIDER_CHANGE";
       
      
      private var _sliderValue:int = -1;
      
      public function ColorSettingsSliderEvent(param1:String, param2:int)
      {
         super(param1,bubbles,cancelable);
         this._sliderValue = param2;
      }
      
      override public function clone() : Event
      {
         return new ColorSettingsSliderEvent(type,this._sliderValue);
      }
      
      public function get sliderValue() : int
      {
         return this._sliderValue;
      }
   }
}
