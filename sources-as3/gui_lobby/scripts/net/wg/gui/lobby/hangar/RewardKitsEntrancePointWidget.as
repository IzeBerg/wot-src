package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class RewardKitsEntrancePointWidget extends GFInjectComponent
   {
      
      private static const ENTRY_POINT_HIT_AREA_OFFSET_X:int = 120;
      
      private static const ENTRY_POINT_HIT_AREA_OFFSET_Y:int = 125;
      
      private static const ENTRY_POINT_WIDTH:int = 268 + ENTRY_POINT_HIT_AREA_OFFSET_X;
      
      private static const ENTRY_POINT_HEIGHT:int = 250 + ENTRY_POINT_HIT_AREA_OFFSET_Y;
       
      
      public function RewardKitsEntrancePointWidget()
      {
         super();
         width = ENTRY_POINT_WIDTH;
         height = ENTRY_POINT_HEIGHT;
      }
      
      public function get offsetX() : int
      {
         return ENTRY_POINT_HIT_AREA_OFFSET_X;
      }
      
      public function get offsetY() : int
      {
         return ENTRY_POINT_HIT_AREA_OFFSET_Y;
      }
   }
}
