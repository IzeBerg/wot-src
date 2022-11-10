package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.display.MovieClip;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   import net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.data.VotesForDiscountBlockVO;
   
   public class VotesForDiscountBlock extends BaseTooltipBlock
   {
       
      
      public var votesForDiscountProgress:MovieClip = null;
      
      private var _data:VotesForDiscountBlockVO = null;
      
      public function VotesForDiscountBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new VotesForDiscountBlockVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.votesForDiscountProgress.stop();
         this.votesForDiscountProgress = null;
         super.onDispose();
      }
      
      override protected function onInvalidateBlock() : void
      {
         if(this._data)
         {
            this.votesForDiscountProgress.gotoAndStop(this._data.progress + 1);
         }
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
