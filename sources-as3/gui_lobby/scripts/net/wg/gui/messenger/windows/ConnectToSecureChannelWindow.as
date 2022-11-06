package net.wg.gui.messenger.windows
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   public class ConnectToSecureChannelWindow extends ConnectToSecureChannelWindowMeta implements IConnectToSecureChannelWindowMeta
   {
      
      private static const UPDATE_COMPONENTS:String = "update_components";
       
      
      public var titleLabel:TextField;
      
      public var channelInfoLabel:TextField;
      
      public var passwordLabel:TextField;
      
      public var passwordInput:TextInput;
      
      public var connectButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      private var _updated:Boolean = true;
      
      private var _channelInfoText:String = "";
      
      private var _toolTip:String = "";
      
      private var _showToolTip:Boolean = false;
      
      public function ConnectToSecureChannelWindow()
      {
         super();
      }
      
      public function as_infoMessage(param1:String) : void
      {
         this._channelInfoText = param1;
         this._updated = false;
         invalidate(UPDATE_COMPONENTS);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         showWindowBgForm = false;
         window.useBottomBtns = true;
         window.title = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_TITLE;
         var _loc1_:Padding = window.contentPadding as Padding;
         App.utils.asserter.assertNotNull(_loc1_,"windowPadding" + Errors.CANT_NULL);
         _loc1_.top = 41;
         _loc1_.left = 11;
         _loc1_.right = 8;
         _loc1_.bottom = 18;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_COMPONENTS) && !this._updated)
         {
            this._updated = true;
            this.updateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.connectButton.addEventListener(ButtonEvent.CLICK,this.onConnectButtonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.titleLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_WARRNING;
         this.passwordLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_PASSWORD;
         this.passwordLabel.selectable = false;
         this.passwordLabel.mouseEnabled = false;
         this.passwordInput.addEventListener(InputEvent.INPUT,this.onPasswordInputInputHandler);
         this.channelInfoLabel.addEventListener(MouseEvent.ROLL_OVER,this.onChannelInfoLabelRollOverHandler);
         this.channelInfoLabel.addEventListener(MouseEvent.ROLL_OUT,this.onChannelInfoLabelRollOutHandler);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.passwordInput);
      }
      
      override protected function onDispose() : void
      {
         this.connectButton.removeEventListener(ButtonEvent.CLICK,this.onConnectButtonClickHandler);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.channelInfoLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onChannelInfoLabelRollOverHandler);
         this.channelInfoLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onChannelInfoLabelRollOutHandler);
         this.passwordInput.removeEventListener(InputEvent.INPUT,this.onPasswordInputInputHandler);
         this.titleLabel = null;
         this.channelInfoLabel = null;
         this.passwordLabel = null;
         this.passwordInput = null;
         this.connectButton.dispose();
         this.connectButton = null;
         this.cancelButton.dispose();
         this.cancelButton = null;
         super.onDispose();
      }
      
      private function onConnectButtonClickHandler(param1:ButtonEvent) : void
      {
         sendPasswordS(this.passwordInput.text);
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         cancelPasswordS();
      }
      
      private function onPasswordInputInputHandler(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ENTER && _loc2_.value == InputValue.KEY_UP)
         {
            param1.handled = true;
            sendPasswordS(this.passwordInput.text);
         }
      }
      
      private function updateData() : void
      {
         this._toolTip = this._channelInfoText;
         this._showToolTip = this._channelInfoText != App.utils.commons.truncateTextFieldText(this.channelInfoLabel,this._channelInfoText,false);
      }
      
      private function onChannelInfoLabelRollOverHandler(param1:MouseEvent) : void
      {
         if(this._showToolTip)
         {
            App.toolTipMgr.show(this._toolTip);
         }
      }
      
      private function onChannelInfoLabelRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
