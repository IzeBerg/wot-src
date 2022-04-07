package net.wg.gui.lobby.rankedBattles19.view
{
   import net.wg.utils.StageSizeBoundaries;
   
   public final class RankedBattlesViewHelper
   {
      
      private static var _instance:RankedBattlesViewHelper = null;
      
      public static const SIZE_HUGE:String = "huge";
      
      public static const SIZE_BIG:String = "big";
      
      public static const SIZE_SMALL:String = "small";
      
      private static const DIVISIONS_TOP_BLOCK_Y_OFFSETS:Object = {};
      
      private static const DIVISIONS_CENTER_BLOCK_Y_OFFSETS:Object = {};
      
      private static const LEAGUES_TOP_BLOCK_Y_OFFSETS:Object = {};
      
      private static const LEAGUES_CENTER_BLOCK_Y_OFFSETS:Object = {};
      
      {
         DIVISIONS_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -25;
         DIVISIONS_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -105;
         DIVISIONS_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -30;
         DIVISIONS_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -210;
         DIVISIONS_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -80;
         DIVISIONS_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -140;
         LEAGUES_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -220;
         LEAGUES_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -175;
         LEAGUES_TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -135;
         LEAGUES_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -60;
         LEAGUES_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -60;
         LEAGUES_CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -60;
      }
      
      public function RankedBattlesViewHelper()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : RankedBattlesViewHelper
      {
         if(_instance == null)
         {
            _instance = new RankedBattlesViewHelper();
         }
         return _instance;
      }
      
      public function getDivisionsCenterBlockYOffset(param1:String) : int
      {
         return DIVISIONS_CENTER_BLOCK_Y_OFFSETS[param1];
      }
      
      public function getDivisionsTopBlockYOffset(param1:String) : int
      {
         return DIVISIONS_TOP_BLOCK_Y_OFFSETS[param1];
      }
      
      public function getLeaguesCenterBlockYOffset(param1:String) : int
      {
         return LEAGUES_CENTER_BLOCK_Y_OFFSETS[param1];
      }
      
      public function getLeaguesTopBlockYOffset(param1:String) : int
      {
         return LEAGUES_TOP_BLOCK_Y_OFFSETS[param1];
      }
      
      public function getSizeId(param1:int, param2:int) : String
      {
         var _loc3_:String = SIZE_SMALL;
         if(param1 >= StageSizeBoundaries.WIDTH_1920 && param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc3_ = SIZE_HUGE;
         }
         else if(param1 >= StageSizeBoundaries.WIDTH_1600 && param2 >= StageSizeBoundaries.HEIGHT_900)
         {
            _loc3_ = SIZE_BIG;
         }
         return _loc3_;
      }
   }
}
