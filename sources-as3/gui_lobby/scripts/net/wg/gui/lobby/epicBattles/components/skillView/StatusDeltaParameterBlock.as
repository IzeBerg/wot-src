package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.StatusDeltaParameterBlockVO;
   import net.wg.gui.lobby.epicBattles.interfaces.skillView.ISkillParameterBlock;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class StatusDeltaParameterBlock extends Sprite implements ISkillParameterBlock
   {
      
      private static const DECREASE_ARROW_PADDING:int = -17;
      
      private static const INDICATOR_OFFSET:int = -6;
       
      
      public var titleTF:TextField;
      
      public var valueTF:TextField;
      
      public var statusBar:IProgressBarAnim;
      
      public var buffIcon:Image = null;
      
      private var _data:StatusDeltaParameterBlockVO;
      
      public function StatusDeltaParameterBlock()
      {
         super();
         this.valueTF.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public final function dispose() : void
      {
         this.clearData();
         this.titleTF.text = this.titleTF.htmlText = this.valueTF.text = this.valueTF.htmlText = null;
         this.statusBar.dispose();
         this.statusBar = null;
         this.titleTF = null;
         this.valueTF = null;
         this.buffIcon.dispose();
         this.buffIcon = null;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function getHeight() : Number
      {
         return height;
      }
      
      public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new StatusDeltaParameterBlockVO(param1);
         this.applyData();
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
         this._data.statusBarData.useAnim = false;
         this.statusBar.setData(this._data.statusBarData);
         this.layout();
      }
      
      private function layout() : void
      {
         this.titleTF.x = this._data.deltaBlockGap;
         this.statusBar.x = this.titleTF.x + INDICATOR_OFFSET;
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
