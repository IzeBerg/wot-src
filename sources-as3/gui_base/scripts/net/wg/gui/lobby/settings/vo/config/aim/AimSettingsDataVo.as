package net.wg.gui.lobby.settings.vo.config.aim
{
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class AimSettingsDataVo extends SettingsDataVo
   {
       
      
      public var arcade:AimSettingsArcadeDataVo = null;
      
      public var sniper:AimSettingsSniperDataVo = null;
      
      public var spg:AimSettingsArtyDataVo = null;
      
      public var contour:AimSettingsContourDataVo = null;
      
      public function AimSettingsDataVo()
      {
         super({
            "arcade":new AimSettingsArcadeDataVo(),
            "sniper":new AimSettingsSniperDataVo(),
            "spg":new AimSettingsArtyDataVo(),
            "contour":new AimSettingsContourDataVo()
         });
      }
      
      override protected function onDispose() : void
      {
         this.arcade = null;
         this.sniper = null;
         this.spg = null;
         this.contour = null;
         super.onDispose();
      }
   }
}
