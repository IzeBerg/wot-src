package net.wg.gui.lobby.hangar.quests
{
   public class WinbackWidget extends HangarWidgetInject
   {
      
      private static const WIDTH:int = 150;
      
      private static const HEIGHT:int = 180;
       
      
      public function WinbackWidget()
      {
         super();
         setManageSize(false);
         setSize(WIDTH,HEIGHT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         x = -(WIDTH >> 1);
      }
   }
}
