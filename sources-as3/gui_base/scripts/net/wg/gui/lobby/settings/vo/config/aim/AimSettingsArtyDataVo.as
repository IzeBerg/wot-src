package net.wg.gui.lobby.settings.vo.config.aim
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class AimSettingsArtyDataVo extends SettingsDataVo
   {
       
      
      public var shotsResultIndicator:SettingsControlProp = null;
      
      public var spgScaleWidget:SettingsControlProp = null;
      
      public var scrollSmoothingEnabled:SettingsControlProp = null;
      
      public var autoChangeAimMode:SettingsControlProp = null;
      
      public var spgStrategicCamMode:SettingsControlProp = null;
      
      public var aimEntranceMode:SettingsControlProp = null;
      
      public function AimSettingsArtyDataVo()
      {
         super({
            "shotsResultIndicator":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "spgScaleWidget":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "scrollSmoothingEnabled":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "autoChangeAimMode":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "spgStrategicCamMode":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "aimEntranceMode":createControl(ControlsFactory.TYPE_DROPDOWN).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.shotsResultIndicator = null;
         this.spgScaleWidget = null;
         this.scrollSmoothingEnabled = null;
         this.autoChangeAimMode = null;
         this.spgStrategicCamMode = null;
         this.aimEntranceMode = null;
         super.onDispose();
      }
   }
}
