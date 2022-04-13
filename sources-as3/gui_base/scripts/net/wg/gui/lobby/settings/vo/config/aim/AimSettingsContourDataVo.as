package net.wg.gui.lobby.settings.vo.config.aim
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class AimSettingsContourDataVo extends SettingsDataVo
   {
       
      
      public var contour:SettingsControlProp = null;
      
      public var contourPenetrableZone:SettingsControlProp = null;
      
      public var contourImpenetrableZone:SettingsControlProp = null;
      
      public function AimSettingsContourDataVo()
      {
         super({
            "contour":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "contourPenetrableZone":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "contourImpenetrableZone":createControl(ControlsFactory.TYPE_DROPDOWN).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.contour = null;
         this.contourPenetrableZone = null;
         this.contourImpenetrableZone = null;
         super.onDispose();
      }
   }
}
