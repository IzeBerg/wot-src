package net.wg.gui.lobby.rankedBattles19.view.base
{
   public class HangarRankedScreen extends RankedScreen
   {
      
      private static const OFFSET_MESSENGER_BAR:int = 38;
       
      
      public function HangarRankedScreen()
      {
         super();
         changeBgPlacement = false;
      }
      
      override protected function recalculateBgSize(param1:int, param2:int) : void
      {
         bgActualWidth = param1;
         bgActualHeight = param2 + OFFSET_MESSENGER_BAR - int(!!changeBgPlacement ? viewRestrictions.verticalOffset : 0);
         updateBG();
      }
   }
}
