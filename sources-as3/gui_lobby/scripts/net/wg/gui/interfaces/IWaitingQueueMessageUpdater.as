package net.wg.gui.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.data.WaitingQueueCounterMessageVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IWaitingQueueMessageUpdater extends IEventDispatcher, IDisposable
   {
       
      
      function updateData(param1:WaitingQueueCounterMessageVO) : void;
   }
}
