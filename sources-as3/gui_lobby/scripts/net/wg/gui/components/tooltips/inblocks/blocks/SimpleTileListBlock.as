package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.tooltips.inblocks.data.SimpleTileListBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import scaleform.clik.constants.DirectionMode;
   
   public class SimpleTileListBlock extends BaseTooltipBlock
   {
       
      
      public var listImg:SimpleTileList = null;
      
      private var _data:SimpleTileListBlockVO = null;
      
      public function SimpleTileListBlock()
      {
         super();
         this.listImg.directionMode = DirectionMode.HORIZONTAL;
      }
      
      override public function getHeight() : Number
      {
         return Boolean(this.listImg) ? Number(this.listImg.height) : Number(height);
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new SimpleTileListBlockVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.listImg.width = param1 - this.listImg.x;
         }
      }
      
      override protected function onDispose() : void
      {
         this.listImg.dispose();
         this.listImg = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      private function applyData() : void
      {
         this.listImg.itemRenderer = App.utils.classFactory.getClass(this._data.rendererType);
         this.listImg.tileWidth = this._data.columnWidth;
         this.listImg.tileHeight = this._data.rowHeight;
         this.listImg.horizontalGap = this._data.horizontalGap;
         this.listImg.verticalGap = this._data.verticalGap;
         this.listImg.dataProvider = this._data.iconSrcDP;
         this.listImg.renderersAlign = this._data.renderersAlign;
         this.listImg.validateNow();
         invalidateBlock();
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
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
