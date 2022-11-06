package net.wg.gui.lobby.clans.invites.views
{
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInviteVO;
   import net.wg.infrastructure.base.meta.IClanInvitesViewMeta;
   
   public class ClanInvitesView extends ClanInvitesWindowAbstractTabView implements IClanInvitesViewMeta
   {
       
      
      public var actualFilterRadioButton:RadioButton = null;
      
      public var expiredFilterRadioButton:RadioButton = null;
      
      public var processedFilterRadioButton:RadioButton = null;
      
      public var allFilterRadioButton:RadioButton = null;
      
      public function ClanInvitesView()
      {
         super();
      }
      
      override protected function getDataProviderVOClass() : Class
      {
         return ClanInviteVO;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_ALL,this.allFilterRadioButton);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_ACTUAL,this.actualFilterRadioButton);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_EXPIRED,this.expiredFilterRadioButton);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_PROCESSED,this.processedFilterRadioButton);
      }
      
      override protected function onDispose() : void
      {
         this.actualFilterRadioButton.dispose();
         this.actualFilterRadioButton = null;
         this.expiredFilterRadioButton.dispose();
         this.expiredFilterRadioButton = null;
         this.processedFilterRadioButton.dispose();
         this.processedFilterRadioButton = null;
         this.allFilterRadioButton.dispose();
         this.allFilterRadioButton = null;
         super.onDispose();
      }
   }
}
