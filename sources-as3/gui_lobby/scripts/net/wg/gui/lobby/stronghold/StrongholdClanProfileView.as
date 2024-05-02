package net.wg.gui.lobby.stronghold
{
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
   
   public class StrongholdClanProfileView extends ClanProfileBaseView
   {
      
      private static const BROWSER_WIDTH:int = 1006;
      
      private static const BROWSER_HEIGHT:int = 597;
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public function StrongholdClanProfileView()
      {
         super();
         header.visible = false;
         currentLinkage = CLANS_ALIASES.CLAN_PROFILE_STRONGHOLDS_VIEW_LINKAGE;
      }
      
      override public function as_loadBrowser() : void
      {
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         addChild(this.browser);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.browser.setSize(BROWSER_WIDTH,BROWSER_HEIGHT);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         viewSizeS(BROWSER_WIDTH,BROWSER_HEIGHT);
      }
      
      override protected function onDispose() : void
      {
         if(this.browser)
         {
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            this.browser = null;
         }
         this.waiting.dispose();
         this.waiting = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.setSize(BROWSER_WIDTH,BROWSER_HEIGHT);
         this.waiting.show();
         this.waiting.backgroundVisibility = false;
      }
      
      private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
      {
         this.waiting.show();
      }
      
      private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
      {
         this.waiting.hide();
      }
      
      override public function as_setData(param1:Object) : void
      {
      }
   }
}
