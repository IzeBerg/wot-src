package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.inblocks.data.AbilityBattleRankItemVO;
   
   public class AbilityBattleRankItemBlock extends BaseTooltipBlock
   {
       
      
      public var titleTf:TextField = null;
      
      public var lowTf:TextField = null;
      
      public var avTf:TextField = null;
      
      public var highTf:TextField = null;
      
      private var _blockData:AbilityBattleRankItemVO;
      
      private var _isDataApplied:Boolean = false;
      
      public function AbilityBattleRankItemBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.titleTf.htmlText = this.lowTf.htmlText = this.avTf.htmlText = this.highTf.htmlText = Values.EMPTY_STR;
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._blockData = new AbilityBattleRankItemVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.cleanUp();
         this.titleTf = null;
         this.lowTf = null;
         this.avTf = null;
         this.highTf = null;
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
      
      public function applyData() : void
      {
         this.titleTf.text = this._blockData.abilityName;
         App.utils.commons.updateTextFieldSize(this.titleTf,false,true);
         this.lowTf.htmlText = this._blockData.getItemAt(0);
         this.avTf.htmlText = this._blockData.getItemAt(1);
         this.highTf.htmlText = this._blockData.getItemAt(2);
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._blockData != null)
         {
            this._blockData.dispose();
            this._blockData = null;
         }
      }
   }
}
