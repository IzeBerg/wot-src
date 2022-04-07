package net.wg.gui.interfaces
{
   import net.wg.gui.data.WaitingPointcutsVO;
   
   public interface IWaitingQueueMessageHelper
   {
       
      
      function getTimeText(param1:uint, param2:WaitingPointcutsVO) : String;
      
      function needTimeCounting(param1:uint, param2:WaitingPointcutsVO) : Boolean;
   }
}
