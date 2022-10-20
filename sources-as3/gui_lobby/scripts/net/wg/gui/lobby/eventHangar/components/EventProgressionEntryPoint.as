package net.wg.gui.lobby.eventHangar.components
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class EventProgressionEntryPoint extends GFInjectComponent
   {
      
      private static const MARGIN:int = 2;
      
      private static const WIDTH:int = 800 + MARGIN;
      
      private static const WIDTH_S:int = 320 + MARGIN;
      
      private static const HEIGHT:int = 130 + MARGIN;
      
      private static const HEIGHT_S:int = 104 + MARGIN;
       
      
      public function EventProgressionEntryPoint()
      {
         super();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(param1 < StageSizeBoundaries.WIDTH_1366)
         {
            setSize(WIDTH_S,HEIGHT_S);
         }
         else
         {
            setSize(WIDTH,HEIGHT);
         }
      }
   }
}
