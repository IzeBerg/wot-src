package net.wg.gui.lobby.sessionStats.helpers
{
   public class SessionStatsHelper
   {
      
      public static const TOTAL_WIDTH:int = 364;
      
      private static const COLLAPSED_HEIGHT:int = 491;
      
      private static const EXTENDED_HEIGHT:int = 735;
      
      private static const MIN_EXTENDED_HEIGHT:int = 580;
      
      private static const MIN_RESOLUTION:int = 900;
       
      
      public function SessionStatsHelper()
      {
         super();
      }
      
      public static function getExpandedHeight(param1:Boolean) : Number
      {
         return !!param1 ? (App.appHeight < MIN_RESOLUTION ? Number(MIN_EXTENDED_HEIGHT) : Number(EXTENDED_HEIGHT)) : Number(COLLAPSED_HEIGHT);
      }
   }
}
