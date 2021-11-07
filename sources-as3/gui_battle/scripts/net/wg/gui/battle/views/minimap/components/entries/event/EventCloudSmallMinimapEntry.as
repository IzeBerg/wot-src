package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCloudSmallMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventCloudSmallMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_CLOUD_SMALL;
      }
      
      override protected function isScalable() : Boolean
      {
         return false;
      }
   }
}
