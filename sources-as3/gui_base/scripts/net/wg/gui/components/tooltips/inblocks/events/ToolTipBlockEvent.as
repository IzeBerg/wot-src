package net.wg.gui.components.tooltips.inblocks.events
{
   import flash.events.Event;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   
   public class ToolTipBlockEvent extends Event
   {
      
      public static const SIZE_CHANGE:String = "ttBlockSizeChange";
       
      
      private var _block:ITooltipBlock;
      
      public function ToolTipBlockEvent(param1:String, param2:ITooltipBlock, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._block = param2;
      }
      
      public function get block() : ITooltipBlock
      {
         return this._block;
      }
   }
}
