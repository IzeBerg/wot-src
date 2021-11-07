package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class BattleBorderMapDataVo extends SettingsDataVo
   {
       
      
      public var battleBorderMapMode:SettingsControlProp = null;
      
      public var battleBorderMapType:SettingsControlProp = null;
      
      public function BattleBorderMapDataVo()
      {
         super({
            "battleBorderMapMode":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "battleBorderMapType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.battleBorderMapMode = null;
         this.battleBorderMapType = null;
         super.onDispose();
      }
   }
}
