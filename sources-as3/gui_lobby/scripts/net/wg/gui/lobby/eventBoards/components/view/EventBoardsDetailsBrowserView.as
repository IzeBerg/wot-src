package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.infrastructure.base.meta.IBrowserInViewComponentMeta;
   import net.wg.infrastructure.base.meta.impl.BrowserInViewComponentMeta;
   
   public class EventBoardsDetailsBrowserView extends BrowserInViewComponentMeta implements IBrowserInViewComponentMeta
   {
      
      private static const BROWSER_WIDTH:uint = 750;
      
      private static const BROWSER_HEIGHT:uint = 440;
      
      private static const TOP_POSITION:uint = 64;
      
      private static const BROWSER_POSITION_X:uint = 1;
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public var separatorTop:ISeparatorAsset = null;
      
      public var separatorBottom:Sprite = null;
      
      public var titleTf:TextField = null;
      
      public function EventBoardsDetailsBrowserView()
      {
         super();
      }
      
      public function as_loadBrowser() : void
      {
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         addChild(this.browser);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.browser.setSize(BROWSER_WIDTH,BROWSER_HEIGHT);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser.x = BROWSER_POSITION_X;
         this.browser.y = TOP_POSITION;
      }
      
      public function as_setTitle(param1:String) : void
      {
         this.titleTf.text = param1;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this.browser.setSize(param1,param2);
         super.setSize(param1,param2);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         viewSizeS(BROWSER_WIDTH,BROWSER_HEIGHT);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.waiting.visible)
         {
            this.waiting.setSize(BROWSER_WIDTH,BROWSER_HEIGHT);
         }
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
         this.separatorTop.dispose();
         this.separatorTop = null;
         this.separatorBottom = null;
         this.titleTf = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.show();
         this.waiting.backgroundVisibility = false;
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.separatorTop.setType(SeparatorConstants.MEDIUM_TYPE);
         this.separatorTop.mouseEnabled = false;
         this.separatorBottom.mouseEnabled = false;
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
