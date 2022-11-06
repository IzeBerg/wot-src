package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AchievementCounterVO extends AchievementItemVO
   {
       
      
      public var counterType:String = "";
      
      public function AchievementCounterVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:AchievementCounterVO = param1 as AchievementCounterVO;
         if(!_loc2_)
         {
            return false;
         }
         return super.isEquals(param1) && this.counterType == _loc2_.counterType;
      }
   }
}
