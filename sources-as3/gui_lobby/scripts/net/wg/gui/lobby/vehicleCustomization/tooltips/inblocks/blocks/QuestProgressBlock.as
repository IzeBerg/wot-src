package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   import net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.data.QuestProgressBlockVO;
   
   public class QuestProgressBlock extends BaseTooltipBlock
   {
      
      private static const PROGRESS_MAX:int = 100;
      
      private static const ORANGE:int = 16761699;
      
      private static const PERCENT:String = "%";
       
      
      public var progressBar:QuestProgressBar = null;
      
      public var tfLabel:TextField = null;
      
      private var _data:QuestProgressBlockVO;
      
      private var _progressData:ProgressBarAnimVO;
      
      public function QuestProgressBlock()
      {
         super();
         this._progressData = new ProgressBarAnimVO(null);
         this._progressData.minValue = 0;
         this._progressData.maxValue = PROGRESS_MAX;
         this._progressData.useAnim = true;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new QuestProgressBlockVO(param1);
         this._progressData.value = this._data.progress;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.progressBar.dispose();
         this.progressBar = null;
         this.tfLabel = null;
         this._progressData.dispose();
         this._progressData = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function onInvalidateBlock() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:TextFormat = null;
         if(this._data)
         {
            this.progressBar.setData(this._progressData);
            this.progressBar.value = this._data.progress;
            _loc1_ = App.utils.locale.makeString(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_TOOLTIP_QUESTS_PROGRESSBIG);
            this.tfLabel.text = _loc1_ + this._data.progress + PERCENT;
            _loc2_ = _loc1_.length;
            _loc3_ = this.tfLabel.getTextFormat();
            _loc3_.color = ORANGE;
            this.tfLabel.setTextFormat(_loc3_,_loc2_);
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
