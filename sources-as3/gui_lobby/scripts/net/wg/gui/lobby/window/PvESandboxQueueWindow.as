package net.wg.gui.lobby.window
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.waitingQueue.WaitingQueueMessageHelper;
   import net.wg.gui.components.waitingQueue.WaitingQueueMessageUpdater;
   import net.wg.gui.data.WaitingQueueWindowVO;
   import net.wg.gui.events.WaitingQueueMessageEvent;
   import net.wg.gui.interfaces.IWaitingQueueMessageUpdater;
   import net.wg.infrastructure.base.meta.IPvESandboxQueueWindowMeta;
   import net.wg.infrastructure.base.meta.impl.PvESandboxQueueWindowMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class PvESandboxQueueWindow extends PvESandboxQueueWindowMeta implements IPvESandboxQueueWindowMeta
   {
      
      private static const TEXT_FIELDS_GAP:int = 10;
       
      
      public var messageField:TextField;
      
      public var counterField:TextField;
      
      public var cancelBtn:SoundButtonEx;
      
      public var titleField:TextField;
      
      private var _waitingQueueMessageUpdater:IWaitingQueueMessageUpdater;
      
      private var _data:WaitingQueueWindowVO;
      
      public function PvESandboxQueueWindow()
      {
         super();
         showWindowBgForm = false;
         showWindowBg = false;
         this._waitingQueueMessageUpdater = new WaitingQueueMessageUpdater(WaitingQueueMessageHelper.instance);
         this._waitingQueueMessageUpdater.addEventListener(WaitingQueueMessageEvent.UPDATE_MESSAGE,this.onWaitingQueueUpdateMessageHandler);
         this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelButtonPressHandler);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.cancelBtn);
      }
      
      override protected function setData(param1:WaitingQueueWindowVO) : void
      {
         this._data = param1;
         this.titleField.htmlText = this._data.title;
         this.messageField.htmlText = this._data.message;
         App.utils.commons.updateTextFieldSize(this.messageField,false,true);
         this.counterField.y = this.messageField.y + this.messageField.height + TEXT_FIELDS_GAP | 0;
         this._waitingQueueMessageUpdater.updateData(this._data);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelButtonPressHandler);
         this._waitingQueueMessageUpdater.removeEventListener(WaitingQueueMessageEvent.UPDATE_MESSAGE,this.onWaitingQueueUpdateMessageHandler);
         this._waitingQueueMessageUpdater.dispose();
         this._waitingQueueMessageUpdater = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.messageField = null;
         this.titleField = null;
         this.counterField = null;
         super.onDispose();
      }
      
      private function onCancelButtonPressHandler(param1:ButtonEvent) : void
      {
         cancelS();
      }
      
      private function onWaitingQueueUpdateMessageHandler(param1:WaitingQueueMessageEvent) : void
      {
         this.counterField.htmlText = this._data.playerTimeTextStart + param1.message + this._data.playerTimeTextEnd;
      }
   }
}
