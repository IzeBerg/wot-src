package net.wg.gui.messenger.windows
{
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Errors;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.messenger.meta.IChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.ChannelWindowMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class ChannelWindow extends ChannelWindowMeta implements IChannelWindowMeta
   {
       
      
      public var channelComponent:ChannelComponent;
      
      private const CONTENT_PADDING:Padding = new Padding(40,12,16,9);
      
      public function ChannelWindow()
      {
         super();
         showWindowBgForm = false;
         canMinimize = true;
         canResize = true;
      }
      
      override public function getClientItemID() : Number
      {
         return getClientIDS();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("messageArea",this.channelComponent.messageArea,Constraints.ALL);
         constraints.addElement("messageInput",this.channelComponent.messageInput,Constraints.LEFT | Constraints.RIGHT | Constraints.BOTTOM);
         var _loc1_:DisplayObject = this.channelComponent.sendButton as DisplayObject;
         App.utils.asserter.assertNotNull(_loc1_,"displObject" + Errors.CANT_NULL);
         constraints.addElement("sendButton",_loc1_,Constraints.RIGHT | Constraints.BOTTOM);
         this.channelComponent.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.channelComponent,Aliases.CHANNEL_COMPONENT);
         window.contentPadding = this.CONTENT_PADDING;
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }
      
      override protected function onDispose() : void
      {
         this.channelComponent.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
         this.channelComponent = null;
         super.onDispose();
      }
      
      public function as_setCloseEnabled(param1:Boolean) : void
      {
         enabledCloseBtn = param1;
      }
      
      public function as_setTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
         {
            param1.handled = true;
            showFAQWindowS();
         }
         if(canCloseFromInputDetails(_loc2_))
         {
            param1.handled = true;
            onWindowMinimizeS();
         }
         super.handleInput(param1);
      }
      
      private function onRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(this.channelComponent.getComponentForFocus());
      }
   }
}
