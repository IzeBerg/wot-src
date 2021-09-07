package net.wg.gui.lobby.settings
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.RangeSlider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ScreenSettingsForm extends UIComponentEx
   {
       
      
      public var monitorLabel:LabelControl = null;
      
      public var monitorDropDown:DropdownMenu = null;
      
      public var screenModeLabel:LabelControl = null;
      
      public var screenModeDropDown:DropdownMenu = null;
      
      public var sizesLabel:LabelControl = null;
      
      public var sizesDropDown:DropdownMenu = null;
      
      public var refreshRateLabel:LabelControl = null;
      
      public var refreshRateDropDown:DropdownMenu = null;
      
      public var vertSyncCheckbox:CheckBox = null;
      
      public var tripleBufferedCheckbox:CheckBox = null;
      
      public var igbHardwareAccelerationCheckbox:CheckBox = null;
      
      public var interfaceScaleLabel:LabelControl = null;
      
      public var interfaceScaleDropDown:DropdownMenu = null;
      
      public var gammaLabel:LabelControl = null;
      
      public var gammaSettingButton:SoundButtonEx = null;
      
      public var isColorBlindCheckbox:CheckBox = null;
      
      public var fovLabel:LabelControl = null;
      
      public var fovRangeSlider:RangeSlider = null;
      
      public var dynamicFovCheckbox:CheckBox = null;
      
      public var colorFilterLabel:LabelControl = null;
      
      public var colorFilterNameLabel:LabelControl = null;
      
      public var colorFilterImage:UILoaderAlt = null;
      
      public var colorFilterButton:SoundButtonEx = null;
      
      public var topShadow:MovieClip;
      
      public var bottomShadow:MovieClip;
      
      public function ScreenSettingsForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.initTexts();
         this.refreshRateDropDown.labelField = null;
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         if(this.bottomShadow)
         {
            this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.monitorLabel.dispose();
         this.screenModeLabel.dispose();
         this.monitorDropDown.dispose();
         this.screenModeDropDown.dispose();
         this.sizesLabel.dispose();
         this.sizesDropDown.dispose();
         this.refreshRateLabel.dispose();
         this.refreshRateDropDown.dispose();
         this.vertSyncCheckbox.dispose();
         this.interfaceScaleLabel.dispose();
         this.interfaceScaleDropDown.dispose();
         this.tripleBufferedCheckbox.dispose();
         this.igbHardwareAccelerationCheckbox.dispose();
         this.gammaLabel.dispose();
         this.gammaSettingButton.dispose();
         this.isColorBlindCheckbox.dispose();
         this.colorFilterLabel.dispose();
         this.colorFilterNameLabel.dispose();
         this.colorFilterImage.dispose();
         this.colorFilterButton.dispose();
         this.fovLabel.dispose();
         this.fovRangeSlider.dispose();
         this.dynamicFovCheckbox.dispose();
         this.monitorLabel = null;
         this.screenModeLabel = null;
         this.monitorDropDown = null;
         this.screenModeDropDown = null;
         this.sizesLabel = null;
         this.sizesDropDown = null;
         this.refreshRateLabel = null;
         this.refreshRateDropDown = null;
         this.vertSyncCheckbox = null;
         this.interfaceScaleLabel = null;
         this.interfaceScaleDropDown = null;
         this.tripleBufferedCheckbox = null;
         this.igbHardwareAccelerationCheckbox = null;
         this.gammaLabel = null;
         this.gammaSettingButton = null;
         this.isColorBlindCheckbox = null;
         this.colorFilterLabel = null;
         this.colorFilterNameLabel = null;
         this.colorFilterImage = null;
         this.colorFilterButton = null;
         this.fovLabel = null;
         this.fovRangeSlider = null;
         this.dynamicFovCheckbox = null;
         this.topShadow = null;
         this.bottomShadow = null;
         super.onDispose();
      }
      
      private function initTexts() : void
      {
         this.monitorLabel.text = SETTINGS.MONITOR;
         this.screenModeLabel.text = SETTINGS.SCREENMODE_LABEL;
         this.vertSyncCheckbox.label = SETTINGS.VERTSYNC;
         this.interfaceScaleLabel.text = SETTINGS.INTERFACESCALE;
         this.interfaceScaleLabel.infoIcoType = InfoIcon.TYPE_INFO;
         this.isColorBlindCheckbox.label = SETTINGS.ISCOLORBLIND;
         this.refreshRateLabel.text = SETTINGS.REFRESHRATE;
         this.fovLabel.text = SETTINGS.FOV;
         this.dynamicFovCheckbox.label = SETTINGS.DYNAMICFOV;
         this.gammaLabel.text = SETTINGS.GAMMA;
         this.colorFilterLabel.text = SETTINGS.COLORCORRECTION;
      }
   }
}
