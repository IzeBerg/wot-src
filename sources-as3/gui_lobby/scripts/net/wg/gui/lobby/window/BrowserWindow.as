package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import net.wg.data.Aliases;
   import net.wg.data.constants.generated.BROWSER_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.BrowserActionBtn;
   import net.wg.gui.lobby.browser.events.BrowserActionBtnEvent;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.gui.lobby.browser.events.BrowserTitleEvent;
   import net.wg.infrastructure.base.meta.IBrowserWindowMeta;
   import net.wg.infrastructure.base.meta.impl.BrowserWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class BrowserWindow extends BrowserWindowMeta implements IBrowserWindowMeta
   {
      
      private static const ACTION_BUTTON_OFFSET:Number = 62;
      
      private static const CLOSE_BUTTON_OFFSET_Y:Number = 5;
      
      private static const CLOSE_BUTTON_PADDING_TOP:Number = 3;
      
      private static const BG_ENABLED:String = "enable";
       
      
      public var actionBtn:BrowserActionBtn;
      
      public var browser:Browser = null;
      
      public var closeBtn:SoundButtonEx = null;
      
      private var _browserWidth:Number = 0;
      
      private var _browserHeight:Number = 0;
      
      private var _showCloseBtn:Boolean = false;
      
      private var _isWaiting:Boolean = false;
      
      private var _isSolidBorder:Boolean = false;
      
      public function BrowserWindow()
      {
         super();
         showWindowBgForm = false;
         this.closeBtn.visible = false;
      }
      
      override public function as_hideWaiting() : void
      {
         super.as_hideWaiting();
         this._isWaiting = false;
         this.updateCloseBtnVisibility();
      }
      
      override public function as_showWaiting(param1:String, param2:Object) : void
      {
         super.as_showWaiting(param1,param2);
         this._isWaiting = true;
         this.updateCloseBtnVisibility();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.title = MENU.BROWSER_WINDOW_TITLE;
         Padding(window.contentPadding).bottom = -6;
         window.visible = false;
         registerFlashComponentS(this.browser,Aliases.BROWSER);
      }
      
      override protected function onDispose() : void
      {
         this.actionBtn.removeEventListener(BrowserActionBtnEvent.ON_ACTION,this.onActionBtnOnActionHandler);
         this.actionBtn.dispose();
         this.actionBtn = null;
         this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser.removeEventListener(BrowserTitleEvent.TITLE_CHANGE,this.onBrowserTitleChangeHandler);
         this.browser.removeEventListener(BrowserEvent.SERVICE_VIEW_SHOWED,this.onBrowserServiceViewShowedHandler);
         this.browser.removeEventListener(BrowserEvent.SERVICE_VIEW_HIDDEN,this.onBrowserServiceViewHiddenHandler);
         this.browser = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.actionBtn.addEventListener(BrowserActionBtnEvent.ON_ACTION,this.onActionBtnOnActionHandler);
         this.closeBtn.label = SYSTEM_MESSAGES.WINDOW_BUTTONS_CLOSE;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         this.browser.addEventListener(BrowserTitleEvent.TITLE_CHANGE,this.onBrowserTitleChangeHandler);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_SHOWED,this.onBrowserServiceViewShowedHandler);
         this.browser.addEventListener(BrowserEvent.SERVICE_VIEW_HIDDEN,this.onBrowserServiceViewHiddenHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(window != null && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            this.updatePosition();
         }
      }
      
      override protected function applyWaitingChanges(param1:int, param2:int) : void
      {
         if(this.actionBtn.y < 0)
         {
            param2 -= Math.abs(this.actionBtn.y);
         }
         super.applyWaitingChanges(param1,param2);
      }
      
      override protected function changeBackgroundLabel(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         if(window)
         {
            if(this._isSolidBorder)
            {
               param1 = BG_ENABLED;
            }
            _loc2_ = window.getBackground();
            if(_loc2_ && _loc2_.currentLabel != param1)
            {
               _loc2_.gotoAndPlay(param1);
            }
         }
      }
      
      public function as_configure(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(StringUtils.isNotEmpty(param1))
         {
            window.title = param1;
         }
         this.actionBtn.visible = param2;
         this._showCloseBtn = param3;
         this.updateCloseBtnVisibility();
         if(this._browserWidth != 0)
         {
            this.updateSize(this._browserWidth,this._browserHeight);
         }
         this._isSolidBorder = param4;
      }
      
      public function as_setSize(param1:Number, param2:Number) : void
      {
         this.updateSize(param1,param2);
      }
      
      private function updateSize(param1:Number, param2:Number) : void
      {
         this.width = this.browser.width = this._browserWidth = param1;
         this.height = this.browser.height = this._browserHeight = param2;
         if(this.closeBtn.visible)
         {
            this.height += this.closeBtn.height + CLOSE_BUTTON_OFFSET_Y;
         }
         if(this.actionBtn.y < 0)
         {
            this.height += Math.abs(this.actionBtn.y);
         }
         this.updateWindowSize();
      }
      
      private function updateFocus() : void
      {
         if(!this.actionBtn.isMouseOver)
         {
            setFocus(this);
         }
      }
      
      private function updateWindowSize() : void
      {
         this.actionBtn.x = this._browserWidth - ACTION_BUTTON_OFFSET | 0;
         this.closeBtn.x = this._browserWidth - this.closeBtn.width | 0;
         this.closeBtn.y = this._browserHeight + CLOSE_BUTTON_OFFSET_Y | 0;
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function updatePosition() : void
      {
         window.formBgPadding.bottom += this.closeBtn.height + CLOSE_BUTTON_PADDING_TOP;
         window.x = App.appWidth - window.width >> 1;
         window.y = App.appHeight - window.height >> 1;
         window.visible = true;
         this.browser.invalidateViewS();
      }
      
      private function updateCloseBtnVisibility() : void
      {
         this.closeBtn.visible = this._showCloseBtn && !this._isWaiting;
      }
      
      private function onActionBtnOnActionHandler(param1:BrowserActionBtnEvent) : void
      {
         this.browser.browserActionS(this.actionBtn.action);
      }
      
      private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
      {
         this.actionBtn.action = BROWSER_CONSTANTS.ACTION_LOADING;
         this.updateFocus();
         this.as_showWaiting(WAITING.LOADCONTENT,null);
         this._isWaiting = true;
         this.updateCloseBtnVisibility();
      }
      
      private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
      {
         this.actionBtn.action = BROWSER_CONSTANTS.ACTION_RELOAD;
         this.as_hideWaiting();
         this._isWaiting = false;
         this.updateCloseBtnVisibility();
      }
      
      private function onBrowserTitleChangeHandler(param1:BrowserTitleEvent) : void
      {
         window.title = param1.title;
      }
      
      private function onBrowserServiceViewShowedHandler(param1:BrowserEvent) : void
      {
         showWindowBgForm = true;
         window.invalidate(Window.INVALID_SRC_VIEW);
      }
      
      private function onBrowserServiceViewHiddenHandler(param1:BrowserEvent) : void
      {
         showWindowBgForm = false;
         window.invalidate(Window.INVALID_SRC_VIEW);
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         handleWindowClose();
      }
   }
}
