package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   
   public class SpawnBasePointEntry extends BasePointEntry
   {
       
      
      public function SpawnBasePointEntry()
      {
         super();
      }
      
      override protected function get pointTeam() : String
      {
         return !!basePointData.isPlayerTeam ? TeamBaseMinimapEntryConst.ALLY_TEAM_SPAWN_ATLAS_ITEM_NAME : TeamBaseMinimapEntryConst.ENEMY_TEAM_SPAWN_ATLAS_ITEM_NAME;
      }
   }
}
