package net.wg.gui.lobby.hangar.quests
{
   public class EarlyAccessEntryPoint extends HeaderSecondaryWidgetInject
   {
      
      private static const WIDTH:int = 108;
      
      private static const HEIGHT:int = 108;
      
      private static const MARGIN:int = 2;
       
      
      public function EarlyAccessEntryPoint()
      {
         super();
         setManageSize(true);
         setSize(WIDTH + MARGIN,HEIGHT + MARGIN);
      }
      
      override public function get marginLeft() : int
      {
         return -26;
      }
      
      override public function get marginRight() : int
      {
         return -32;
      }
   }
}
