package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.settings.components.SoundDeviceButtonBar;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SoundCommonForm extends UIComponentEx
   {
      
      private static const STATUS_BTN_OFFSET_LEFT:int = 4;
      
      private static const STATUS_BTN_OFFSET_TOP:int = 2;
       
      
      public var volumeFieldSet:FieldSet = null;
      
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
      
      public var bulbIcon:UILoaderAlt = null;
      
      public var bulbVoicesLabel:LabelControl = null;
      
      public var bulbVoicesButton:IconTextButton = null;
      
      public var bulbVoicesDropDown:DropdownMenu = null;
      
      public var alternativeVoicesIcon:UILoaderAlt = null;
      
      public var alternativeVoicesLabel:LabelControl = null;
      
      public var testAlternativeVoicesButton:IconTextButton = null;
      
      public var alternativeVoicesDropDown:DropdownMenu = null;
      
      public var artyBulbVoicesIcon:UILoaderAlt = null;
      
      public var artyBulbVoicesLabel:LabelControl = null;
      
      public var artyBulbVoicesDropDown:DropdownMenu = null;
      
      public var artyBulbVoicesButton:IconTextButton = null;
      
      public var presetsFieldSet:FieldSet = null;
      
      public var soundDeviceButtonBar:SoundDeviceButtonBar = null;
      
      public var soundSpeakersDropDown:DropdownMenu = null;
      
      public var soundDeviceAlert:InfoIcon = null;
      
      public var soundSpeakersTestButton:IconTextButton = null;
      
      public var bassBoostCheckbox:CheckBox = null;
      
      public var nightModeCheckbox:CheckBox = null;
      
      public var soundQualityCheckbox:CheckBox = null;
      
      public var subtitlesCheckbox:CheckBox = null;
      
      public function SoundCommonForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.volumeFieldSet.label = SETTINGS.SOUND_FIELDSET_HEADER;
         this.musicVolumeLabel.text = SETTINGS.SOUNDS_ARENA;
         this.musicHangarLabel.text = SETTINGS.SOUNDS_HANGAR;
         this.vehiclesVolumeLabel.text = SETTINGS.SOUNDS_VEHICLES;
         this.effectsVolumeLabel.text = SETTINGS.SOUNDS_EFFECTS;
         this.guiVolumeLabel.text = SETTINGS.SOUNDS_GUI;
         this.ambientVolumeLabel.text = SETTINGS.SOUNDS_AMBIENT;
         this.voiceNotificationVolumeLabel.text = SETTINGS.SOUNDS_VOICENOTIFICATION;
         this.soundOtherFieldSet.label = SETTINGS.OTHERSETTINGS_FIELDSET_HEADER;
         this.bulbVoicesLabel.text = SETTINGS.OTHERSETTINGS_LABELS_BULB;
         this.bulbIcon.source = RES_ICONS.MAPS_ICONS_SETTINGS_COMMANDER_SIXTHSENSE;
         this.alternativeVoicesLabel.text = SETTINGS.ALTERNATIVEVOICES_LABELS;
         this.alternativeVoicesIcon.source = RES_ICONS.MAPS_ICONS_SETTINGS_CREW;
         this.presetsFieldSet.label = SETTINGS.SOUND_PRESETS_TITLE;
         this.bassBoostCheckbox.label = SETTINGS.SOUNDS_BASSBOOST;
         this.nightModeCheckbox.label = SETTINGS.SOUNDS_NIGHTMODE;
         this.soundQualityCheckbox.label = SETTINGS.SOUNDS_SOUNDQUALITY;
         this.subtitlesCheckbox.label = SETTINGS.SOUNDS_SUBTITLES;
         this.subtitlesCheckbox.toolTip = TOOLTIPS.SETTINGS_SOUND_SUBTITLES;
         this.subtitlesCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.soundSpeakersTestButton.caps = false;
         this.soundSpeakersTestButton.label = SETTINGS.SOUNDS_ACOUSTICTYPE_TESTBUTTON;
         this.soundSpeakersTestButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
         this.soundSpeakersTestButton.iconOffsetLeft = STATUS_BTN_OFFSET_LEFT;
         this.soundSpeakersTestButton.iconOffsetTop = STATUS_BTN_OFFSET_TOP;
         this.bulbVoicesButton.caps = false;
         this.bulbVoicesButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
         this.bulbVoicesButton.label = SETTINGS.SOUNDS_ACOUSTICTYPE_TESTBUTTON;
         this.bulbVoicesButton.iconOffsetLeft = STATUS_BTN_OFFSET_LEFT;
         this.bulbVoicesButton.iconOffsetTop = STATUS_BTN_OFFSET_TOP;
         this.testAlternativeVoicesButton.caps = false;
         this.testAlternativeVoicesButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
         this.testAlternativeVoicesButton.label = SETTINGS.SOUNDS_ACOUSTICTYPE_TESTBUTTON;
         this.testAlternativeVoicesButton.iconOffsetLeft = STATUS_BTN_OFFSET_LEFT;
         this.testAlternativeVoicesButton.iconOffsetTop = STATUS_BTN_OFFSET_TOP;
         this.artyBulbVoicesIcon.source = RES_ICONS.MAPS_ICONS_SETTINGS_COMMANDER_ENEMYSHOTPREDICTOR;
         this.artyBulbVoicesLabel.text = SETTINGS.SOUNDS_ARTYBULBVOICES_LABEL;
         this.artyBulbVoicesButton.caps = false;
         this.artyBulbVoicesButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
         this.artyBulbVoicesButton.label = SETTINGS.SOUNDS_ACOUSTICTYPE_TESTBUTTON;
         this.artyBulbVoicesButton.iconOffsetLeft = STATUS_BTN_OFFSET_LEFT;
         this.artyBulbVoicesButton.iconOffsetTop = STATUS_BTN_OFFSET_TOP;
         this.soundDeviceAlert.tooltip = TOOLTIPS.SETTINGS_SOUND_DEVICEALERT;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.volumeFieldSet.dispose();
         this.volumeFieldSet = null;
         this.soundQualityCheckbox.dispose();
         this.soundQualityCheckbox = null;
         this.subtitlesCheckbox.dispose();
         this.subtitlesCheckbox = null;
         this.musicVolumeLabel.dispose();
         this.musicVolumeLabel = null;
         this.musicVolumeSlider.dispose();
         this.musicVolumeSlider = null;
         this.musicVolumeValue.dispose();
         this.musicVolumeValue = null;
         this.musicHangarLabel.dispose();
         this.musicHangarLabel = null;
         this.musicHangarSlider.dispose();
         this.musicHangarSlider = null;
         this.musicHangarValue.dispose();
         this.musicHangarValue = null;
         this.vehiclesVolumeLabel.dispose();
         this.vehiclesVolumeLabel = null;
         this.vehiclesVolumeSlider.dispose();
         this.vehiclesVolumeSlider = null;
         this.vehiclesVolumeValue.dispose();
         this.vehiclesVolumeValue = null;
         this.effectsVolumeLabel.dispose();
         this.effectsVolumeLabel = null;
         this.effectsVolumeSlider.dispose();
         this.effectsVolumeSlider = null;
         this.effectsVolumeValue.dispose();
         this.effectsVolumeValue = null;
         this.guiVolumeLabel.dispose();
         this.guiVolumeLabel = null;
         this.guiVolumeSlider.dispose();
         this.guiVolumeSlider = null;
         this.guiVolumeValue.dispose();
         this.guiVolumeValue = null;
         this.voiceNotificationVolumeSlider.dispose();
         this.voiceNotificationVolumeSlider = null;
         this.voiceNotificationVolumeValue.dispose();
         this.voiceNotificationVolumeValue = null;
         this.voiceNotificationVolumeLabel.dispose();
         this.voiceNotificationVolumeLabel = null;
         this.ambientVolumeLabel.dispose();
         this.ambientVolumeLabel = null;
         this.ambientVolumeSlider.dispose();
         this.ambientVolumeSlider = null;
         this.ambientVolumeValue.dispose();
         this.ambientVolumeValue = null;
         this.testAlternativeVoicesButton.dispose();
         this.testAlternativeVoicesButton = null;
         this.soundOtherFieldSet.dispose();
         this.soundOtherFieldSet = null;
         this.bulbIcon.dispose();
         this.bulbIcon = null;
         this.bulbVoicesLabel.dispose();
         this.bulbVoicesLabel = null;
         this.bulbVoicesButton.dispose();
         this.bulbVoicesButton = null;
         this.bulbVoicesDropDown.dispose();
         this.bulbVoicesDropDown = null;
         this.alternativeVoicesDropDown.dispose();
         this.alternativeVoicesDropDown = null;
         this.alternativeVoicesIcon.dispose();
         this.alternativeVoicesIcon = null;
         this.alternativeVoicesLabel.dispose();
         this.alternativeVoicesLabel = null;
         this.artyBulbVoicesIcon.dispose();
         this.artyBulbVoicesIcon = null;
         this.artyBulbVoicesLabel.dispose();
         this.artyBulbVoicesLabel = null;
         this.artyBulbVoicesDropDown.dispose();
         this.artyBulbVoicesDropDown = null;
         this.artyBulbVoicesButton.dispose();
         this.artyBulbVoicesButton = null;
         this.presetsFieldSet.dispose();
         this.presetsFieldSet = null;
         this.soundDeviceButtonBar.dispose();
         this.soundDeviceButtonBar = null;
         this.soundSpeakersTestButton.dispose();
         this.soundSpeakersTestButton = null;
         this.soundSpeakersDropDown.dispose();
         this.soundSpeakersDropDown = null;
         this.bassBoostCheckbox.dispose();
         this.bassBoostCheckbox = null;
         this.nightModeCheckbox.dispose();
         this.nightModeCheckbox = null;
         this.soundDeviceAlert.dispose();
         this.soundDeviceAlert = null;
         super.onDispose();
      }
   }
}
