package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   
   public class QuestOrConditionBlock extends BaseTooltipBlock
   {
      
      private static const LINE_MARGIN:int = 10;
      
      private static const ARROW_MARGIN:int = 7;
       
      
      public var lineLeft:Sprite = null;
      
      public var lineRight:Sprite = null;
      
      public var arrowLeft:Sprite = null;
      
      public var arrowRight:Sprite = null;
      
      public var tfLabel:TextField = null;
      
      private var _blockWidth:int = 0;
      
      public function QuestOrConditionBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override public function getWidth() : Number
      {
         return this._blockWidth > 0 ? Number(this._blockWidth) : Number(super.getWidth());
      }
      
      override protected function onInvalidateBlock() : void
      {
         var _loc1_:String = App.utils.locale.makeString(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_TOOLTIP_QUESTS_OR);
         this.tfLabel.text = _loc1_;
         App.utils.commons.updateTextFieldSize(this.tfLabel);
         var _loc2_:int = this._blockWidth - this.tfLabel.width - (LINE_MARGIN + ARROW_MARGIN << 1) >> 1;
         this.lineLeft.width = this.lineRight.width = _loc2_;
         this.lineLeft.x = this.lineLeft.width;
         this.arrowLeft.x = this.lineLeft.x + LINE_MARGIN;
         this.tfLabel.x = this.arrowLeft.x + ARROW_MARGIN;
         this.arrowRight.x = this.tfLabel.x + this.tfLabel.width + ARROW_MARGIN;
         this.lineRight.x = this.arrowRight.x + LINE_MARGIN;
      }
      
      override protected function onDispose() : void
      {
         this.lineLeft = null;
         this.lineRight = null;
         this.arrowLeft = null;
         this.arrowRight = null;
         this.tfLabel = null;
         super.onDispose();
      }
   }
}
