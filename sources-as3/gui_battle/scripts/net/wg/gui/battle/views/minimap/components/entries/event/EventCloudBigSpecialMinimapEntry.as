package net.wg.gui.battle.views.minimap.components.entries.event
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventCloudBigSpecialMinimapEntry extends EventMinimapEntry
   {
       
      
      public function EventCloudBigSpecialMinimapEntry()
      {
         super();
      }
      
      override protected function getImageName() : String
      {
         return BATTLEATLAS.MAP_CLOUD_BIG_SPECIAL;
      }
      
      override protected function isScalable() : Boolean
      {
         return false;
      }
   }
}
