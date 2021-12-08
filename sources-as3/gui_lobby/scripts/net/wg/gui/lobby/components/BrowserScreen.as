package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.gui.lobby.components.data.BrowserVO;
   import net.wg.infrastructure.base.meta.IBrowserScreenMeta;
   import net.wg.infrastructure.base.meta.impl.BrowserScreenMeta;
   import org.idmedia.as3commons.lang.IllegalStateException;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BrowserScreen extends BrowserScreenMeta implements IBrowserScreenMeta
   {
      
      private static const CLOSE_BUTTON_RIGHT_OFFSET:int = 10;
      
      private static const CLOSE_BUTTON_PADDING_BIG:int = 30;
      
      private static const CLOSE_BUTTON_PADDING_SMALL:int = 10;
       
      
      public var browser:Browser = null;
      
      public var waiting:Waiting = null;
      
      public var screenBg:ScreenBg = null;
      
      public var closeBtn:ISoundButtonEx = null;
      
      protected var browserParams:BrowserVO;
      
      public function BrowserScreen()
      {
         super();
      }
      
      override public function get modalAlpha() : Number
      {
         return Values.ZERO;
      }
      
      override public function get isModal() : Boolean
      {
         return Boolean(this.browserParams) ? Boolean(this.browserParams.isModal) : Boolean(super.isModal);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      public function as_loadBrowser() : void
      {
         if(this.browser)
         {
            throw new IllegalStateException("The Browser instance has been already created!");
         }
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         this.browser.name = Aliases.BROWSER;
         this.browser.visible = !this.browserParams.isHidden;
         addChildAt(this.browser,getChildIndex(DisplayObject(this.closeBtn)));
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.browser.setSize(_width,_height);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_SHOWED,this.onBrowserServiceViewShowedHandler);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_HIDDEN,this.onBrowserServiceViewHiddenHandler);
         if(this.browser.visible)
         {
            this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         }
      }
      
      override protected function setBrowserParams(param1:BrowserVO) : void
      {
         this.browserParams = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setSize(_width,_height);
         this.waiting.show();
         this.waiting.backgroundVisibility = false;
         this.screenBg.setSize(_width,_height + this.bottomPanelHeight);
         viewSizeS(_width,_height);
         this.closeBtn.visible = this.browserParams.isCloseBtnVisible;
         this.closeBtn.label = PROFILE.SECTION_HOF_BROWSERVIEW_CLOSEBTN;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,onEscapePressS,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this.browserParams && isInvalid(InvalidationType.DATA))
         {
            this.waiting.setMessage(this.browserParams.waitingMessage);
            this.screenBg.alpha = this.browserParams.bgAlpha;
            if(this.screenBg.alpha < Values.DEFAULT_ALPHA)
            {
               this.screenBg.visible = true;
            }
            else
            {
               this.screenBg.visible = !this.browserParams.isHidden;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.browser != null)
            {
               this.browser.setSize(_width,_height);
            }
            this.waiting.setSize(_width,_height);
            this.screenBg.setSize(_width,_height + this.bottomPanelHeight);
            _loc1_ = _width > 1366 ? int(CLOSE_BUTTON_PADDING_BIG) : int(CLOSE_BUTTON_PADDING_SMALL);
            this.closeBtn.x = _width - this.closeBtn.actualWidth + CLOSE_BUTTON_RIGHT_OFFSET - _loc1_;
            this.closeBtn.y = _loc1_;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,onEscapePressS);
         super.onBeforeDispose();
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
         this.browserParams = null;
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
      
      private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
      {
         this.waiting.show();
      }
      
      private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
      {
         this.waiting.hide();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onBrowserServiceViewShowedHandler(param1:BrowserEvent) : void
      {
         if(!this.browserParams.isCloseBtnVisible)
         {
            this.closeBtn.visible = true;
         }
      }
      
      private function onBrowserServiceViewHiddenHandler(param1:BrowserEvent) : void
      {
         if(!this.browserParams.isCloseBtnVisible)
         {
            this.closeBtn.visible = false;
         }
      }
      
      protected function get bottomPanelHeight() : int
      {
         return !!this.isModal ? int(Values.ZERO) : int(36);
      }
   }
}
