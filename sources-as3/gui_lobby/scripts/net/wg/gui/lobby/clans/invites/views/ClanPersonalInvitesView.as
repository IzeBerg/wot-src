package net.wg.gui.lobby.clans.invites.views
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
   import net.wg.gui.lobby.clans.invites.VOs.PersonalInviteVO;
   import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
   import net.wg.infrastructure.base.meta.IClanPersonalInvitesViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanPersonalInvitesViewMeta;
   
   public class ClanPersonalInvitesView extends ClanPersonalInvitesViewMeta implements IClanPersonalInvitesViewMeta
   {
      
      private static const SELECT_ALL_GAP:int = 30;
       
      
      public var declineSelectedButton:IconTextButton = null;
      
      public var selectAllCheckBox:CompactCheckBox = null;
      
      public function ClanPersonalInvitesView()
      {
         super();
      }
      
      override protected function getDataProviderVOClass() : Class
      {
         return PersonalInviteVO;
      }
      
      override protected function onDispose() : void
      {
         table.removeEventListener(ClanTableRendererItemEvent.ACCEPT_CLICKED,this.onTableAcceptClickedHandler);
         table.removeEventListener(ClanTableRendererItemEvent.DECLINE_CLICKED,this.onTableDeclineClickedHandler);
         table.removeEventListener(ClanTableRendererItemEvent.ITEM_CHECKED,this.onTableItemCheckedHandler);
         table.removeEventListener(ClanTableRendererItemEvent.ITEM_UNCHECKED,this.onTableItemUncheckedHandler);
         this.declineSelectedButton.removeEventListener(MouseEvent.CLICK,this.onDeclineSelectedButtonClickHandler);
         this.declineSelectedButton.dispose();
         this.declineSelectedButton = null;
         this.selectAllCheckBox.removeEventListener(Event.SELECT,this.onSelectAllCheckBoxSelectHandler);
         this.selectAllCheckBox.dispose();
         this.selectAllCheckBox = null;
         super.onDispose();
      }
      
      override protected function getClanInvitesViewVOForData(param1:Object) : ClanInvitesViewVO
      {
         return new ClanInvitesViewVO(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         table.addEventListener(ClanTableRendererItemEvent.ACCEPT_CLICKED,this.onTableAcceptClickedHandler);
         table.addEventListener(ClanTableRendererItemEvent.DECLINE_CLICKED,this.onTableDeclineClickedHandler);
         table.addEventListener(ClanTableRendererItemEvent.ITEM_CHECKED,this.onTableItemCheckedHandler);
         table.addEventListener(ClanTableRendererItemEvent.ITEM_UNCHECKED,this.onTableItemUncheckedHandler);
         this.declineSelectedButton.addEventListener(MouseEvent.CLICK,this.onDeclineSelectedButtonClickHandler);
         this.selectAllCheckBox.label = CLANS.CLANPERSONALINVITESWINDOW_SELECTALL;
         this.selectAllCheckBox.addEventListener(Event.SELECT,this.onSelectAllCheckBoxSelectHandler);
         this.selectAllCheckBox.validateNow();
         this.layoutSelectAllButton();
      }
      
      public function as_setDeclineAllSelectedInvitesState(param1:String, param2:Boolean) : void
      {
         this.declineSelectedButton.label = param1;
         this.declineSelectedButton.enabled = param2;
      }
      
      public function as_setSelectAllCheckboxState(param1:Boolean, param2:Boolean) : void
      {
         this.selectAllCheckBox.visible = param2;
         if(param2)
         {
            this.selectAllCheckBox.removeEventListener(Event.SELECT,this.onSelectAllCheckBoxSelectHandler);
            this.selectAllCheckBox.selected = param1;
            this.selectAllCheckBox.addEventListener(Event.SELECT,this.onSelectAllCheckBoxSelectHandler);
         }
         this.layoutSelectAllButton();
      }
      
      public function setTableListVisible(param1:Boolean) : void
      {
         table.listVisible = param1;
      }
      
      private function layoutSelectAllButton() : void
      {
         if(this.selectAllCheckBox.visible)
         {
            this.declineSelectedButton.x = this.selectAllCheckBox.x + this.selectAllCheckBox.actualWidth + SELECT_ALL_GAP;
         }
         else
         {
            this.declineSelectedButton.x = this.selectAllCheckBox.x;
         }
      }
      
      private function onDeclineSelectedButtonClickHandler(param1:MouseEvent) : void
      {
         declineAllSelectedInvitesS();
      }
      
      private function onSelectAllCheckBoxSelectHandler(param1:Event) : void
      {
         setSelectAllInvitesCheckBoxSelectedS(this.selectAllCheckBox.selected);
      }
      
      private function onTableItemUncheckedHandler(param1:ClanTableRendererItemEvent) : void
      {
         setInviteSelectedS(param1.dbID,false);
      }
      
      private function onTableItemCheckedHandler(param1:ClanTableRendererItemEvent) : void
      {
         setInviteSelectedS(param1.dbID,true);
      }
      
      private function onTableDeclineClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         declineInviteS(param1.dbID);
      }
      
      private function onTableAcceptClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         acceptInviteS(param1.dbID);
      }
   }
}
