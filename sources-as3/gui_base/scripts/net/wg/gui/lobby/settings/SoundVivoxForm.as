package net.wg.gui.lobby.settings
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.lobby.settings.components.SoundVoiceWaves;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SoundVivoxForm extends UIComponentEx
   {
       
      
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
      
      public var voiceAnimation:SoundVoiceWaves = null;
      
      public function SoundVivoxForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.voiceConnectFieldSet.label = SETTINGS.VOICE_CHAT_FIELDSET_HEADER;
         this.microphoneFieldSet.label = SETTINGS.VOICE_CHAT_MICROPHONE_FIELDSET_HEADER;
         this.enableVoIPCheckbox.label = SETTINGS.VOICE_CHAT_VOICECHATENABLE;
         this.PTTLabel.text = SETTINGS.VOICE_CHAT_PTT;
         this.captureDeviceLabel.text = SETTINGS.VOICE_CHAT_MICROPHONE;
         this.btnCaptureDevicesUpdate.label = SETTINGS.SOUND_VIVOX_BUTTONS_CAPTURE_DEVICES_REFRESH;
         this.btnVivoxTest.label = SETTINGS.SOUND_VIVOX_BUTTONS_TEST_START;
         this.voiceAnimationText.text = "";
         this.masterVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MASTER_VOLUME;
         this.micVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MIC_SENSITIVITY;
         this.masterFadeVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_FADE_VOLUME;
         this.micVivoxVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.masterVivoxVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.masterFadeVivoxVolumeValue.textAlign = TextFormatAlign.RIGHT;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.voiceConnectFieldSet.dispose();
         this.voiceConnectFieldSet = null;
         this.enableVoIPCheckbox.dispose();
         this.enableVoIPCheckbox = null;
         this.microphoneFieldSet.dispose();
         this.microphoneFieldSet = null;
         this.PTTLabel.dispose();
         this.PTTLabel = null;
         this.PTTKeyInput.dispose();
         this.PTTKeyInput = null;
         this.captureDeviceLabel.dispose();
         this.captureDeviceLabel = null;
         this.captureDeviceDropDown.dispose();
         this.captureDeviceDropDown = null;
         this.btnCaptureDevicesUpdate.dispose();
         this.btnCaptureDevicesUpdate = null;
         this.btnVivoxTest.dispose();
         this.btnVivoxTest = null;
         this.voiceAnimationText = null;
         this.masterVivoxVolumeLabel.dispose();
         this.masterVivoxVolumeLabel = null;
         this.masterVivoxVolumeSlider.dispose();
         this.masterVivoxVolumeSlider = null;
         this.masterVivoxVolumeValue.dispose();
         this.masterVivoxVolumeValue = null;
         this.micVivoxVolumeLabel.dispose();
         this.micVivoxVolumeLabel = null;
         this.micVivoxVolumeSlider.dispose();
         this.micVivoxVolumeSlider = null;
         this.micVivoxVolumeValue.dispose();
         this.micVivoxVolumeValue = null;
         this.masterFadeVivoxVolumeLabel.dispose();
         this.masterFadeVivoxVolumeLabel = null;
         this.masterFadeVivoxVolumeSlider.dispose();
         this.masterFadeVivoxVolumeSlider = null;
         this.masterFadeVivoxVolumeValue.dispose();
         this.masterFadeVivoxVolumeValue = null;
         this.voiceAnimation.dispose();
         this.voiceAnimation = null;
         super.onDispose();
      }
   }
}
