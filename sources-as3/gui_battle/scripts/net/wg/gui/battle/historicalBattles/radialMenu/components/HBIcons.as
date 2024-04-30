package net.wg.gui.battle.historicalBattles.radialMenu.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.HB_RADIAL_MENU_CONST;
   import net.wg.gui.battle.views.radialMenu.components.Icons;
   
   public class HBIcons extends Icons
   {
       
      
      public var attackBossIcon:MovieClip = null;
      
      public function HBIcons()
      {
         super();
         addIcon(HB_RADIAL_MENU_CONST.ATTACK_BOSS,this.attackBossIcon);
      }
      
      override protected function hideAll() : void
      {
         this.attackBossIcon.visible = false;
         super.hideAll();
      }
      
      override protected function onDispose() : void
      {
         this.attackBossIcon = null;
         super.onDispose();
      }
   }
}
