package net.wg.gui.lobby.missions
{
   import flash.display.InteractiveObject;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.infrastructure.base.meta.IMissionsMarathonViewMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsMarathonViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionsDragonBoatView extends MissionsMarathonViewMeta implements IMissionsMarathonViewMeta, IViewStackContent
   {
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public function MissionsDragonBoatView()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.browser)
            {
               this.browser.setSize(_width,_height);
            }
            this.waiting.setSize(_width,_height);
         }
      }
      
      override protected function onDispose() : void
      {
         removeChild(this.browser);
         this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser = null;
         this.waiting.dispose();
         this.waiting = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setMessage(WAITING.LOADCONTENT);
      }
      
      public function as_loadBrowser() : void
      {
         if(this.browser)
         {
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            removeChild(this.browser);
         }
         viewSizeS(_width,_height);
         this.waiting.setSize(_width,_height);
         this.waiting.show();
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser.setSize(_width,_height);
         addChildAt(this.browser,0);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function update(param1:Object) : void
      {
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
