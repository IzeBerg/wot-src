package net.wg.gui.components.tooltips.finstats
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.finalStats.HeadBlockData;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   
   public class HeadBlock extends BaseTooltipBlock
   {
       
      
      public var titleTF:TextField;
      
      public var icon:UILoaderAlt;
      
      private var _data:HeadBlockData;
      
      public function HeadBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.icon.unload();
         this.clearData();
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new HeadBlockData(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.titleTF.width = param1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.titleTF = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function applyData() : void
      {
         this.titleTF.multiline = true;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.htmlText = this._data.title;
         this.icon.source = this._data.icon;
      }
   }
}
