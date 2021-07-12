package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
   import net.wg.gui.lobby.epicBattles.interfaces.skillView.ISkillParameterBlock;
   
   public class TextParameterBlock extends Sprite implements ISkillParameterBlock
   {
       
      
      public var valueTF:TextField = null;
      
      public var nameTF:TextField = null;
      
      private var _data:TextParameterVO = null;
      
      public function TextParameterBlock()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.clearData();
         this.nameTF = null;
         this.valueTF = null;
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
         this._data = new TextParameterVO(param1);
         this.invalidateValues();
      }
      
      private function invalidateValues() : void
      {
         if(this._data.useHtmlName)
         {
            this.nameTF.htmlText = this._data.name;
         }
         else
         {
            this.nameTF.text = this._data.name;
         }
         if(this._data.useHtmlValue)
         {
            this.valueTF.htmlText = this._data.value;
         }
         else
         {
            this.valueTF.text = this._data.value;
         }
         if(this._data.valueWidth != -1)
         {
            this.valueTF.width = this._data.valueWidth;
         }
         if(this._data.gap != -1)
         {
            this.nameTF.x = this.valueTF.width + this._data.gap;
         }
         App.utils.commons.updateTextFieldSize(this.nameTF,false,true);
         App.utils.commons.updateTextFieldSize(this.valueTF,false,true);
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
