package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class QuestsProgressDataVo extends SettingsDataVo
   {
       
      
      public var progressViewType:SettingsControlProp = null;
      
      public var progressViewConditions:SettingsControlProp = null;
      
      public var showHPBar:SettingsControlProp = null;
      
      public var showHPValues:SettingsControlProp = null;
      
      public var showHPDifference:SettingsControlProp = null;
      
      public var enableTierGrouping:SettingsControlProp = null;
      
      public var allowQuestProgress:SettingsControlProp = null;
      
      public function QuestsProgressDataVo()
      {
         super({
            "progressViewType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "progressViewConditions":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "showHPBar":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showHPValues":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showHPDifference":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableTierGrouping":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "allowQuestProgress":createControl(ControlsFactory.TYPE_VALUE).readOnly(true).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.progressViewType.dispose();
         this.progressViewType = null;
         this.progressViewConditions.dispose();
         this.progressViewConditions = null;
         this.showHPBar.dispose();
         this.showHPBar = null;
         this.showHPValues.dispose();
         this.showHPValues = null;
         this.showHPDifference.dispose();
         this.showHPDifference = null;
         this.enableTierGrouping.dispose();
         this.enableTierGrouping = null;
         this.allowQuestProgress.dispose();
         this.allowQuestProgress = null;
         super.onDispose();
      }
   }
}
