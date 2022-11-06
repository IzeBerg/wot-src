package net.wg.gui.messenger.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.messenger.data.ContactsShared;
   import net.wg.gui.messenger.data.ContactsViewInitDataVO;
   import net.wg.gui.messenger.data.ExtContactsViewInitVO;
   import net.wg.gui.messenger.meta.IBaseManageContactViewMeta;
   import net.wg.gui.messenger.meta.impl.BaseManageContactViewMeta;
   import scaleform.clik.events.FocusHandlerEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class BaseManageContactView extends BaseManageContactViewMeta implements IBaseManageContactViewMeta
   {
      
      private static const TXT_INV:String = "txtInv";
       
      
      public var txtLabel:TextField;
      
      public var input:TextInput;
      
      private var inputText:String;
      
      private var defValue:String;
      
      private var inputToolTip:String;
      
      public function BaseManageContactView()
      {
         super();
      }
      
      private static function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this.input;
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.input].concat(super.getFocusChain());
      }
      
      override public function update(param1:Object) : void
      {
         super.update(param1);
         if(param1 && param1.hasOwnProperty("text"))
         {
            this.as_setInputText(param1.text);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.input.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.input.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         this.input.addEventListener(Event.CHANGE,this.onTextChangeHandler,false,0,true);
         this.input.addEventListener(FocusHandlerEvent.FOCUS_IN,this.onTxtInpFocusInHandler,false,0,true);
         this.input.addEventListener(InputEvent.INPUT,this.onInputInputHandler,false,0,true);
         this.input.defaultTextFormat.color = ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR;
         this.input.textField.textColor = ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR;
         this.input.defaultTextFormat.italic = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(TXT_INV) && this.inputText != null)
         {
            checkTextS(this.inputText);
         }
      }
      
      override protected function onDispose() : void
      {
         this.input.removeEventListener(Event.CHANGE,this.onTextChangeHandler);
         this.input.removeEventListener(FocusHandlerEvent.FOCUS_IN,this.onTxtInpFocusInHandler);
         this.input.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.input.removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         this.input.removeEventListener(InputEvent.INPUT,this.onInputInputHandler);
         this.input.dispose();
         this.input = null;
         this.txtLabel = null;
         super.onDispose();
      }
      
      override protected function applyInitData(param1:ContactsViewInitDataVO) : void
      {
         super.applyInitData(param1);
         var _loc2_:ExtContactsViewInitVO = ExtContactsViewInitVO(param1);
         this.input.defaultText = _loc2_.inputPrompt;
         this.input.maxChars = _loc2_.groupMaxChars;
         this.inputToolTip = _loc2_.inputTooltip;
      }
      
      override protected function getContactsViewInitDataVOForData(param1:Object) : ContactsViewInitDataVO
      {
         return new ExtContactsViewInitVO(param1);
      }
      
      override protected function onButtonClick() : void
      {
         onOkS({
            "defValue":this.defValue,
            "currValue":this.input.text
         });
      }
      
      public function as_setInputText(param1:String) : void
      {
         if(param1)
         {
            if(param1 != this.inputText)
            {
               this.defValue = this.inputText = param1;
               this.input.text = this.inputText;
               invalidate(TXT_INV);
            }
         }
      }
      
      public function as_setLabel(param1:String) : void
      {
         this.txtLabel.text = param1;
      }
      
      private function onTxtInpFocusInHandler(param1:FocusHandlerEvent) : void
      {
         this.input.textField.textColor = ContactsShared.INVITE_INPUT_TEXT_COLOR;
      }
      
      private function onTextChangeHandler(param1:Event) : void
      {
         if(this.inputText != this.input.text)
         {
            this.inputText = this.input.text;
            invalidate(TXT_INV);
         }
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this.inputToolTip)
         {
            App.toolTipMgr.show(this.inputToolTip);
         }
      }
      
      private function onInputInputHandler(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ENTER && btns.btnOk.enabled && visible)
         {
            param1.handled = true;
            this.onButtonClick();
         }
      }
   }
}
