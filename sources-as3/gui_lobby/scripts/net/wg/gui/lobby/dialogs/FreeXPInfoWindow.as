package net.wg.gui.lobby.dialogs
{
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.IEventDispatcher;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.base.meta.IFreeXPInfoWindowMeta;
   import net.wg.infrastructure.base.meta.impl.FreeXPInfoWindowMeta;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class FreeXPInfoWindow extends FreeXPInfoWindowMeta implements IFreeXPInfoWindowMeta
   {
      
      private static const TEXT_PADDING:int = 5;
      
      private static const BUTTON_PADDING:int = 19;
       
      
      public var submitButton:SoundButtonEx;
      
      public var textInfo:TextField;
      
      public var cancelButton:SoundButtonEx;
      
      public function FreeXPInfoWindow()
      {
         super();
         this.updateElements(false);
         this.textInfo.mouseEnabled = false;
         scaleX = scaleY = 1;
      }
      
      private function updateElements(param1:Boolean = false) : void
      {
         this.cancelButton.visible = param1;
      }
      
      public function as_setSubmitLabel(param1:String) : void
      {
         if(this.submitButton && this.submitButton.label != param1)
         {
            this.submitButton.label = param1;
            this.submitButton.x = this.cancelButton.x;
         }
      }
      
      public function as_setTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      public function as_setText(param1:Object) : void
      {
         this.textInfo.htmlText = param1["body"];
         this.textInfo.height = this.textInfo.textHeight + TEXT_PADDING;
         this.textInfo.scaleX = 1;
         this.textInfo.scaleY = 1;
         this.submitButton.y = Math.round(this.textInfo.y + this.textInfo.height + BUTTON_PADDING);
         this.cancelButton.y = this.submitButton.y;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         Window(window).visible = false;
         showWindowBgForm = true;
         window.useBottomBtns = true;
         this.submitButton.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
         App.utils.scheduler.scheduleOnNextFrame(this.updateWindowSize);
      }
      
      private function updateWindowSize() : void
      {
         var _loc1_:int = this.submitButton.y + this.submitButton.height;
         _loc1_ = _loc1_ + window.contentPadding.top + window.contentPadding.bottom;
         window.updateSize(window.width,_loc1_,false);
         window.validateNow();
         DisplayObject(window).visible = true;
         IEventDispatcher(window).addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         App.utils.scheduler.scheduleOnNextFrame(this.setFocusToSubmitButton);
      }
      
      private function focusInHandler(param1:FocusEvent) : void
      {
         App.utils.scheduler.scheduleOnNextFrame(this.setFocusToSubmitButton);
      }
      
      private function setFocusToSubmitButton() : void
      {
         setFocus(this.submitButton);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.updateWindowSize);
         App.utils.scheduler.cancelTask(this.setFocusToSubmitButton);
         IEventDispatcher(window).removeEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         this.submitButton.removeEventListener(ButtonEvent.CLICK,this.onClickSubmitButton);
         this.cancelButton.dispose();
         this.submitButton.dispose();
         super.onDispose();
      }
      
      private function onClickSubmitButton(param1:ButtonEvent) : void
      {
         onSubmitButtonS();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN)
         {
            param1.preventDefault();
            param1.handled = true;
            onCancelButtonS();
            return;
         }
         super.handleInput(param1);
      }
   }
}
