package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCampMinimapEntry extends EventIndexedMinimapEntry
   {
       
      
      public function EventCampMinimapEntry()
      {
         super();
      }
      
      public function setIsAlly(param1:Boolean) : void
      {
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,!!param1 ? BATTLEATLAS.WT_CAMP_ALLY : BATTLEATLAS.WT_CAMP_ENEMY,placeholder.graphics,"",true);
      }
   }
}
