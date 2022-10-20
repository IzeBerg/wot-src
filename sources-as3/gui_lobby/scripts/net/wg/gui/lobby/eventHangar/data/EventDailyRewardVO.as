package net.wg.gui.lobby.eventHangar.data
{
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class EventDailyRewardVO extends ToolTipVO
   {
       
      
      public var icon:String = "";
      
      public var phaseIndex:int = -1;
      
      public var rewardReady:Boolean = false;
      
      public function EventDailyRewardVO(param1:Object)
      {
         super(param1);
      }
   }
}
