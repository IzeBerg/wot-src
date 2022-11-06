package net.wg.gui.components.tooltips.inblocks.interfaces
{
   public interface ITooltipBlocks extends ITooltipBlock
   {
       
      
      function get blocks() : Vector.<ITooltipBlock>;
      
      function get data() : ITootipBlocksData;
   }
}
