package net.wg.gui.lobby.rankedBattles19.components
{
   import net.wg.utils.StageSizeBoundaries;
   
   public final class RankedBattlesPageHeaderHelper
   {
      
      private static var _instance:RankedBattlesPageHeaderHelper = null;
      
      public static const SIZE_HUGE:String = "huge";
      
      public static const SIZE_BIG:String = "big";
      
      public static const SIZE_MEDIUM:String = "medium";
      
      public static const SIZE_SMALL:String = "small";
      
      private static const Y_OFFSET:Object = {};
      
      private static const CLOSE_BTN_Y_OFFSET:Object = {};
      
      {
         Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 52;
         Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_BIG] = 44;
         Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 31;
         Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 32;
         CLOSE_BTN_Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 11;
         CLOSE_BTN_Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_BIG] = 6;
         CLOSE_BTN_Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 6;
         CLOSE_BTN_Y_OFFSET[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 3;
      }
      
      public function RankedBattlesPageHeaderHelper()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : RankedBattlesPageHeaderHelper
      {
         if(_instance == null)
         {
            _instance = new RankedBattlesPageHeaderHelper();
         }
         return _instance;
      }
      
      public function getCloseBtnYOffset(param1:String) : int
      {
         return CLOSE_BTN_Y_OFFSET[param1];
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
         else if(param1 >= StageSizeBoundaries.WIDTH_1366 && param2 >= StageSizeBoundaries.HEIGHT_768)
         {
            _loc3_ = SIZE_MEDIUM;
         }
         return _loc3_;
      }
      
      public function getYOffset(param1:String) : int
      {
         return Y_OFFSET[param1];
      }
   }
}
