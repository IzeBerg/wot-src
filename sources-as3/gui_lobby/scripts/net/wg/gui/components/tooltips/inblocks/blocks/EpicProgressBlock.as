package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.lobby.epicBattles.components.common.EpicProgressBar;
   
   public class EpicProgressBlock extends BaseTooltipBlock
   {
       
      
      public var progressBar:EpicProgressBar = null;
      
      private var _data:DAAPIDataClass = null;
      
      private var _isDataApplied:Boolean = false;
      
      public function EpicProgressBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         this.clearData();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = this.createData(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      protected function createData(param1:Object) : DAAPIDataClass
      {
         return new ProgressBarAnimVO(param1);
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this.progressBar.width = param1;
      }
      
      override public function getWidth() : Number
      {
         return this.progressBar.width;
      }
      
      override public function getHeight() : Number
      {
         return this.progressBar.height;
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
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.progressBar.dispose();
         this.progressBar = null;
         super.onDispose();
      }
      
      private function applyData() : void
      {
         this.progressBar.setData(this.progressData);
         this._isDataApplied = true;
      }
      
      protected function get data() : Object
      {
         return this._data;
      }
      
      protected function get progressData() : ProgressBarAnimVO
      {
         return ProgressBarAnimVO(this._data);
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
