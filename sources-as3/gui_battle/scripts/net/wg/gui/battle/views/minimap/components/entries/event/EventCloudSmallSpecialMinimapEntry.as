package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCloudSmallSpecialMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventCloudSmallSpecialMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_CLOUD_SMALL_SPECIALL;
      }
      
      override protected function isScalable() : Boolean
      {
         return false;
      }
   }
}
