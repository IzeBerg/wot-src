package net.wg.gui.lobby.header
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class NYWidgetUI extends GFInjectComponent
   {
      
      private static const WIDTH:int = 800;
      
      private static const HEIGHT:int = 400;
       
      
      public function NYWidgetUI()
      {
         super();
         width = WIDTH;
         height = HEIGHT;
      }
   }
}
