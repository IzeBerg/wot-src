package net.wg.gui.lobby.colorSettings.components
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsRendererEvent;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsSliderEvent;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.SliderEvent;
   
   public class ColorSettingsManualView extends UIComponentEx
   {
      
      private static const INVALID_SETTINGS:String = "INVALID_SETTINGS";
       
      
      public var titleTF:TextField = null;
      
      public var brightnessLabel:LabelControl = null;
      
      public var brightnessSlider:Slider = null;
      
      public var saturationLabel:LabelControl = null;
      
      public var saturationSlider:Slider = null;
      
      public var contrastLabel:LabelControl = null;
      
      public var contrastSlider:Slider = null;
      
      public var resetButton:ISoundButtonEx = null;
      
      private var _brightness:Number = 0;
      
      private var _contrast:Number = 0;
      
      private var _saturation:Number = 0;
      
      public function ColorSettingsManualView()
      {
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.resetButton.removeEventListener(ButtonEvent.CLICK,this.onResetButtonClickHandler);
         this.brightnessSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onBrightnessSliderValueChangeHandler);
         this.saturationSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSaturationSliderValueChangeHandler);
         this.contrastSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onContrastSliderValueChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.resetButton.dispose();
         this.resetButton = null;
         this.titleTF = null;
         this.brightnessLabel.dispose();
         this.brightnessLabel = null;
         this.contrastLabel.dispose();
         this.contrastLabel = null;
         this.brightnessSlider.dispose();
         this.brightnessSlider = null;
         this.contrastSlider.dispose();
         this.contrastSlider = null;
         this.saturationLabel.dispose();
         this.saturationLabel = null;
         this.saturationSlider.dispose();
         this.saturationSlider = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.resetButton.addEventListener(ButtonEvent.CLICK,this.onResetButtonClickHandler);
         this.brightnessSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onBrightnessSliderValueChangeHandler);
         this.brightnessSlider.maximum = 100;
         this.brightnessSlider.minimum = 0;
         this.saturationSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onSaturationSliderValueChangeHandler);
         this.saturationSlider.maximum = 100;
         this.saturationSlider.minimum = 0;
         this.contrastSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onContrastSliderValueChangeHandler);
         this.contrastSlider.maximum = 100;
         this.contrastSlider.minimum = 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SETTINGS))
         {
            this.brightnessSlider.value = this._brightness;
            this.contrastSlider.value = this._contrast;
            this.saturationSlider.value = this._saturation;
         }
      }
      
      public function setInitialData(param1:ColorSettingsVO) : void
      {
         this.titleTF.htmlText = param1.manualHeader;
         this.brightnessLabel.text = param1.brightnessLabel;
         this.contrastLabel.text = param1.contrastLabel;
         this.saturationLabel.text = param1.saturationLabel;
         this.resetButton.label = param1.resetLabel;
      }
      
      public function setSliderValues(param1:int, param2:int, param3:int) : void
      {
         this._brightness = param1;
         this._contrast = param2;
         this._saturation = param3;
         invalidate(INVALID_SETTINGS);
      }
      
      private function onContrastSliderValueChangeHandler(param1:SliderEvent) : void
      {
         dispatchEvent(new ColorSettingsSliderEvent(ColorSettingsSliderEvent.CONTRAST_SLIDER_CHANGE,param1.value));
      }
      
      private function onSaturationSliderValueChangeHandler(param1:SliderEvent) : void
      {
         dispatchEvent(new ColorSettingsSliderEvent(ColorSettingsSliderEvent.SATURATION_SLIDER_CHANGE,param1.value));
      }
      
      private function onBrightnessSliderValueChangeHandler(param1:SliderEvent) : void
      {
         dispatchEvent(new ColorSettingsSliderEvent(ColorSettingsSliderEvent.BRIGHTNESS_SLIDER_CHANGE,param1.value));
      }
      
      private function onResetButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ColorSettingsRendererEvent(ColorSettingsRendererEvent.RESET_CLICKED,Values.DEFAULT_INT));
      }
   }
}
