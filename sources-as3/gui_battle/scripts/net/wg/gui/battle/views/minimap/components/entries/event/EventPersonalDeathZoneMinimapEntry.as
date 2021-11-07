package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventPersonalDeathZoneMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventPersonalDeathZoneMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.EVENT_DEATH_ZONE;
      }
   }
}
