package net.wg.gui.lobby.battleRoyale
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class BottomPanelComponent extends GFInjectComponent
   {
      
      private static const BOTTOM_PANEL_WIDTH:int = 825;
      
      private static const BOTTOM_PANEL_HEIGHT:int = 192;
       
      
      public function BottomPanelComponent()
      {
         super();
         setManageSize(true);
         width = BOTTOM_PANEL_WIDTH;
         height = BOTTOM_PANEL_HEIGHT;
      }
   }
}
