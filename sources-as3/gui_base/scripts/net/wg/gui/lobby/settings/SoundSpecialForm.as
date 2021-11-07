package net.wg.gui.lobby.settings
{
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SoundSpecialForm extends UIComponentEx
   {
       
      
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
      
      public function SoundSpecialForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.specialVolumeFieldSet.label = SETTINGS.SOUND_SPECIAL_FIELD_SET;
         this.specialMusicVolumeLabel.text = SETTINGS.SOUNDS_ARENA;
         this.specialVehiclesVolumeLabel.text = SETTINGS.SOUNDS_VEHICLES;
         this.specialEffectsVolumeLabel.text = SETTINGS.SOUNDS_EFFECTS;
         this.specialGuiVolumeLabel.text = SETTINGS.SOUNDS_GUI;
         this.specialAmbientVolumeLabel.text = SETTINGS.SOUNDS_AMBIENT;
         this.specialVoiceNotificationVolumeLabel.text = SETTINGS.SOUNDS_VOICENOTIFICATION;
         this.specialGuiVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.specialVoiceNotificationVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.specialVehiclesVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.specialEffectsVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.specialAmbientVolumeValue.textAlign = TextFormatAlign.RIGHT;
         this.specialMusicVolumeValue.textAlign = TextFormatAlign.RIGHT;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.specialVolumeFieldSet.dispose();
         this.specialVolumeFieldSet = null;
         this.specialMusicVolumeLabel.dispose();
         this.specialMusicVolumeLabel = null;
         this.specialMusicVolumeSlider.dispose();
         this.specialMusicVolumeSlider = null;
         this.specialMusicVolumeValue.dispose();
         this.specialMusicVolumeValue = null;
         this.specialVehiclesVolumeLabel.dispose();
         this.specialVehiclesVolumeLabel = null;
         this.specialVehiclesVolumeSlider.dispose();
         this.specialVehiclesVolumeSlider = null;
         this.specialVehiclesVolumeValue.dispose();
         this.specialVehiclesVolumeValue = null;
         this.specialEffectsVolumeLabel.dispose();
         this.specialEffectsVolumeLabel = null;
         this.specialEffectsVolumeSlider.dispose();
         this.specialEffectsVolumeSlider = null;
         this.specialEffectsVolumeValue.dispose();
         this.specialEffectsVolumeValue = null;
         this.specialGuiVolumeLabel.dispose();
         this.specialGuiVolumeLabel = null;
         this.specialGuiVolumeSlider.dispose();
         this.specialGuiVolumeSlider = null;
         this.specialGuiVolumeValue.dispose();
         this.specialGuiVolumeValue = null;
         this.specialAmbientVolumeLabel.dispose();
         this.specialAmbientVolumeLabel = null;
         this.specialAmbientVolumeSlider.dispose();
         this.specialAmbientVolumeSlider = null;
         this.specialAmbientVolumeValue.dispose();
         this.specialAmbientVolumeValue = null;
         this.specialVoiceNotificationVolumeLabel.dispose();
         this.specialVoiceNotificationVolumeLabel = null;
         this.specialVoiceNotificationVolumeSlider.dispose();
         this.specialVoiceNotificationVolumeSlider = null;
         this.specialVoiceNotificationVolumeValue.dispose();
         this.specialVoiceNotificationVolumeValue = null;
         super.onDispose();
      }
   }
}
