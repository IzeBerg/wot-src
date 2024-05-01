package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.gui.lobby.eventProgression.components.metaLevel.BaseMetaLevel;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class EpicMetaLevelIconBlock extends BaseTooltipBlock
   {
      
      private static const IMAGE_SIZE:int = 130;
       
      
      public var metaLevel:BaseMetaLevel = null;
      
      private var _data:MetaLevelVO = null;
      
      private var _isDataApplied:Boolean = false;
      
      public function EpicMetaLevelIconBlock()
      {
         super();
      }
      
      override public function getHeight() : Number
      {
         return IMAGE_SIZE;
      }
      
      override public function getWidth() : Number
      {
         return IMAGE_SIZE;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new MetaLevelVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.metaLevel.dispose();
         this.metaLevel = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         return false;
      }
      
      private function applyData() : void
      {
         this.metaLevel.setIconSize(BaseMetaLevel.EXTRA_SMALL);
         this.metaLevel.setData(this._data);
         this._isDataApplied = true;
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
