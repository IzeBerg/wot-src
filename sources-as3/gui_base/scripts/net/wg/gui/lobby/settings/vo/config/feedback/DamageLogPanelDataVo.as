package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class DamageLogPanelDataVo extends SettingsDataVo
   {
       
      
      public var damageLogTotalDamage:SettingsControlProp = null;
      
      public var damageLogBlockedDamage:SettingsControlProp = null;
      
      public var damageLogAssistDamage:SettingsControlProp = null;
      
      public var damageLogAssistStun:SettingsControlProp = null;
      
      public var damageLogShowDetails:SettingsControlProp = null;
      
      public var damageLogEventsPosition:SettingsControlProp = null;
      
      public var damageLogShowEventTypes:SettingsControlProp = null;
      
      public function DamageLogPanelDataVo()
      {
         super({
            "damageLogTotalDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageLogBlockedDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageLogAssistDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageLogAssistStun":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "damageLogShowDetails":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "damageLogEventsPosition":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "damageLogShowEventTypes":createControl(ControlsFactory.TYPE_BUTTON_BAR).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.damageLogBlockedDamage = null;
         this.damageLogAssistDamage = null;
         this.damageLogTotalDamage = null;
         this.damageLogAssistStun = null;
         this.damageLogShowDetails = null;
         this.damageLogEventsPosition = null;
         this.damageLogShowEventTypes = null;
         super.onDispose();
      }
   }
}
