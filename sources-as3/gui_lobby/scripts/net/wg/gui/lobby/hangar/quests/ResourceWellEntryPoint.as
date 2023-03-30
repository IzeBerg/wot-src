package net.wg.gui.lobby.hangar.quests
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class ResourceWellEntryPoint extends GFInjectComponent implements IHeaderSecondaryEntryPoint
   {
      
      private static const WIDTH:int = 66;
      
      private static const HEIGHT:int = 113;
      
      private static const MARGIN:int = 1;
       
      
      public function ResourceWellEntryPoint()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(WIDTH + 2 * MARGIN,HEIGHT + 2 * MARGIN);
      }
   }
}
