package net.wg.gui.lobby.settings.vo.config.aim
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class AimSettingsArcadeDataVo extends SettingsDataVo
   {
       
      
      public var netType:SettingsControlProp = null;
      
      public var net:SettingsControlProp = null;
      
      public var centralTagType:SettingsControlProp = null;
      
      public var centralTag:SettingsControlProp = null;
      
      public var reloader:SettingsControlProp = null;
      
      public var condition:SettingsControlProp = null;
      
      public var mixingType:SettingsControlProp = null;
      
      public var mixing:SettingsControlProp = null;
      
      public var cassette:SettingsControlProp = null;
      
      public var gunTagType:SettingsControlProp = null;
      
      public var gunTag:SettingsControlProp = null;
      
      public var reloaderTimer:SettingsControlProp = null;
      
      public function AimSettingsArcadeDataVo()
      {
         super({
            "netType":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "net":createSliderWithLabelAndValue().build(),
            "centralTagType":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "centralTag":createSliderWithLabelAndValue().build(),
            "reloader":createSliderWithLabelAndValue().build(),
            "condition":createSliderWithLabelAndValue().build(),
            "mixingType":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "mixing":createSliderWithLabelAndValue().build(),
            "cassette":createSliderWithLabelAndValue().build(),
            "gunTagType":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "gunTag":createSliderWithLabelAndValue().build(),
            "reloaderTimer":createSliderWithLabelAndValue().build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.netType = null;
         this.net = null;
         this.centralTagType = null;
         this.centralTag = null;
         this.reloader = null;
         this.condition = null;
         this.mixingType = null;
         this.mixing = null;
         this.cassette = null;
         this.gunTagType = null;
         this.gunTag = null;
         this.reloaderTimer = null;
         super.onDispose();
      }
   }
}
