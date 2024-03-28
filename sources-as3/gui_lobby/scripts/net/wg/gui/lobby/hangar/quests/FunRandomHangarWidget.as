package net.wg.gui.lobby.hangar.quests
{
   public class FunRandomHangarWidget extends HangarWidgetInject
   {
      
      private static const OUTER_MARGIN_X_LEFT:int = -224;
      
      private static const OUTER_MARGIN_X_RIGHT:int = -228;
      
      private static const WIDTH:int = 602;
      
      private static const HEIGHT:int = 148;
       
      
      public function FunRandomHangarWidget()
      {
         super();
         setManageSize(true);
         setSize(WIDTH,HEIGHT);
      }
      
      override public function get marginRight() : int
      {
         return OUTER_MARGIN_X_RIGHT;
      }
      
      override public function get marginLeft() : int
      {
         return OUTER_MARGIN_X_LEFT;
      }
   }
}
