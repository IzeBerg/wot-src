package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class EpicBattlesLevelUpSkillButton extends SoundButtonEx
   {
       
      
      public var upgradeIcon:MovieClip = null;
      
      public function EpicBattlesLevelUpSkillButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.upgradeIcon = null;
         super.onDispose();
      }
   }
}
