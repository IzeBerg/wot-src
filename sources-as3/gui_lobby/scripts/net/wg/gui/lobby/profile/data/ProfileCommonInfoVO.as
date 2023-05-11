package net.wg.gui.lobby.profile.data
{
   public class ProfileCommonInfoVO extends ProfileBaseInfoVO
   {
       
      
      public var hitsEfficiency:Number = -1;
      
      public var maxXP:int = -1;
      
      public var avgXP:int = -1;
      
      public function ProfileCommonInfoVO(param1:Object)
      {
         super(param1);
      }
      
      public function getHitsEfficiencyStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.hitsEfficiency * 100);
      }
      
      public function getMaxExperienceStr() : String
      {
         return App.utils.locale.integer(this.maxXP);
      }
      
      public function getAvgExperienceStr() : String
      {
         return App.utils.locale.integer(this.avgXP);
      }
   }
}
