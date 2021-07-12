package net.wg.gui.tutorial.windows
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.waitingQueue.WaitingQueueMessageHelper;
   import net.wg.gui.components.waitingQueue.WaitingQueueMessageUpdater;
   import net.wg.gui.events.WaitingQueueMessageEvent;
   import net.wg.gui.interfaces.IWaitingQueueMessageUpdater;
   import net.wg.gui.tutorial.data.TutorialDialogVO;
   
   public class TutorialQueueDialog extends TutorialDialog
   {
      
      private static const INVALIDATE_MESSAGE:String = "invalidateMessage";
       
      
      public var titleField:TextField;
      
      private var _messageText:String;
      
      private var _waitingQueueMessageUpdater:IWaitingQueueMessageUpdater;
      
      private var _messageEnd:String;
      
      private var _messageStart:String;
      
      private var _counterText:String;
      
      public function TutorialQueueDialog()
      {
         super();
         showWindowBgForm = false;
         showWindowBg = false;
         this._waitingQueueMessageUpdater = new WaitingQueueMessageUpdater(WaitingQueueMessageHelper.instance);
         this._waitingQueueMessageUpdater.addEventListener(WaitingQueueMessageEvent.UPDATE_MESSAGE,this.onWaitingQueueUpdateMessageHandler);
      }
      
      override protected function setContent(param1:TutorialDialogVO) : void
      {
         super.setContent(param1);
         this._messageStart = param1.message + param1.playerTimeTextStart;
         this._messageEnd = param1.playerTimeTextEnd + param1.avgTimeText;
         this._waitingQueueMessageUpdater.updateData(param1);
      }
      
      override protected function updateContent(param1:TutorialDialogVO) : void
      {
         this._messageEnd = param1.avgTimeText + _data.playerTimeTextEnd;
         this.updateMessageText();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(submitBtn);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_MESSAGE))
         {
            messageField.htmlText = this._messageText;
         }
      }
      
      override protected function drawData() : void
      {
         this.titleField.text = _data.title;
      }
      
      override protected function onDispose() : void
      {
         this.titleField = null;
         this._waitingQueueMessageUpdater.removeEventListener(WaitingQueueMessageEvent.UPDATE_MESSAGE,this.onWaitingQueueUpdateMessageHandler);
         this._waitingQueueMessageUpdater.dispose();
         this._waitingQueueMessageUpdater = null;
         super.onDispose();
      }
      
      private function updateMessageText() : void
      {
         this._messageText = this._messageStart + this._counterText + this._messageEnd;
         invalidate(INVALIDATE_MESSAGE);
      }
      
      private function onWaitingQueueUpdateMessageHandler(param1:WaitingQueueMessageEvent) : void
      {
         this._counterText = param1.message;
         this.updateMessageText();
      }
   }
}
