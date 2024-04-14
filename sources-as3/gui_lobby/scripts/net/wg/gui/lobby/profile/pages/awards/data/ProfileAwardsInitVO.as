package net.wg.gui.lobby.profile.pages.awards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileAwardsInitVO extends DAAPIDataClass
   {
       
      
      public var achievementFilter:Object;
      
      public var achievementFilterVO:AchievementFilterVO;
      
      public function ProfileAwardsInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "achievementFilter")
         {
            this.achievementFilterVO = new AchievementFilterVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
   }
}
