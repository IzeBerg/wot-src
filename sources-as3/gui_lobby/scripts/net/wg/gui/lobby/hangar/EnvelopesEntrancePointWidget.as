package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class EnvelopesEntrancePointWidget extends GFInjectComponent
   {
      
      private static const ENTRY_POINT_WIDTH:int = 250;
      
      private static const ENTRY_POINT_HEIGHT:int = 250;
       
      
      public function EnvelopesEntrancePointWidget()
      {
         super();
         width = ENTRY_POINT_WIDTH;
         height = ENTRY_POINT_HEIGHT;
      }
   }
}
