package net.wg.gui.lobby.clans.invites
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.clans.invites.views.ClanPersonalInvitesView;
   import net.wg.infrastructure.base.meta.IClanPersonalInvitesWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ClanPersonalInvitesWindowMeta;
   
   public class ClanPersonalInvitesWindow extends ClanPersonalInvitesWindowMeta implements IClanPersonalInvitesWindowMeta
   {
       
      
      public var bg:UILoaderAlt = null;
      
      public var titleTF:TextField = null;
      
      public var actualInvitesTF:TextField = null;
      
      public var view:ClanPersonalInvitesView = null;
      
      public var waitingCmp:WaitingComponent = null;
      
      public function ClanPersonalInvitesWindow()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.view,CLANS_ALIASES.CLAN_PERSONAL_INVITES_VIEW_ALIAS);
         this.waitingCmp.visible = false;
         this.waitingCmp.backgroundMc.visible = false;
         this.waitingCmp.setAnimationStatus(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTF.text = CLANS.CLANPERSONALINVITESWINDOW_HEADERTEXT;
         window.title = CLANS.CLANPERSONALINVITESWINDOW_TITLE;
         this.bg.source = RES_ICONS.MAPS_ICONS_CLANS_INVITESWINDOW_CC_HEADER_BACK;
         this.bg.mouseEnabled = false;
         this.bg.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.view = null;
         this.titleTF = null;
         this.actualInvitesTF = null;
         this.bg.dispose();
         this.bg = null;
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         super.onDispose();
      }
      
      public function as_setActualInvitesText(param1:String) : void
      {
         this.actualInvitesTF.htmlText = param1;
      }
      
      public function as_showWaitingAnimation(param1:Boolean) : void
      {
         if(this.waitingCmp.visible == param1)
         {
            return;
         }
         this.view.setTableListVisible(!param1);
         this.waitingCmp.visible = param1;
         this.waitingCmp.setAnimationStatus(!param1);
      }
   }
}
