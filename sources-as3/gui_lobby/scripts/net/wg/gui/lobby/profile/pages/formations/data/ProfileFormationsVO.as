package net.wg.gui.lobby.profile.pages.formations.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileFormationsVO extends DAAPIDataClass
   {
      
      private static const TEAM_HEADER:String = "teamHeader";
      
      private static const CLAN_HEADER:String = "clanHeader";
      
      private static const PREVIOUS_TEAMS:String = "previousTeams";
      
      private static const TEAM_STATS:String = "teamStats";
      
      private static const FORT_STATS:String = "fortStats";
       
      
      public var isPersonalProfile:Boolean = false;
      
      public var isClanAvailable:Boolean = false;
      
      public var clanHeader:FormationHeaderVO;
      
      public var searchClanLink:String = "";
      
      public var createClanLink:String = "";
      
      public var fortStats:Array;
      
      public var isFortAvailable:Boolean = false;
      
      public var fortState:int = -1;
      
      public var isClanOwner:Boolean = false;
      
      public var fortLevel:String = "";
      
      public var teamHeader:FormationHeaderVO;
      
      public var teamStats:Array;
      
      public var leagueIcon:String = "";
      
      public var league:String = "";
      
      public var season:String = "";
      
      public var previousTeams:Array;
      
      public function ProfileFormationsVO(param1:Object)
      {
         this.fortStats = [];
         this.teamStats = [];
         this.previousTeams = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         switch(param1)
         {
            case TEAM_HEADER:
               if(param2 != null)
               {
                  this.teamHeader = new FormationHeaderVO(param2);
               }
               return false;
            case CLAN_HEADER:
               if(param2 != null)
               {
                  this.clanHeader = new FormationHeaderVO(param2);
               }
               return false;
            case PREVIOUS_TEAMS:
               for each(_loc3_ in param2)
               {
                  this.previousTeams.push(new PreviousTeamsItemVO(_loc3_));
               }
               return false;
            case TEAM_STATS:
               for each(_loc3_ in param2)
               {
                  this.teamStats.push(new FormationStatVO(_loc3_));
               }
               return false;
            case FORT_STATS:
               for each(_loc3_ in param2)
               {
                  this.fortStats.push(new FormationStatVO(_loc3_));
               }
               return false;
            default:
               return super.onDataRead(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.commons.releaseReferences(this.previousTeams);
         this.previousTeams = null;
         if(this.teamHeader != null)
         {
            this.teamHeader.dispose();
            this.teamHeader = null;
         }
         App.utils.commons.releaseReferences(this.teamStats);
         this.teamStats = null;
         if(this.clanHeader != null)
         {
            this.clanHeader.dispose();
            this.clanHeader = null;
         }
         App.utils.commons.releaseReferences(this.fortStats);
         this.fortStats = null;
         super.onDispose();
      }
   }
}
