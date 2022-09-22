package net.wg.gui.prebattle.battleSession
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class FlagsList extends SimpleTileList
   {
      
      private static const FLAG_WIDTH:int = 26;
      
      private static const FLAG_HEIGHT:int = 16;
      
      private static const GAP:int = 7;
       
      
      public function FlagsList()
      {
         super();
         itemRenderer = App.utils.classFactory.getClass(Linkages.FLAG_RENDERER);
         directionMode = DirectionMode.HORIZONTAL;
         tileWidth = FLAG_WIDTH + GAP;
         tileHeight = FLAG_HEIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            x = -(tileWidth * length) >> 1;
         }
      }
   }
}
