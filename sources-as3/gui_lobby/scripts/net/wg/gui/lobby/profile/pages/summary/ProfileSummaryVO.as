package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.VO.AchievementProfileVO;
   import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
   import scaleform.clik.data.DataProvider;
   
   public class ProfileSummaryVO extends ProfileDossierInfoVO
   {
      
      private static const SIGNIFICANT_ACHIEVEMENTS:String = "significantAchievements";
      
      private static const NEAREST_ACHIEVEMENTS:String = "nearestAchievements";
       
      
      public var avgDamage:Number;
      
      public var maxDestroyed:uint;
      
      public var maxDestroyedByVehicle:String = "";
      
      public var globalRating:uint;
      
      public var significantAchievements:DataProvider;
      
      public var nearestAchievements:DataProvider;
      
      public function ProfileSummaryVO(param1:Object)
      {
         super(param1);
      }
      
      private static function getTypedDataProvider(param1:*, param2:Class) : DataProvider
      {
         var _loc3_:DataProvider = new DataProvider();
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = new param2(param1[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SIGNIFICANT_ACHIEVEMENTS)
         {
            this.significantAchievements = getTypedDataProvider(param2,AchievementProfileVO);
            return false;
         }
         if(param1 == NEAREST_ACHIEVEMENTS)
         {
            this.nearestAchievements = getTypedDataProvider(param2,AchievementProfileVO);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AchievementProfileVO = null;
         var _loc2_:AchievementProfileVO = null;
         if(this.significantAchievements != null)
         {
            for each(_loc1_ in this.significantAchievements)
            {
               _loc1_.dispose();
            }
            this.significantAchievements.cleanUp();
            this.significantAchievements = null;
         }
         if(this.nearestAchievements != null)
         {
            for each(_loc2_ in this.nearestAchievements)
            {
               _loc2_.dispose();
            }
            this.nearestAchievements.cleanUp();
            this.nearestAchievements = null;
         }
         super.onDispose();
      }
      
      public function getAvgDamageStr() : String
      {
         return App.utils.locale.integer(this.avgDamage);
      }
      
      public function getGlobalRatingStr() : String
      {
         return App.utils.locale.integer(this.globalRating);
      }
      
      public function getMaxDestroyedStr() : String
      {
         return App.utils.locale.integer(this.maxDestroyed);
      }
   }
}
