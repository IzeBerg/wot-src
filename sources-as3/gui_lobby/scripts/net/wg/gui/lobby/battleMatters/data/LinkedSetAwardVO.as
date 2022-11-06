package net.wg.gui.lobby.battleMatters.data
{
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class LinkedSetAwardVO extends ToolTipVO
   {
       
      
      public var icon:String = "";
      
      public var value:String = "";
      
      public var isCompleted:Boolean = false;
      
      public var alpha:Number = 1.0;
      
      public function LinkedSetAwardVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
