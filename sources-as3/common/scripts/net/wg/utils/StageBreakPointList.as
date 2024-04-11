package net.wg.utils
{
   public class StageBreakPointList
   {
      
      public static const EXTRA_SMALL:StageBreakPoint = new StageBreakPoint("Extra Small",1024,768);
      
      public static const SMALL:StageBreakPoint = new StageBreakPoint("Small",1366,768);
      
      public static const MEDIUM:StageBreakPoint = new StageBreakPoint("Medium",1600,900);
      
      public static const LARGE:StageBreakPoint = new StageBreakPoint("Large",1920,1080);
      
      public static const EXTRA_LARGE:StageBreakPoint = new StageBreakPoint("Extra Large",2200,1200);
      
      private static const _list:Vector.<StageBreakPoint> = new <StageBreakPoint>[StageBreakPointList.EXTRA_SMALL,StageBreakPointList.SMALL,StageBreakPointList.MEDIUM,StageBreakPointList.LARGE,StageBreakPointList.EXTRA_LARGE];
       
      
      public function StageBreakPointList()
      {
         super();
      }
      
      public static function deduceBreakPoint(param1:Number, param2:Number) : StageBreakPoint
      {
         var _loc4_:StageBreakPoint = null;
         var _loc3_:StageBreakPoint = EXTRA_SMALL;
         for each(_loc4_ in _list)
         {
            if(!(_loc4_.width <= param1 && _loc4_.height <= param2))
            {
               break;
            }
            _loc3_ = _loc4_;
         }
         return _loc3_;
      }
   }
}
