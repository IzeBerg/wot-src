package net.wg.gui.lobby.hangar.quests
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class BattleMattersEntryPoint extends GFInjectComponent implements IHeaderSecondaryEntryPoint
   {
      
      private static const WIDTH:int = 66;
      
      private static const HEIGHT:int = 113;
      
      private static const MARGIN:int = 2;
       
      
      public function BattleMattersEntryPoint()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(WIDTH + MARGIN,HEIGHT + MARGIN);
      }
   }
}
