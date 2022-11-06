package net.wg.gui.lobby.stronghold
{
   import flash.events.Event;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.infrastructure.base.meta.impl.StrongholdBattlesListViewMeta;
   
   public class StrongholdListView extends StrongholdBattlesListViewMeta
   {
      
      private static const BROWSER_WIDTH:int = 1013;
      
      private static const BROWSER_HEIGHT:int = 653;
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public function StrongholdListView()
      {
         super();
      }
      
      override public function as_loadBrowser() : void
      {
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         addChild(this.browser);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.browser.setSize(BROWSER_WIDTH,BROWSER_HEIGHT);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         viewSizeS(BROWSER_WIDTH,BROWSER_HEIGHT);
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this.browser)
         {
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.browser = null;
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
      
      private function onStageResizeHandler(param1:Event) : void
      {
         if(param1.target == stage)
         {
            updateBrowserS();
         }
      }
      
      private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
      {
         this.waiting.show();
      }
      
      private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
      {
         this.waiting.hide();
      }
   }
}
