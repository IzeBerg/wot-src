package net.wg.gui.lobby.hangar.quests
{
   public class ResourceWellEntryPoint extends HeaderSecondaryWidgetInject
   {
      
      private static const WIDTH:int = 66;
      
      private static const HEIGHT:int = 113;
      
      private static const MARGIN:int = 1;
       
      
      public function ResourceWellEntryPoint()
      {
         super();
         setSize(WIDTH + 2 * MARGIN,HEIGHT + 2 * MARGIN);
      }
   }
}
