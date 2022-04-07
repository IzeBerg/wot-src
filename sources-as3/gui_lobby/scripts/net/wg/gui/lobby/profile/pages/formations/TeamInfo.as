package net.wg.gui.lobby.profile.pages.formations
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
   
   public class TeamInfo extends FormationInfoAbstract
   {
       
      
      public var header:FormationHeader;
      
      public var teamStat0:LineDescrIconText;
      
      public var teamStat1:LineDescrIconText;
      
      public var leagueIcon:UILoaderAlt;
      
      public var league:TextField;
      
      public var season:TextField;
      
      public function TeamInfo()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.teamStat0.dispose();
         this.teamStat0 = null;
         this.teamStat1.dispose();
         this.teamStat1 = null;
         this.leagueIcon.dispose();
         this.leagueIcon = null;
         this.league = null;
         this.season = null;
         super.dispose();
      }
      
      override protected function initHeader() : FormationHeader
      {
         return this.header;
      }
      
      override protected function initStatItems() : Vector.<LineDescrIconText>
      {
         return new <LineDescrIconText>[this.teamStat0,this.teamStat1];
      }
      
      override protected function onUpdate(param1:ProfileFormationsVO) : void
      {
         setHeader(param1.teamHeader);
         setStats(param1.teamStats);
         this.leagueIcon.source = param1.leagueIcon;
         this.league.text = param1.league;
         this.season.text = param1.season;
      }
   }
}
