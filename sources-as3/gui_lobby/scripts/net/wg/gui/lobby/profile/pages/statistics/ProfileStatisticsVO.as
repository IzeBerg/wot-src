package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
   
   public class ProfileStatisticsVO extends ProfileDossierInfoVO
   {
       
      
      public var survivalEfficiency:Number;
      
      public function ProfileStatisticsVO(param1:Object)
      {
         super(param1);
      }
      
      public function getSurvivalEfficiencyStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.survivalEfficiency);
      }
   }
}
