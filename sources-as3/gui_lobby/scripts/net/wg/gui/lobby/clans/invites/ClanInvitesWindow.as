package net.wg.gui.lobby.clans.invites
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
   import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
   import net.wg.gui.lobby.clans.common.IClanHeaderComponent;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowHeaderStateVO;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowVO;
   import net.wg.gui.lobby.clans.invites.views.ClanInvitesWindowAbstractTabView;
   import net.wg.infrastructure.base.meta.IClanInvitesWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ClanInvitesWindowMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.events.IndexEvent;
   
   public class ClanInvitesWindow extends ClanInvitesWindowMeta implements IClanInvitesWindowMeta
   {
      
      private static const HEADER_INV:String = "headerInv";
      
      private static const CLAN_INV:String = "clanInv";
      
      private static const ENABLE_INV:String = "EnableInv";
       
      
      public var header:IClanHeaderComponent = null;
      
      public var inviteButton:ISoundButtonEx = null;
      
      public var freePlacesTF:TextField = null;
      
      public var tabs:ContentTabBar = null;
      
      public var viewStack:ViewStack = null;
      
      private var _currentViewAlias:String = null;
      
      private var _clanBaseInfoVO:ClanBaseInfoVO = null;
      
      private var _clanInvitesWindowHeaderStateVO:ClanInvitesWindowHeaderStateVO = null;
      
      private var _areControlsEnabled:Boolean = true;
      
      public function ClanInvitesWindow()
      {
         super();
         this.viewStack.cache = true;
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.inviteButton.removeEventListener(MouseEvent.CLICK,this.onInviteButtonClickHandler);
         this.inviteButton.dispose();
         this.inviteButton = null;
         this.freePlacesTF = null;
         this._currentViewAlias = null;
         this._clanBaseInfoVO = null;
         this._clanInvitesWindowHeaderStateVO = null;
         super.onDispose();
      }
      
      override protected function setClanInfo(param1:ClanBaseInfoVO) : void
      {
         this._clanBaseInfoVO = param1;
         invalidate(CLAN_INV);
      }
      
      override protected function setHeaderState(param1:ClanInvitesWindowHeaderStateVO) : void
      {
         this._clanInvitesWindowHeaderStateVO = param1;
         invalidate(HEADER_INV);
      }
      
      override protected function setData(param1:ClanInvitesWindowVO) : void
      {
         this.tabs.dataProvider = param1.tabDataProvider;
         if(this.tabs.selectedIndex == -1)
         {
            this.tabs.selectedIndex = 0;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.title = CLANS.CLANINVITESWINDOW_TITLE;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.inviteButton.mouseEnabledOnDisabled = true;
         this.inviteButton.addEventListener(MouseEvent.CLICK,this.onInviteButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._clanInvitesWindowHeaderStateVO != null && isInvalid(HEADER_INV))
         {
            this.inviteButton.label = this._clanInvitesWindowHeaderStateVO.inviteButtonText;
            this.inviteButton.tooltip = this._clanInvitesWindowHeaderStateVO.inviteButtonTooltip;
            this.inviteButton.enabled = this._clanInvitesWindowHeaderStateVO.inviteButtonEnabled;
            this.freePlacesTF.htmlText = this._clanInvitesWindowHeaderStateVO.freePlacesInClanText;
         }
         if(isInvalid(ENABLE_INV))
         {
            this.tabs.enabled = this._areControlsEnabled;
            if(this.viewStack.currentView != null)
            {
               ClanInvitesWindowAbstractTabView(this.viewStack.currentView).setControlsEnabled(this._areControlsEnabled);
            }
         }
         if(this._clanBaseInfoVO != null && isInvalid(CLAN_INV))
         {
            this.header.setBaseInfo(this._clanBaseInfoVO);
         }
      }
      
      public function as_setClanEmblem(param1:String) : void
      {
         this.header.setEmblem(param1);
      }
      
      public function as_setControlsEnabled(param1:Boolean) : void
      {
         this._areControlsEnabled = param1;
         invalidate(ENABLE_INV);
      }
      
      private function onInviteButtonClickHandler(param1:MouseEvent) : void
      {
         if(this.inviteButton.enabled)
         {
            onInvitesButtonClickS();
         }
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         if(param1.viewId == CLANS_ALIASES.CLAN_PROFILE_INVITES_VIEW_LINKAGE)
         {
            this._currentViewAlias = CLANS_ALIASES.CLAN_PROFILE_INVITES_VIEW_ALIAS;
         }
         else if(param1.viewId == CLANS_ALIASES.CLAN_PROFILE_REQUESTS_VIEW_LINKAGE)
         {
            this._currentViewAlias = CLANS_ALIASES.CLAN_PROFILE_REQUESTS_VIEW_ALIAS;
         }
         else
         {
            this._currentViewAlias = null;
            App.utils.asserter.assert(true,Errors.BAD_LINKAGE + param1.viewId);
         }
         if(this._currentViewAlias && !isFlashComponentRegisteredS(this._currentViewAlias))
         {
            registerFlashComponentS(IDAAPIModule(param1.view),this._currentViewAlias);
            invalidate(ENABLE_INV);
         }
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:String = ClanTabDataProviderVO(param1.data).linkage;
         this.viewStack.show(_loc2_,_loc2_);
      }
   }
}
