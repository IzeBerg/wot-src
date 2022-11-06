package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class LandingZoneMinimapEntry extends BattleUIComponent
   {
      
      private static const ALLY_FRAME_NUMBER:int = 2;
      
      private static const ENEMY_FRAME_NUMBER:int = 1;
       
      
      public function LandingZoneMinimapEntry()
      {
         super();
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         gotoAndStop(!!param1 ? ALLY_FRAME_NUMBER : ENEMY_FRAME_NUMBER);
      }
   }
}
