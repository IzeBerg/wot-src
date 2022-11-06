package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class ChinaLootBoxesEntryPointWidget extends GFInjectComponent
   {
      
      public static const WIDTH:int = 252;
      
      public static const HEIGHT:int = 252;
       
      
      public function ChinaLootBoxesEntryPointWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setSize(WIDTH,HEIGHT);
      }
   }
}
