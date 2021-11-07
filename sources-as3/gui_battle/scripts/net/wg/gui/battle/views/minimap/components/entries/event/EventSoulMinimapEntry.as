package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventSoulMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventSoulMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_ICON_SOUL;
      }
   }
}
