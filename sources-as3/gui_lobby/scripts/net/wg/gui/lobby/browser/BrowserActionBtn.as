package net.wg.gui.lobby.browser
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.BROWSER_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.browser.events.BrowserActionBtnEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   [Event(name="reload",type="net.wg.gui.lobby.browser.events.BrowserEvent")]
   [Event(name="loading",type="net.wg.gui.lobby.browser.events.BrowserEvent")]
   public class BrowserActionBtn extends UIComponentEx
   {
       
      
      public var btn:SoundButtonEx;
      
      public var icon:MovieClip;
      
      public var stopIcon:MovieClip;
      
      private var _isMouseOver:Boolean = false;
      
      private var _action:String = "loading";
      
      public function BrowserActionBtn()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.btn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.btn.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         this.btn.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
         this.btn.dispose();
         this.btn = null;
         this.icon = null;
         this.stopIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.mouseEnabled = false;
         this.icon.mouseChildren = false;
         this.stopIcon.mouseEnabled = false;
         this.stopIcon.mouseChildren = false;
         this._action = BROWSER_CONSTANTS.ACTION_RELOAD;
         this.showStopIcon(false);
         this.btn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.btn.addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         this.btn.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
      }
      
      private function showStopIcon(param1:Boolean) : void
      {
         this.stopIcon.visible = param1;
         this.icon.visible = !param1;
      }
      
      [Inspectable(defaultValue="loading",enumeration="loading,reload",verbose="1")]
      public function get action() : String
      {
         return this._action;
      }
      
      public function set action(param1:String) : void
      {
         this._action = param1;
         gotoAndStop(this._action);
         this.icon.mouseEnabled = false;
         this.icon.mouseChildren = false;
         if(this._action == BROWSER_CONSTANTS.ACTION_RELOAD)
         {
            this.showStopIcon(false);
         }
         else if(this._isMouseOver)
         {
            this.showStopIcon(true);
         }
      }
      
      public function get isMouseOver() : Boolean
      {
         return this._isMouseOver;
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BrowserActionBtnEvent(BrowserActionBtnEvent.ON_ACTION));
      }
      
      private function onBtnRollOverHandler(param1:MouseEvent) : void
      {
         this.showStopIcon(this._action == BROWSER_CONSTANTS.ACTION_LOADING);
         this._isMouseOver = true;
      }
      
      private function onBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.showStopIcon(false);
         this._isMouseOver = false;
      }
   }
}
