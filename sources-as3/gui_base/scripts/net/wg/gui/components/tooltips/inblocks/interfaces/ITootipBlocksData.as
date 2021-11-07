package net.wg.gui.components.tooltips.inblocks.interfaces
{
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   
   public interface ITootipBlocksData
   {
       
      
      function get blocks() : Vector.<BlockDataItemVO>;
      
      function get layoutGap() : int;
      
      function get layoutAlign() : String;
      
      function get stretchLastElement() : Boolean;
   }
}
