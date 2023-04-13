package net.wg.gui.lobby.settings.vo.config.marker
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class MarkerEnemySettingsDataVo extends SettingsDataVo
   {
       
      
      public var markerBaseIcon:SettingsControlProp = null;
      
      public var markerBaseDamage:SettingsControlProp = null;
      
      public var markerAltIcon:SettingsControlProp = null;
      
      public var markerAltDamage:SettingsControlProp = null;
      
      public var markerBaseVehicleName:SettingsControlProp = null;
      
      public var markerAltPlayerName:SettingsControlProp = null;
      
      public var markerBaseHpIndicator:SettingsControlProp = null;
      
      public var markerBaseHp:SettingsControlProp = null;
      
      public var markerBasePlayerName:SettingsControlProp = null;
      
      public var markerAltLevel:SettingsControlProp = null;
      
      public var markerAltHpIndicator:SettingsControlProp = null;
      
      public var markerAltHp:SettingsControlProp = null;
      
      public var markerBaseLevel:SettingsControlProp = null;
      
      public var markerAltVehicleName:SettingsControlProp = null;
      
      public var markerBaseAimMarker2D:SettingsControlProp = null;
      
      public var markerAltAimMarker2D:SettingsControlProp = null;
      
      public var markerBaseVehicleDist:SettingsControlProp = null;
      
      public var markerAltVehicleDist:SettingsControlProp = null;
      
      public function MarkerEnemySettingsDataVo()
      {
         super({
            "markerBaseIcon":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltIcon":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseVehicleName":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltPlayerName":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseHpIndicator":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseHp":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "markerBasePlayerName":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltLevel":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltHpIndicator":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltHp":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "markerBaseLevel":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltVehicleName":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseAimMarker2D":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltAimMarker2D":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerBaseVehicleDist":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "markerAltVehicleDist":createControl(ControlsFactory.TYPE_CHECKBOX).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.markerBaseIcon = null;
         this.markerBaseDamage = null;
         this.markerAltIcon = null;
         this.markerAltDamage = null;
         this.markerBaseVehicleName = null;
         this.markerAltPlayerName = null;
         this.markerBaseHpIndicator = null;
         this.markerBaseHp = null;
         this.markerBasePlayerName = null;
         this.markerAltLevel = null;
         this.markerAltHpIndicator = null;
         this.markerAltHp = null;
         this.markerBaseLevel = null;
         this.markerAltVehicleName = null;
         this.markerBaseAimMarker2D = null;
         this.markerAltAimMarker2D = null;
         this.markerBaseVehicleDist = null;
         this.markerAltVehicleDist = null;
         super.onDispose();
      }
   }
}
