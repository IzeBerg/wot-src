package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.tooltips.inblocks.data.ActionTextParameterBlockVO;
   
   public class ActionTextParameterBlock extends AbstractTextParameterBlock
   {
      
      private static const STATE_ALIGNED_TOP_TOP:int = -2;
      
      private static const ICON_WIDTH:int = 21;
      
      private static const ACTION_BG_OFFSET:int = 27;
       
      
      public var iconText:IconText = null;
      
      public var actionBg:ActionPriceBg;
      
      private var _blockWidth:int = 0;
      
      private var _isDataApplied:Boolean = false;
      
      public function ActionTextParameterBlock()
      {
         super();
         this.initialize();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         clearData();
         _data = new ActionTextParameterBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override protected function onSetBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this._blockWidth = param1;
            this.iconText.setTextWidth(param1 - this.iconText.x - ICON_WIDTH);
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.layout();
         return false;
      }
      
      override protected function getDataClass() : Class
      {
         return ActionTextParameterBlockVO;
      }
      
      override protected function onDispose() : void
      {
         this.iconText.dispose();
         this.iconText = null;
         this.actionBg = null;
         super.onDispose();
      }
      
      override protected function applyParamName() : void
      {
         var _loc1_:ActionTextParameterBlockVO = ActionTextParameterBlockVO(_data);
         this.iconText.useHtmlText = _loc1_.useHtmlName;
         this.iconText.text = _loc1_.name;
         if(_loc1_.icon != null && _loc1_.icon != Values.EMPTY_STR)
         {
            this.iconText.icon = _loc1_.icon;
         }
         if(_loc1_.nameOffset != -1)
         {
            this.iconText.xCorrect = _loc1_.nameOffset;
         }
         if(_loc1_.gap != -1)
         {
            this.iconText.x = valueTF.width + _data.gap;
         }
      }
      
      private function initialize() : void
      {
         this.iconText.setTextMultiline(true,true);
         this.iconText.setFixedIconWidth(true,ICON_WIDTH);
         this.actionBg.y = STATE_ALIGNED_TOP_TOP;
      }
      
      private function layout() : void
      {
         this.iconText.setTextWidth(this._blockWidth - this.iconText.x - ICON_WIDTH);
         this.actionBg.x = this.iconText.x + this.iconText.getVisibleWidth() + ACTION_BG_OFFSET;
      }
      
      private function applyData() : void
      {
         if(_data.useHtmlValue)
         {
            valueTF.htmlText = _data.value;
         }
         else
         {
            valueTF.text = _data.value;
         }
         if(_data.valueWidth != -1)
         {
            valueTF.x -= _data.valueWidth - valueTF.width;
            valueTF.width = _data.valueWidth;
         }
         updateTextFieldHeight(valueTF);
         this.applyParamName();
         var _loc1_:ActionTextParameterBlockVO = ActionTextParameterBlockVO(_data);
         this.actionBg.state = _loc1_.actionStyle;
         this._isDataApplied = true;
      }
   }
}
