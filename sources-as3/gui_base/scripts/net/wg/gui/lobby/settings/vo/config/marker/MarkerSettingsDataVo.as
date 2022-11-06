package net.wg.gui.lobby.settings.vo.config.marker
{
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class MarkerSettingsDataVo extends SettingsDataVo
   {
       
      
      public var enemy:MarkerEnemySettingsDataVo = null;
      
      public var ally:MarkerAllySettingsDataVo = null;
      
      public var dead:MarkerDeadSettingsDataVo = null;
      
      public function MarkerSettingsDataVo()
      {
         super({
            "enemy":new MarkerEnemySettingsDataVo(),
            "ally":new MarkerAllySettingsDataVo(),
            "dead":new MarkerDeadSettingsDataVo()
         });
      }
      
      override protected function onDispose() : void
      {
         this.enemy = null;
         this.ally = null;
         this.dead = null;
         super.onDispose();
      }
   }
}
