package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class DamageIndicatorDataVo extends SettingsDataVo
   {
       
      
      public var damageIndicatorType:SettingsControlProp = null;
      
      public var damageIndicatorPresets:SettingsControlProp = null;
      
      public var damageIndicatorDamageValue:SettingsControlProp = null;
      
      public var damageIndicatorDynamicIndicator:SettingsControlProp = null;
      
      public var damageIndicatorVehicleInfo:SettingsControlProp = null;
      
      public var damageIndicatorAnimation:SettingsControlProp = null;
      
      public var damageIndicatorCrits:SettingsControlProp = null;
      
      public var damageIndicatorAllies:SettingsControlProp = null;
      
      public function DamageIndicatorDataVo()
      {
         super({
            "damageIndicatorType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "damageIndicatorPresets":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "damageIndicatorDamageValue":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageIndicatorDynamicIndicator":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageIndicatorVehicleInfo":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageIndicatorAnimation":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageIndicatorCrits":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageIndicatorAllies":createControl(ControlsFactory.TYPE_CHECKBOX).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.damageIndicatorAnimation = null;
         this.damageIndicatorDamageValue = null;
         this.damageIndicatorDynamicIndicator = null;
         this.damageIndicatorPresets = null;
         this.damageIndicatorType = null;
         this.damageIndicatorVehicleInfo = null;
         this.damageIndicatorCrits = null;
         this.damageIndicatorAllies = null;
         super.onDispose();
      }
   }
}
