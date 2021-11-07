package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCollectorMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventCollectorMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_COLLECTOR_BASIC;
      }
   }
}
