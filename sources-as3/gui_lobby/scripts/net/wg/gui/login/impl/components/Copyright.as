package net.wg.gui.login.impl.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextLineMetrics;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.login.impl.ev.LoginLogosEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class Copyright extends UIComponentEx
   {
       
      
      public var logotypes:LoginLogos = null;
      
      public var textField:TextField = null;
      
      public var legalLink:SoundButtonEx = null;
      
      private const LINK_MARGIN:Number = 9;
      
      private const MARGIN:Number = 40;
      
      public function Copyright()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.legalLink.addEventListener(MouseEvent.MOUSE_OVER,this.showToolTip);
         this.legalLink.addEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip);
         this.legalLink.addEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
         this.legalLink.addEventListener(ButtonEvent.CLICK,this.showLegal);
         this.logotypes.addEventListener(LoginLogosEvent.CHANGE,this.onLogoChangeHandler);
         var _loc1_:String = App.globalVarsMgr.getLocaleOverrideS();
         if(_loc1_)
         {
            this.logotypes.setLocale(_loc1_);
         }
         else
         {
            this.logotypes.defLogo();
         }
      }
      
      private function showLegal(param1:ButtonEvent) : void
      {
         dispatchEvent(new CopyrightEvent(CopyrightEvent.TO_LEGAL));
      }
      
      private function hideToolTip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function showToolTip(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.LOGIN_LEGAL);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      public function updateLabel(param1:String, param2:String = "") : void
      {
         if(param2 == "" || !param2)
         {
            this.textField.text = param1;
            this.legalLink.visible = false;
         }
         else
         {
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textField.text = param1 + "\n" + param2;
            this.textField.x = this.MARGIN;
            this.textField.y = this.logotypes.y - 12;
            this.legalLink.visible = true;
            this.updateLinkPosition();
         }
      }
      
      private function updateLinkPosition() : void
      {
         var _loc1_:Number = this.textField.numLines - 1;
         if(_loc1_ < 0)
         {
            return;
         }
         var _loc2_:TextLineMetrics = this.textField.getLineMetrics(_loc1_);
         this.legalLink.x = this.textField.x + _loc2_.width + this.LINK_MARGIN;
         this.legalLink.y = this.textField.y + _loc1_ * _loc2_.height + (this.legalLink.height - _loc2_.height) / 2 + _loc2_.leading ^ 0;
         this.updateThisXPosition();
      }
      
      private function updateThisXPosition() : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function getWidth() : Number
      {
         return this.textField.x + this.textField.textWidth;
      }
      
      override protected function onDispose() : void
      {
         this.legalLink.removeEventListener(MouseEvent.MOUSE_OVER,this.showToolTip);
         this.legalLink.removeEventListener(MouseEvent.MOUSE_DOWN,this.hideToolTip);
         this.legalLink.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
         this.legalLink.removeEventListener(ButtonEvent.CLICK,this.showLegal);
         this.logotypes.removeEventListener(LoginLogosEvent.CHANGE,this.onLogoChangeHandler);
         super.onDispose();
      }
      
      private function onLogoChangeHandler(param1:LoginLogosEvent) : void
      {
         this.textField.x = this.logotypes.x + param1.logosWidth + this.MARGIN;
         this.updateLinkPosition();
      }
   }
}
