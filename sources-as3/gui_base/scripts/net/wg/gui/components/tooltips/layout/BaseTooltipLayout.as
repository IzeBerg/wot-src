package net.wg.gui.components.tooltips.layout
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlocks;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseTooltipLayout
   {
       
      
      protected var _expectedWidth:int = 0;
      
      protected var _measuredWidth:int;
      
      protected var _measuredHeight:int;
      
      public function BaseTooltipLayout()
      {
         super();
      }
      
      public function setExpectedWidth(param1:int) : void
      {
         this._expectedWidth = param1;
      }
      
      public function measureBlock(param1:ITooltipBlock, param2:BlockDataItemVO) : void
      {
         throw new AbstractException("BaseTooltipLayout.measureBlock" + Errors.ABSTRACT_INVOKE);
      }
      
      public function arrange(param1:ITooltipBlocks) : void
      {
         throw new AbstractException("BaseTooltipLayout.rearrange" + Errors.ABSTRACT_INVOKE);
      }
      
      public function get layoutWidth() : int
      {
         return this._expectedWidth > 0 ? int(this._expectedWidth) : int(this._measuredWidth);
      }
      
      public function get layoutHeight() : int
      {
         return this._measuredHeight;
      }
      
      public function cleanUp() : void
      {
         this._expectedWidth = 0;
         this._measuredWidth = 0;
         this._measuredHeight = 0;
      }
   }
}
