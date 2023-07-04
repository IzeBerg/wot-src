package net.wg.gui.lobby.stronghold
{
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.infrastructure.base.meta.IStrongholdViewMeta;
   import net.wg.infrastructure.base.meta.impl.StrongholdViewMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class StrongholdView extends StrongholdViewMeta implements IStrongholdViewMeta
   {
      
      private static const OFFSET:int = 22;
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public var screenBg:ScreenBg = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public function StrongholdView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.setSize(_width,_height);
         this.waiting.show();
         this.waiting.backgroundVisibility = false;
         this.screenBg.setSize(_width,_height);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeBtn.visible = false;
         viewSizeS(_width,_height);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.browser)
            {
               this.browser.setSize(_width,_height);
               this.browser.serviceView.x = (_width >> 1) - (this.browser.serviceView.width >> 1);
               this.browser.serviceView.y = (_height >> 1) - (this.browser.serviceView.height >> 1);
            }
            this.waiting.setSize(_width,_height);
            this.screenBg.setSize(_width,_height);
            this.closeBtn.x = _width - this.closeBtn.actualWidth - OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.browser != null)
         {
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            this.browser.removeEventListener(BrowserEvent.SERVICE_VIEW_SHOWED,this.onBrowserServiceViewShowedHandler);
            this.browser.removeEventListener(BrowserEvent.SERVICE_VIEW_HIDDEN,this.onBrowserServiceViewHiddenHandler);
            removeChild(this.browser);
            this.browser = null;
         }
         this.waiting.dispose();
         this.waiting = null;
         this.screenBg.dispose();
         this.screenBg = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         super.onDispose();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         onFocusChangeS(true);
      }
      
      override protected function onLeaveModalFocus() : void
      {
         super.onLeaveModalFocus();
         onFocusChangeS(false);
      }
      
      public function as_loadBrowser() : void
      {
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         addChild(this.browser);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.browser.setSize(_width,_height);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_SHOWED,this.onBrowserServiceViewShowedHandler);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_HIDDEN,this.onBrowserServiceViewHiddenHandler);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            onEscapePressS();
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
      
      private function onBrowserServiceViewShowedHandler(param1:BrowserEvent) : void
      {
         this.closeBtn.visible = true;
      }
      
      private function onBrowserServiceViewHiddenHandler(param1:BrowserEvent) : void
      {
         this.closeBtn.visible = false;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onEscapePressS();
      }
   }
}
