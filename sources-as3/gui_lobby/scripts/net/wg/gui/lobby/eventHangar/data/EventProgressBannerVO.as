package net.wg.gui.lobby.eventHangar.data
{
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class EventProgressBannerVO extends ToolTipVO
   {
       
      
      public var info:String = "";
      
      public var status:String = "";
      
      public var banMessage:String = "";
      
      public var isDailiesRemoved:Boolean = false;
      
      public function EventProgressBannerVO(param1:Object)
      {
         super(param1);
      }
   }
}
