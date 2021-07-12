package net.wg.gui.components.waitingQueue
{
   import flash.events.EventDispatcher;
   import net.wg.gui.data.WaitingPointcutsVO;
   import net.wg.gui.data.WaitingQueueCounterMessageVO;
   import net.wg.gui.events.WaitingQueueMessageEvent;
   import net.wg.gui.interfaces.IWaitingQueueMessageHelper;
   import net.wg.gui.interfaces.IWaitingQueueMessageUpdater;
   
   public class WaitingQueueMessageUpdater extends EventDispatcher implements IWaitingQueueMessageUpdater
   {
       
      
      private var _waitingTime:uint = 0;
      
      private var _timePointcuts:WaitingPointcutsVO;
      
      private var _updatePeriod:int;
      
      private var _helper:IWaitingQueueMessageHelper;
      
      public function WaitingQueueMessageUpdater(param1:IWaitingQueueMessageHelper)
      {
         super();
         this._helper = param1;
      }
      
      public function dispose() : void
      {
         this._helper = null;
         this._timePointcuts = null;
         App.utils.scheduler.cancelTask(this.updateWaitingTime);
      }
      
      public function updateData(param1:WaitingQueueCounterMessageVO) : void
      {
         this._updatePeriod = param1.updatePeriod * 1000;
         App.utils.asserter.assert(this._updatePeriod > 0,"updatePeriod must be > 0");
         this._timePointcuts = param1.timePointcuts;
         this.updateMessageText();
         if(this._helper.needTimeCounting(this._waitingTime,this._timePointcuts))
         {
            App.utils.scheduler.scheduleTask(this.updateWaitingTime,this._updatePeriod);
         }
      }
      
      private function updateWaitingTime() : void
      {
         ++this._waitingTime;
         this.updateMessageText();
         if(this._helper.needTimeCounting(this._waitingTime,this._timePointcuts))
         {
            App.utils.scheduler.scheduleTask(this.updateWaitingTime,this._updatePeriod);
         }
      }
      
      private function updateMessageText() : void
      {
         var _loc1_:String = this._helper.getTimeText(this._waitingTime,this._timePointcuts);
         dispatchEvent(new WaitingQueueMessageEvent(WaitingQueueMessageEvent.UPDATE_MESSAGE,_loc1_));
      }
   }
}
