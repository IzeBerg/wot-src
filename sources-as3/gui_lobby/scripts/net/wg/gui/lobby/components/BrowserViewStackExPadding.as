package net.wg.gui.lobby.components
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.browser.Browser;
   import net.wg.gui.lobby.browser.events.BrowserEvent;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import net.wg.infrastructure.base.meta.IBrowserViewStackExPaddingMeta;
   import net.wg.infrastructure.base.meta.impl.BrowserViewStackExPaddingMeta;
   import net.wg.infrastructure.interfaces.IViewStackExPaddingContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class BrowserViewStackExPadding extends BrowserViewStackExPaddingMeta implements IViewStackExPaddingContent, IBrowserViewStackExPaddingMeta
   {
      
      private static const WAITING_INVALID:String = "waitingInvalid";
       
      
      public var browser:Browser = null;
      
      public var waiting:IWaiting = null;
      
      private var _allowWaiting:Boolean = true;
      
      private var _isWaitingTime:Boolean = true;
      
      private var _isDisableShowBrowser:Boolean = false;
      
      private var _isSizeInited:Boolean = false;
      
      private var _isApplyPadding:Boolean = false;
      
      private var _viewPadding:Padding;
      
      public function BrowserViewStackExPadding()
      {
         this._viewPadding = new Padding();
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT,InvalidationType.SIZE))
         {
            this.updateLayout();
         }
         if(isInvalid(WAITING_INVALID))
         {
            this.updateWaiting();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.browser != null)
         {
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            removeChild(this.browser);
            this.browser = null;
         }
         this.waiting.dispose();
         this.waiting = null;
         this._viewPadding = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         invalidateSize();
      }
      
      public function as_createBrowserView() : void
      {
         App.utils.asserter.assertNull(this.browser,"The Browser instance has been already created!");
         this.browser = App.utils.classFactory.getComponent(Linkages.BROWSER_UI,Browser);
         this.browser.name = Aliases.BROWSER;
         addChild(this.browser);
         this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
         this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
         registerFlashComponentS(this.browser,Aliases.BROWSER);
         this.updateLayout();
      }
      
      public function as_setAllowWaiting(param1:Boolean, param2:Boolean) : void
      {
         if(this._allowWaiting == param1 && this._isWaitingTime == param2)
         {
            return;
         }
         this._allowWaiting = param1;
         this._isWaitingTime = param2;
         invalidate(WAITING_INVALID);
      }
      
      public function as_setWaitingMessage(param1:String) : void
      {
         this.waiting.setMessage(param1);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setActive(param1:Boolean) : void
      {
      }
      
      public function setSizePadding(param1:Padding, param2:Boolean) : void
      {
         if(this._viewPadding == param1)
         {
            return;
         }
         this._isApplyPadding = param2;
         this._viewPadding = param1;
         invalidateLayout();
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function updateWaiting() : void
      {
         if(this.browser)
         {
            this.browser.visible = !this._isWaitingTime && !this._isDisableShowBrowser;
         }
         if(this._isWaitingTime && this._allowWaiting && this._isSizeInited)
         {
            this.waiting.show();
         }
         else
         {
            this.waiting.hide();
         }
      }
      
      private function updateLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = this.browserWidth;
         var _loc2_:int = this.browserHeight;
         if(!this._isSizeInited && isDAAPIInited && _loc1_ > 0 && _loc2_ > 0)
         {
            if(this._isApplyPadding)
            {
               x = -this._viewPadding.left;
               y = -this._viewPadding.top;
               _loc1_ -= this._viewPadding.left;
               _loc2_ -= this._viewPadding.top;
            }
            _loc3_ = App.appScale;
            setViewSizeS(_loc1_ * _loc3_,_loc2_ * _loc3_);
            this._isSizeInited = true;
            invalidate(WAITING_INVALID);
         }
         if(this.browser != null)
         {
            this.browser.setSize(_loc1_,_loc2_);
         }
         this.waiting.setSize(_loc1_,_loc2_);
      }
      
      public function get browserWidth() : int
      {
         return _width;
      }
      
      public function get browserHeight() : int
      {
         return _height;
      }
      
      public function get isDisableShowBrowser() : Boolean
      {
         return this._isDisableShowBrowser;
      }
      
      public function set isDisableShowBrowser(param1:Boolean) : void
      {
         if(param1 == this._isDisableShowBrowser)
         {
            return;
         }
         this._isDisableShowBrowser = param1;
         invalidate(WAITING_INVALID);
      }
      
      private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
      {
         this._isWaitingTime = true;
         invalidate(WAITING_INVALID);
      }
      
      private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
      {
         this._isWaitingTime = false;
         dispatchEvent(new Event(Event.COMPLETE));
         invalidate(WAITING_INVALID);
      }
   }
}
