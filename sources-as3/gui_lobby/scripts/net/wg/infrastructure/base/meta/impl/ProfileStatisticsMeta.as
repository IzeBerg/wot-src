package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   
   public class ProfileStatisticsMeta extends ProfileSection
   {
       
      
      public var getData:Function;
      
      public var setSeason:Function;
      
      public var showPlayersStats:Function;
      
      public function ProfileStatisticsMeta()
      {
         super();
      }
      
      public function getDataS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.getData,"getData" + Errors.CANT_NULL);
         this.getData(param1);
      }
      
      public function setSeasonS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.setSeason,"setSeason" + Errors.CANT_NULL);
         this.setSeason(param1);
      }
      
      public function showPlayersStatsS() : void
      {
         App.utils.asserter.assertNotNull(this.showPlayersStats,"showPlayersStats" + Errors.CANT_NULL);
         this.showPlayersStats();
      }
   }
}
