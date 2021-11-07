package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCloudBigMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventCloudBigMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_CLOUD_BIG;
      }
      
      override protected function isScalable() : Boolean
      {
         return false;
      }
   }
}
