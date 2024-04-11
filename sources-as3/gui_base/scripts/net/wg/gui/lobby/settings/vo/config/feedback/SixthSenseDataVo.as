package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class SixthSenseDataVo extends SettingsDataVo
   {
       
      
      public var indicatorAlpha:SettingsControlProp = null;
      
      public var indicatorSize:SettingsControlProp = null;
      
      public function SixthSenseDataVo(param1:Object = null)
      {
         super({
            "indicatorSize":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "indicatorAlpha":createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.indicatorAlpha.dispose();
         this.indicatorAlpha = null;
         this.indicatorSize.dispose();
         this.indicatorSize = null;
         super.onDispose();
      }
   }
}
