package net.wg.gui.lobby.clans.invites.views
{
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.clans.invites.VOs.ClanRequestVO;
   import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
   import net.wg.infrastructure.base.meta.IClanRequestsViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanRequestsViewMeta;
   
   public class ClanRequestsView extends ClanRequestsViewMeta implements IClanRequestsViewMeta
   {
       
      
      public var actualFilterRadioButton:RadioButton = null;
      
      public var expiredFilterRadioButton:RadioButton = null;
      
      public var processedFilterRadioButton:RadioButton = null;
      
      public function ClanRequestsView()
      {
         super();
      }
      
      override protected function getDataProviderVOClass() : Class
      {
         return ClanRequestVO;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         table.addEventListener(ClanTableRendererItemEvent.ACCEPT_CLICKED,this.onTableAcceptClickedHandler);
         table.addEventListener(ClanTableRendererItemEvent.DECLINE_CLICKED,this.onTableDeclineClickedHandler);
         table.addEventListener(ClanTableRendererItemEvent.INVITE_CLICKED,this.onTableInviteClickedHandler);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_ACTUAL,this.actualFilterRadioButton);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_EXPIRED,this.expiredFilterRadioButton);
         registerFilter(CLANS_ALIASES.INVITE_WINDOW_FILTER_PROCESSED,this.processedFilterRadioButton);
      }
      
      override protected function onDispose() : void
      {
         table.removeEventListener(ClanTableRendererItemEvent.ACCEPT_CLICKED,this.onTableAcceptClickedHandler);
         table.removeEventListener(ClanTableRendererItemEvent.DECLINE_CLICKED,this.onTableDeclineClickedHandler);
         table.removeEventListener(ClanTableRendererItemEvent.INVITE_CLICKED,this.onTableInviteClickedHandler);
         this.actualFilterRadioButton.dispose();
         this.actualFilterRadioButton = null;
         this.expiredFilterRadioButton.dispose();
         this.expiredFilterRadioButton = null;
         this.processedFilterRadioButton.dispose();
         this.processedFilterRadioButton = null;
         super.onDispose();
      }
      
      private function onTableInviteClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         sendInviteS(param1.dbID);
      }
      
      private function onTableDeclineClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         declineRequestS(param1.dbID);
      }
      
      private function onTableAcceptClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         acceptRequestS(param1.dbID);
      }
   }
}
