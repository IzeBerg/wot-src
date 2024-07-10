package net.wg.gui.lobby.settings
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.lobby.settings.components.SoundDeviceButtonBar;
   import net.wg.gui.lobby.settings.components.SoundVoiceWaves;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   
   public class SoundSettingsBase extends SettingsBaseView
   {
      
      private static const TOOLTIP_PREFIX:String = "sounds/";
       
      
      public var masterVolumeToggleCheckbox:CheckBox = null;
      
      public var masterVolumeLabel:LabelControl = null;
      
      public var masterVolumeSlider:Slider = null;
      
      public var masterVolumeValue:LabelControl = null;
      
      public var volumeFieldSet:FieldSet = null;
      
      public var soundQualityCheckbox:CheckBox = null;
      
      public var subtitlesCheckbox:CheckBox = null;
      
      public var musicVolumeLabel:LabelControl = null;
      
      public var musicVolumeSlider:Slider = null;
      
      public var musicVolumeValue:LabelControl = null;
      
      public var musicHangarLabel:LabelControl = null;
      
      public var musicHangarSlider:Slider = null;
      
      public var musicHangarValue:LabelControl = null;
      
      public var vehiclesVolumeLabel:LabelControl = null;
      
      public var vehiclesVolumeSlider:Slider = null;
      
      public var vehiclesVolumeValue:LabelControl = null;
      
      public var effectsVolumeLabel:LabelControl = null;
      
      public var effectsVolumeSlider:Slider = null;
      
      public var effectsVolumeValue:LabelControl = null;
      
      public var guiVolumeLabel:LabelControl = null;
      
      public var guiVolumeSlider:Slider = null;
      
      public var guiVolumeValue:LabelControl = null;
      
      public var voiceNotificationVolumeLabel:LabelControl = null;
      
      public var voiceNotificationVolumeSlider:Slider = null;
      
      public var voiceNotificationVolumeValue:LabelControl = null;
      
      public var ambientVolumeLabel:LabelControl = null;
      
      public var ambientVolumeSlider:Slider = null;
      
      public var ambientVolumeValue:LabelControl = null;
      
      public var soundOtherFieldSet:FieldSet = null;
      
      public var bulbVoicesLabel:LabelControl = null;
      
      public var bulbVoicesButton:IconTextButton = null;
      
      public var bulbVoicesDropDown:DropdownMenu = null;
      
      public var artyBulbVoicesIcon:UILoaderAlt = null;
      
      public var artyBulbVoicesLabel:LabelControl = null;
      
      public var artyBulbVoicesDropDown:DropdownMenu = null;
      
      public var artyBulbVoicesButton:IconTextButton = null;
      
      public var alternativeVoicesLabel:LabelControl = null;
      
      public var testAlternativeVoicesButton:IconTextButton = null;
      
      public var alternativeVoicesDropDown:DropdownMenu = null;
      
      public var presetsFieldSet:FieldSet = null;
      
      public var soundDeviceButtonBar:SoundDeviceButtonBar = null;
      
      public var soundSpeakersDropDown:DropdownMenu = null;
      
      public var soundDeviceAlert:InfoIcon = null;
      
      public var soundSpeakersTestButton:IconTextButton = null;
      
      public var bassBoostCheckbox:CheckBox = null;
      
      public var nightModeCheckbox:CheckBox = null;
      
      public var voiceConnectFieldSet:FieldSet = null;
      
      public var microphoneFieldSet:FieldSet = null;
      
      public var enableVoIPCheckbox:CheckBox = null;
      
      public var PTTLabel:LabelControl = null;
      
      public var PTTKeyInput:KeyInput = null;
      
      public var captureDeviceLabel:LabelControl = null;
      
      public var captureDeviceDropDown:DropdownMenu = null;
      
      public var btnCaptureDevicesUpdate:SoundButtonEx = null;
      
      public var btnVivoxTest:SoundButtonEx = null;
      
      public var voiceAnimationText:TextField = null;
      
      public var masterVivoxVolumeLabel:LabelControl = null;
      
      public var masterVivoxVolumeSlider:Slider = null;
      
      public var masterVivoxVolumeValue:LabelControl = null;
      
      public var micVivoxVolumeLabel:LabelControl = null;
      
      public var micVivoxVolumeSlider:Slider = null;
      
      public var micVivoxVolumeValue:LabelControl = null;
      
      public var masterFadeVivoxVolumeLabel:LabelControl = null;
      
      public var masterFadeVivoxVolumeSlider:Slider = null;
      
      public var masterFadeVivoxVolumeValue:LabelControl = null;
      
      public var specialVolumeFieldSet:FieldSet = null;
      
      public var specialGuiVolumeLabel:LabelControl = null;
      
      public var specialGuiVolumeSlider:Slider = null;
      
      public var specialGuiVolumeValue:LabelControl = null;
      
      public var specialVoiceNotificationVolumeLabel:LabelControl = null;
      
      public var specialVoiceNotificationVolumeSlider:Slider = null;
      
      public var specialVoiceNotificationVolumeValue:LabelControl = null;
      
      public var specialVehiclesVolumeLabel:LabelControl = null;
      
      public var specialVehiclesVolumeSlider:Slider = null;
      
      public var specialVehiclesVolumeValue:LabelControl = null;
      
      public var specialEffectsVolumeLabel:LabelControl = null;
      
      public var specialEffectsVolumeSlider:Slider = null;
      
      public var specialEffectsVolumeValue:LabelControl = null;
      
      public var specialAmbientVolumeLabel:LabelControl = null;
      
      public var specialAmbientVolumeSlider:Slider = null;
      
      public var specialAmbientVolumeValue:LabelControl = null;
      
      public var specialMusicVolumeLabel:LabelControl = null;
      
      public var specialMusicVolumeSlider:Slider = null;
      
      public var specialMusicVolumeValue:LabelControl = null;
      
      public var voiceAnimation:SoundVoiceWaves = null;
      
      public var tabs:ContentTabBar = null;
      
      public var commonForm:SoundCommonForm = null;
      
      public var vivoxForm:SoundVivoxForm = null;
      
      public var specialForm:SoundSpecialForm = null;
      
      public function SoundSettingsBase()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         this.volumeFieldSet = this.commonForm.volumeFieldSet;
         this.soundQualityCheckbox = this.commonForm.soundQualityCheckbox;
         this.subtitlesCheckbox = this.commonForm.subtitlesCheckbox;
         this.musicVolumeLabel = this.commonForm.musicVolumeLabel;
         this.musicVolumeSlider = this.commonForm.musicVolumeSlider;
         this.musicVolumeValue = this.commonForm.musicVolumeValue;
         this.musicHangarLabel = this.commonForm.musicHangarLabel;
         this.musicHangarSlider = this.commonForm.musicHangarSlider;
         this.musicHangarValue = this.commonForm.musicHangarValue;
         this.vehiclesVolumeLabel = this.commonForm.vehiclesVolumeLabel;
         this.vehiclesVolumeSlider = this.commonForm.vehiclesVolumeSlider;
         this.vehiclesVolumeValue = this.commonForm.vehiclesVolumeValue;
         this.effectsVolumeLabel = this.commonForm.effectsVolumeLabel;
         this.effectsVolumeSlider = this.commonForm.effectsVolumeSlider;
         this.effectsVolumeValue = this.commonForm.effectsVolumeValue;
         this.guiVolumeLabel = this.commonForm.guiVolumeLabel;
         this.guiVolumeSlider = this.commonForm.guiVolumeSlider;
         this.guiVolumeValue = this.commonForm.guiVolumeValue;
         this.voiceNotificationVolumeLabel = this.commonForm.voiceNotificationVolumeLabel;
         this.voiceNotificationVolumeSlider = this.commonForm.voiceNotificationVolumeSlider;
         this.voiceNotificationVolumeValue = this.commonForm.voiceNotificationVolumeValue;
         this.ambientVolumeLabel = this.commonForm.ambientVolumeLabel;
         this.ambientVolumeSlider = this.commonForm.ambientVolumeSlider;
         this.ambientVolumeValue = this.commonForm.ambientVolumeValue;
         this.soundOtherFieldSet = this.commonForm.soundOtherFieldSet;
         this.bulbVoicesLabel = this.commonForm.bulbVoicesLabel;
         this.alternativeVoicesLabel = this.commonForm.alternativeVoicesLabel;
         this.bulbVoicesButton = this.commonForm.bulbVoicesButton;
         this.bulbVoicesDropDown = this.commonForm.bulbVoicesDropDown;
         this.alternativeVoicesDropDown = this.commonForm.alternativeVoicesDropDown;
         this.testAlternativeVoicesButton = this.commonForm.testAlternativeVoicesButton;
         this.artyBulbVoicesIcon = this.commonForm.artyBulbVoicesIcon;
         this.artyBulbVoicesLabel = this.commonForm.artyBulbVoicesLabel;
         this.artyBulbVoicesDropDown = this.commonForm.artyBulbVoicesDropDown;
         this.artyBulbVoicesButton = this.commonForm.artyBulbVoicesButton;
         this.presetsFieldSet = this.commonForm.presetsFieldSet;
         this.soundDeviceButtonBar = this.commonForm.soundDeviceButtonBar;
         this.soundSpeakersDropDown = this.commonForm.soundSpeakersDropDown;
         this.soundDeviceAlert = this.commonForm.soundDeviceAlert;
         this.soundSpeakersTestButton = this.commonForm.soundSpeakersTestButton;
         this.bassBoostCheckbox = this.commonForm.bassBoostCheckbox;
         this.nightModeCheckbox = this.commonForm.nightModeCheckbox;
         this.voiceConnectFieldSet = this.vivoxForm.voiceConnectFieldSet;
         this.microphoneFieldSet = this.vivoxForm.microphoneFieldSet;
         this.enableVoIPCheckbox = this.vivoxForm.enableVoIPCheckbox;
         this.PTTLabel = this.vivoxForm.PTTLabel;
         this.PTTKeyInput = this.vivoxForm.PTTKeyInput;
         this.captureDeviceLabel = this.vivoxForm.captureDeviceLabel;
         this.captureDeviceDropDown = this.vivoxForm.captureDeviceDropDown;
         this.btnCaptureDevicesUpdate = this.vivoxForm.btnCaptureDevicesUpdate;
         this.btnVivoxTest = this.vivoxForm.btnVivoxTest;
         this.voiceAnimationText = this.vivoxForm.voiceAnimationText;
         this.masterVivoxVolumeLabel = this.vivoxForm.masterVivoxVolumeLabel;
         this.masterVivoxVolumeSlider = this.vivoxForm.masterVivoxVolumeSlider;
         this.masterVivoxVolumeValue = this.vivoxForm.masterVivoxVolumeValue;
         this.micVivoxVolumeLabel = this.vivoxForm.micVivoxVolumeLabel;
         this.micVivoxVolumeSlider = this.vivoxForm.micVivoxVolumeSlider;
         this.micVivoxVolumeValue = this.vivoxForm.micVivoxVolumeValue;
         this.masterFadeVivoxVolumeLabel = this.vivoxForm.masterFadeVivoxVolumeLabel;
         this.masterFadeVivoxVolumeSlider = this.vivoxForm.masterFadeVivoxVolumeSlider;
         this.masterFadeVivoxVolumeValue = this.vivoxForm.masterFadeVivoxVolumeValue;
         this.specialVolumeFieldSet = this.specialForm.specialVolumeFieldSet;
         this.specialGuiVolumeLabel = this.specialForm.specialGuiVolumeLabel;
         this.specialGuiVolumeSlider = this.specialForm.specialGuiVolumeSlider;
         this.specialGuiVolumeValue = this.specialForm.specialGuiVolumeValue;
         this.specialVoiceNotificationVolumeLabel = this.specialForm.specialVoiceNotificationVolumeLabel;
         this.specialVoiceNotificationVolumeSlider = this.specialForm.specialVoiceNotificationVolumeSlider;
         this.specialVoiceNotificationVolumeValue = this.specialForm.specialVoiceNotificationVolumeValue;
         this.specialVehiclesVolumeLabel = this.specialForm.specialVehiclesVolumeLabel;
         this.specialVehiclesVolumeSlider = this.specialForm.specialVehiclesVolumeSlider;
         this.specialVehiclesVolumeValue = this.specialForm.specialVehiclesVolumeValue;
         this.specialEffectsVolumeLabel = this.specialForm.specialEffectsVolumeLabel;
         this.specialEffectsVolumeSlider = this.specialForm.specialEffectsVolumeSlider;
         this.specialEffectsVolumeValue = this.specialForm.specialEffectsVolumeValue;
         this.specialAmbientVolumeLabel = this.specialForm.specialAmbientVolumeLabel;
         this.specialAmbientVolumeSlider = this.specialForm.specialAmbientVolumeSlider;
         this.specialAmbientVolumeValue = this.specialForm.specialAmbientVolumeValue;
         this.specialMusicVolumeLabel = this.specialForm.specialMusicVolumeLabel;
         this.specialMusicVolumeSlider = this.specialForm.specialMusicVolumeSlider;
         this.specialMusicVolumeValue = this.specialForm.specialMusicVolumeValue;
         this.voiceAnimation = this.vivoxForm.voiceAnimation;
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.masterVolumeToggleCheckbox.label = SETTINGS.SOUNDS_MASTERVOLUMETOGGLE;
         this.masterVolumeLabel.text = SETTINGS.SOUNDS_MASTERVOLUME;
         this.masterVolumeValue.textAlign = TextFormatAlign.RIGHT;
         registerToolTip(this.bulbVoicesDropDown,SettingsConfigHelper.BULB_VOICES);
         registerToolTip(this.bulbVoicesLabel,SettingsConfigHelper.BULB_VOICES);
         registerToolTip(this.masterVolumeToggleCheckbox,SettingsConfigHelper.MASTER_VOLUME_TOGGLE);
         registerToolTip(this.nightModeCheckbox,SettingsConfigHelper.NIGHT_MODE);
         registerToolTip(this.bassBoostCheckbox,SettingsConfigHelper.BASS_BOOST);
         registerToolTip(this.soundQualityCheckbox,SettingsConfigHelper.SOUND_QUALITY);
         registerToolTip(this.artyBulbVoicesLabel,SettingsConfigHelper.ARTY_BULB_VOICES);
         registerToolTip(this.artyBulbVoicesDropDown,SettingsConfigHelper.ARTY_BULB_VOICES);
      }
      
      override protected function getTooltipID(param1:String) : String
      {
         return TOOLTIP_PREFIX + param1;
      }
      
      override protected function onDispose() : void
      {
         this.volumeFieldSet = null;
         this.soundQualityCheckbox = null;
         this.subtitlesCheckbox = null;
         this.microphoneFieldSet = null;
         this.musicVolumeLabel = null;
         this.musicVolumeSlider = null;
         this.musicVolumeValue = null;
         this.musicHangarLabel = null;
         this.musicHangarSlider = null;
         this.musicHangarValue = null;
         this.vehiclesVolumeLabel = null;
         this.vehiclesVolumeSlider = null;
         this.vehiclesVolumeValue = null;
         this.effectsVolumeLabel = null;
         this.effectsVolumeSlider = null;
         this.effectsVolumeValue = null;
         this.guiVolumeLabel = null;
         this.guiVolumeSlider = null;
         this.guiVolumeValue = null;
         this.voiceNotificationVolumeLabel = null;
         this.voiceNotificationVolumeSlider = null;
         this.voiceNotificationVolumeValue = null;
         this.ambientVolumeLabel = null;
         this.ambientVolumeSlider = null;
         this.ambientVolumeValue = null;
         this.testAlternativeVoicesButton = null;
         this.soundOtherFieldSet = null;
         this.bulbVoicesLabel = null;
         this.alternativeVoicesLabel = null;
         this.bulbVoicesButton = null;
         this.bulbVoicesDropDown = null;
         this.alternativeVoicesDropDown = null;
         this.artyBulbVoicesIcon = null;
         this.artyBulbVoicesLabel = null;
         this.artyBulbVoicesDropDown = null;
         this.artyBulbVoicesButton = null;
         this.presetsFieldSet = null;
         this.soundDeviceButtonBar = null;
         this.soundSpeakersDropDown = null;
         this.soundDeviceAlert = null;
         this.soundSpeakersTestButton = null;
         this.bassBoostCheckbox = null;
         this.nightModeCheckbox = null;
         this.voiceConnectFieldSet = null;
         this.enableVoIPCheckbox = null;
         this.PTTLabel = null;
         this.PTTKeyInput = null;
         this.captureDeviceLabel = null;
         this.captureDeviceDropDown = null;
         this.btnCaptureDevicesUpdate = null;
         this.btnVivoxTest = null;
         this.voiceAnimationText = null;
         this.masterVivoxVolumeLabel = null;
         this.masterVivoxVolumeSlider = null;
         this.masterVivoxVolumeValue = null;
         this.micVivoxVolumeLabel = null;
         this.micVivoxVolumeSlider = null;
         this.micVivoxVolumeValue = null;
         this.masterFadeVivoxVolumeLabel = null;
         this.masterFadeVivoxVolumeSlider = null;
         this.masterFadeVivoxVolumeValue = null;
         this.specialVolumeFieldSet = null;
         this.specialGuiVolumeLabel = null;
         this.specialGuiVolumeSlider = null;
         this.specialGuiVolumeValue = null;
         this.specialVoiceNotificationVolumeLabel = null;
         this.specialVoiceNotificationVolumeSlider = null;
         this.specialVoiceNotificationVolumeValue = null;
         this.specialVehiclesVolumeLabel = null;
         this.specialVehiclesVolumeSlider = null;
         this.specialVehiclesVolumeValue = null;
         this.specialEffectsVolumeLabel = null;
         this.specialEffectsVolumeSlider = null;
         this.specialEffectsVolumeValue = null;
         this.specialAmbientVolumeLabel = null;
         this.specialAmbientVolumeSlider = null;
         this.specialAmbientVolumeValue = null;
         this.specialMusicVolumeLabel = null;
         this.specialMusicVolumeSlider = null;
         this.specialMusicVolumeValue = null;
         this.voiceAnimation = null;
         this.masterVolumeToggleCheckbox.dispose();
         this.masterVolumeToggleCheckbox = null;
         this.masterVolumeLabel.dispose();
         this.masterVolumeLabel = null;
         this.masterVolumeSlider.dispose();
         this.masterVolumeSlider = null;
         this.masterVolumeValue.dispose();
         this.masterVolumeValue = null;
         this.tabs.dispose();
         this.tabs = null;
         this.commonForm.dispose();
         this.commonForm = null;
         this.vivoxForm.dispose();
         this.vivoxForm = null;
         this.specialForm.dispose();
         this.specialForm = null;
         super.onDispose();
      }
   }
}
