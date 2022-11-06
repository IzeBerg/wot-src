package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AchievementProgressVO extends AchievementCounterVO
   {
      
      private static const FIELD_PROGRESS:String = "progress";
       
      
      public var progress:Array;
      
      private var _progressInfo:ProgressSimpleInfo;
      
      public function AchievementProgressVO(param1:Object)
      {
         super(param1);
      }
      
      public function get progressInfo() : ProgressSimpleInfo
      {
         return this._progressInfo;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_PROGRESS && param2)
         {
            this.progress = param2 as Array;
            this._progressInfo = new ProgressSimpleInfo(this.progress[0],this.progress[1],this.progress[2]);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:AchievementProgressVO = param1 as AchievementProgressVO;
         if(!_loc2_)
         {
            return false;
         }
         if(this._progressInfo && _loc2_.progressInfo)
         {
            _loc3_ = this._progressInfo.isEquals(_loc2_.progressInfo);
         }
         else
         {
            _loc3_ = this._progressInfo == _loc2_.progressInfo;
         }
         return super.isEquals(param1) && isHomogenArraysEquals(this.progress,_loc2_.progress) && _loc3_;
      }
   }
}
