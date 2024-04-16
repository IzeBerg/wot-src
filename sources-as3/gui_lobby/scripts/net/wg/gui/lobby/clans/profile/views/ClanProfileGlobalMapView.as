package net.wg.gui.lobby.clans.profile.views
{
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.lobby.clans.common.ClanViewWithVariableContent;
   
   public class ClanProfileGlobalMapView extends ClanViewWithVariableContent
   {
       
      
      public function ClanProfileGlobalMapView()
      {
         super();
         currentLinkage = CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_VIEW_LINKAGE;
      }
      
      override protected function initializeContentLinkages() : void
      {
         addLinkageWithAlias(CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_INFO_VIEW_LINKAGE,CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_INFO_VIEW_ALIAS);
         addLinkageWithAlias(CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_PROMO_VIEW_LINKAGE,CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_PROMO_VIEW_ALIAS);
      }
   }
}
