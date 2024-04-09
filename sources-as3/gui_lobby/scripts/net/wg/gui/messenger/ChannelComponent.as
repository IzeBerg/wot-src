package net.wg.gui.messenger
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.messenger.meta.impl.ChannelComponentMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.TextFieldEx;
   
   public class ChannelComponent extends ChannelComponentMeta implements IChannelComponent
   {
      
      private static const INVALIDATE_CONTROLS:String = "invalidateControls";
      
      private static const INVALIDATE_HISTORY:String = "invalidateHistory";
      
      private static const MESSAGE_INPUT_MARGIN_TOP:int = 1;
       
      
      public var messageAreaScrollBar:ScrollBar = null;
      
      public var messageArea:TextAreaSimple = null;
      
      public var messageInput:TextInput = null;
      
      public var sendButton:ISoundButtonEx = null;
      
      private var _isJoined:Boolean = false;
      
      private var _needDispose:Boolean = true;
      
      private var _isPopulated:Boolean = false;
      
      private var _isConfigured:Boolean = false;
      
      private var _externalHintTF:TextField = null;
      
      private var _startHeight:Number;
      
      private var _isReturnToNormalScale:Boolean = false;
      
      public function ChannelComponent()
      {
         super();
         this._startHeight = _height;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.messageInput.maxChars = getMessageMaxLengthS();
         this._isJoined = isJoinedS();
         invalidate(INVALIDATE_CONTROLS);
         if(this._isJoined)
         {
            invalidate(INVALIDATE_HISTORY);
         }
         _deferredDispose = true;
         this._isPopulated = true;
         this.setFocusToInput();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:SmileyMap = new SmileyMap();
         this.sendButton.addEventListener(ButtonEvent.CLICK,this.onSendButtonClickHandler,false,0,true);
         this.messageInput.addEventListener(InputEvent.INPUT,this.onMessageInputHandler);
         this.messageArea.addEventListener(TextEvent.LINK,this.onMessageAreaLinkHandler);
         this.messageArea.autoScroll = true;
         this.messageArea.htmlText = Values.EMPTY_STR;
         this.messageArea.editable = false;
         this.messageArea.selectable = true;
         this.messageArea.textField.selectable = true;
         TextFieldEx.setNoTranslate(this.messageArea.textField,true);
         _loc1_.mapText(this.messageArea.textField);
         this.sendButton.soundType = SoundTypes.NORMAL_BTN;
         this._isConfigured = true;
         this.setFocusToInput();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this._needDispose)
         {
            this.sendButton.dispose();
         }
         this.sendButton.removeEventListener(ButtonEvent.CLICK,this.onSendButtonClickHandler);
         this.messageInput.removeEventListener(InputEvent.INPUT,this.onMessageInputHandler);
         this.messageInput.dispose();
         this.messageArea.removeEventListener(TextEvent.LINK,this.onMessageAreaLinkHandler);
         this.messageArea.dispose();
         if(this.messageAreaScrollBar)
         {
            this.messageAreaScrollBar.dispose();
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._needDispose)
         {
            this.sendButton = null;
         }
         this.messageInput = null;
         this.messageArea = null;
         if(this.messageAreaScrollBar)
         {
            this.messageAreaScrollBar = null;
         }
         this._externalHintTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_CONTROLS))
         {
            this.enableControls(this._isJoined);
         }
         if(this._isJoined && isInvalid(INVALIDATE_HISTORY))
         {
            this.setHistory();
         }
         if(this._isReturnToNormalScale && isInvalid(InvalidationType.SIZE))
         {
            this.messageArea.height = this._startHeight - this.messageInput.height - MESSAGE_INPUT_MARGIN_TOP | 0;
            this.messageInput.y = this.messageArea.height + MESSAGE_INPUT_MARGIN_TOP | 0;
         }
      }
      
      public function as_addMessage(param1:String) : void
      {
         if(param1 != Values.EMPTY_STR && param1 != null)
         {
            this.messageArea.appendHtmlResetPosition(param1 + Values.NEW_LINE);
            this.hideExternalTF();
            if(this.messageArea.textField.scrollV < this.messageArea.textField.maxScrollV)
            {
               this.messageArea.safePosition = true;
            }
         }
      }
      
      public function as_setJoined(param1:Boolean) : void
      {
         this._isJoined = param1;
         this.enableControls(this._isJoined);
         if(this._isJoined)
         {
            this.setHistory();
         }
      }
      
      public function as_getLastUnsentMessage() : String
      {
         return this.messageInput.text;
      }
      
      public function as_setLastUnsentMessage(param1:String) : void
      {
         this.messageInput.text = param1;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.messageInput;
      }
      
      public function setChannelHeight(param1:int) : void
      {
         this._startHeight = height = param1;
      }
      
      private function hideExternalTF() : void
      {
         if(this._externalHintTF && this._externalHintTF.visible)
         {
            this._externalHintTF.visible = false;
         }
      }
      
      private function setFocusToInput() : void
      {
         if(initialized && this._isJoined && this._isPopulated && this._isConfigured)
         {
            this.updateFocus();
         }
      }
      
      private function updateFocus() : void
      {
         if(this.messageInput != null && this.messageInput.enabled && this.messageInput.focused == 0)
         {
            this.messageInput.validateNow();
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         }
      }
      
      private function enableControls(param1:Boolean) : void
      {
         this.messageInput.enabled = param1;
         this.sendButton.enabled = param1;
      }
      
      private function doMessage() : void
      {
         if(this.messageInput.text != Values.EMPTY_STR && this.messageInput.text != null)
         {
            if(sendMessageS(this.messageInput.text))
            {
               this.messageInput.text = Values.EMPTY_STR;
            }
         }
      }
      
      private function setHistory() : void
      {
         var _loc1_:String = getHistoryS();
         if(_loc1_ != null && _loc1_ != Values.EMPTY_STR)
         {
            this.messageArea.htmlText = _loc1_ + Values.NEW_LINE;
            this.hideExternalTF();
         }
         else
         {
            this.messageArea.htmlText = Values.EMPTY_STR;
         }
         this.updateFocus();
      }
      
      public function get externalHintTF() : TextField
      {
         return this._externalHintTF;
      }
      
      public function set externalHintTF(param1:TextField) : void
      {
         if(this._externalHintTF == param1)
         {
            return;
         }
         this._externalHintTF = param1;
      }
      
      public function set externalButton(param1:ISoundButtonEx) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._needDispose = false;
         this.sendButton = param1;
      }
      
      public function get isReturnToNormalScale() : Boolean
      {
         return this._isReturnToNormalScale;
      }
      
      public function set isReturnToNormalScale(param1:Boolean) : void
      {
         if(this._isReturnToNormalScale != param1)
         {
            this._isReturnToNormalScale = param1;
            scaleY = 1;
         }
      }
      
      private function onSendButtonClickHandler(param1:ButtonEvent) : void
      {
         this.doMessage();
         this.setFocusToInput();
      }
      
      private function onMessageInputHandler(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(param1.details.code == Keyboard.ENTER && _loc2_.value == InputValue.KEY_UP)
         {
            param1.handled = true;
            this.doMessage();
         }
      }
      
      private function onMessageAreaLinkHandler(param1:TextEvent) : void
      {
         onLinkClickS(param1.text);
      }
      
      public function as_notifyInfoChanged() : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
