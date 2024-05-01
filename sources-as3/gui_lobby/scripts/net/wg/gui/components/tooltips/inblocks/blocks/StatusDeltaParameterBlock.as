package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.StatusDeltaParameterBlockVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class StatusDeltaParameterBlock extends BaseTooltipBlock
   {
      
      private static const DECREASE_ARROW_PADDING:int = -17;
      
      private static const INDICATOR_OFFSET:int = -6;
       
      
      public var titleTF:TextField;
      
      public var valueTF:TextField;
      
      public var statusBar:IProgressBarAnim;
      
      public var buffIcon:Image = null;
      
      private var _data:StatusDeltaParameterBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      private var _isStatusBarDataApplied:Boolean = false;
      
      public function StatusDeltaParameterBlock()
      {
         super();
         this.valueTF.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
         this.titleTF.text = this.titleTF.htmlText = this.valueTF.text = this.valueTF.htmlText = null;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new StatusDeltaParameterBlockVO(param1);
         this._isDataApplied = false;
         this._isStatusBarDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.statusBar.dispose();
         this.statusBar = null;
         this.titleTF = null;
         this.valueTF = null;
         this.buffIcon.dispose();
         this.buffIcon = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!this._isDataApplied)
         {
            this.applyData();
            this._isDataApplied = true;
            _loc1_ = true;
         }
         if(!this._isStatusBarDataApplied)
         {
            this.statusBar.setData(this._data.statusBarData);
            this._isStatusBarDataApplied = true;
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function applyData() : void
      {
         if(this._data == null)
         {
            App.utils.asserter.assert(false,"_data " + Errors.CANT_NULL);
         }
         this.applyTextData(this.titleTF,this._data.title);
         this.applyTextData(this.valueTF,this._data.valueStr);
         this.buffIcon.visible = StringUtils.isNotEmpty(this._data.buffIconSrc);
         if(this.buffIcon.visible)
         {
            this.buffIcon.source = this._data.buffIconSrc;
            this.buffIcon.x = this.valueTF.x + this.valueTF.width - this.valueTF.textWidth + DECREASE_ARROW_PADDING ^ 0;
         }
         this.layout();
      }
      
      private function layout() : void
      {
         this.titleTF.x = this._data.deltaBlockGap;
         this.statusBar.x = this.titleTF.x + INDICATOR_OFFSET;
      }
      
      private function applyTextData(param1:TextField, param2:String) : void
      {
         if(param1 != null)
         {
            param1.visible = StringUtils.isNotEmpty(param2);
            if(param1.visible)
            {
               param1.htmlText = param2;
            }
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
