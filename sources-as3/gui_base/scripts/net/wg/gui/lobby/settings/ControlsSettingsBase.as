package net.wg.gui.lobby.settings
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.settings.components.KeysScrollingList;
   
   public class ControlsSettingsBase extends SettingsBaseView
   {
       
      
      public var keyboardFieldSet:FieldSet = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var keys:KeysScrollingList = null;
      
      public var mouseFieldSet:FieldSet = null;
      
      public var mouseSensitivityLabel:TextField = null;
      
      public var mouseArcadeSensLabel:TextField = null;
      
      public var mouseArcadeSensSlider:Slider = null;
      
      public var mouseSniperSensLabel:TextField = null;
      
      public var mouseSniperSensSlider:Slider = null;
      
      public var mouseStrategicSensLabel:TextField = null;
      
      public var mouseStrategicSensSlider:Slider = null;
      
      public var mouseAssistAimSensLabel:TextField = null;
      
      public var mouseAssistAimSensSlider:Slider = null;
      
      public var mouseHorzInvertCheckbox:CheckBox = null;
      
      public var mouseVertInvertCheckbox:CheckBox = null;
      
      public var backDraftInvertCheckbox:CheckBox = null;
      
      public var defaultBtn:SoundButtonEx = null;
      
      public function ControlsSettingsBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.keyboardFieldSet.dispose();
         this.keyboardFieldSet = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.keys.dispose();
         this.keys = null;
         this.mouseFieldSet.dispose();
         this.mouseFieldSet = null;
         this.mouseSensitivityLabel = null;
         this.mouseArcadeSensLabel = null;
         this.mouseArcadeSensSlider.dispose();
         this.mouseArcadeSensSlider = null;
         this.mouseSniperSensLabel = null;
         this.mouseSniperSensSlider.dispose();
         this.mouseSniperSensSlider = null;
         this.mouseStrategicSensLabel = null;
         this.mouseStrategicSensSlider.dispose();
         this.mouseStrategicSensSlider = null;
         this.mouseAssistAimSensLabel = null;
         this.mouseAssistAimSensSlider.dispose();
         this.mouseAssistAimSensSlider = null;
         this.mouseHorzInvertCheckbox.dispose();
         this.mouseHorzInvertCheckbox = null;
         this.mouseVertInvertCheckbox.dispose();
         this.mouseVertInvertCheckbox = null;
         this.backDraftInvertCheckbox.dispose();
         this.backDraftInvertCheckbox = null;
         this.defaultBtn.dispose();
         this.defaultBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.keyboardFieldSet.label = SETTINGS.KEYBOARD_KEYBOARD;
         this.mouseFieldSet.label = SETTINGS.KEYBOARD_MOUSE;
         this.mouseSensitivityLabel.text = SETTINGS.MOUSE_SENSITIVITY_HEADER;
         this.mouseArcadeSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_MAIN;
         this.mouseSniperSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_SNIPER;
         this.mouseStrategicSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_ART;
         this.mouseAssistAimSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_ART2;
         this.mouseHorzInvertCheckbox.label = SETTINGS.MOUSE_SENSITIVITY_INVERTATIONHOR;
         this.mouseHorzInvertCheckbox.toolTip = TOOLTIPS.SETTINGS_MOUSE_SENSITIVITY_INVERTATIONHOR;
         this.mouseHorzInvertCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.mouseVertInvertCheckbox.label = SETTINGS.MOUSE_SENSITIVITY_INVERTATIONVERT;
         this.mouseVertInvertCheckbox.toolTip = TOOLTIPS.SETTINGS_MOUSE_SENSITIVITY_INVERTATIONVERT;
         this.mouseVertInvertCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.backDraftInvertCheckbox.label = SETTINGS.KEYBOARD_BACKDRAFTINVERT;
         this.backDraftInvertCheckbox.toolTip = TOOLTIPS.SETTINGS_KEYBOARD_BACKDRAFTINVERT;
         this.backDraftInvertCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.defaultBtn.label = SETTINGS.DEFAULTBTN;
         this.defaultBtn.enabled = false;
         super.configUI();
      }
   }
}
