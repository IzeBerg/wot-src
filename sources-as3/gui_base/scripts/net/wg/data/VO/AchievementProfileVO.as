package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AchievementProfileVO extends AchievementProgressVO
   {
       
      
      public var isDossierForCurrentUser:Boolean = false;
      
      public var isDone:Boolean = false;
      
      public var userName:String = "";
      
      public var description:String = "";
      
      public function AchievementProfileVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:AchievementProfileVO = param1 as AchievementProfileVO;
         if(!_loc2_)
         {
            return false;
         }
         return super.isEquals(param1) && this.rareIconId == _loc2_.rareIconId && this.isRare == _loc2_.isRare && this.isDossierForCurrentUser == _loc2_.isDossierForCurrentUser;
      }
   }
}
