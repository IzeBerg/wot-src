package net.wg.gui.components.tooltips.finstats
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EfficiencyBlock extends UIComponentEx
   {
       
      
      public var leftTF:TextField;
      
      public var rightTF:TextField;
      
      private var dirtyData:Boolean = false;
      
      private var _leftStr:String = "";
      
      private var _rightStr:String = "";
      
      public function EfficiencyBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.dirtyData)
         {
            this.leftTF.autoSize = TextFieldAutoSize.RIGHT;
            this.leftTF.multiline = true;
            this.leftTF.wordWrap = true;
            this.leftTF.htmlText = this._leftStr;
            this.leftTF.width = Math.max(this.leftTF.textWidth + 5,60);
            this.leftTF.height = this.leftTF.textHeight + 4;
            this.rightTF.autoSize = TextFieldAutoSize.LEFT;
            this.rightTF.multiline = true;
            this.rightTF.wordWrap = true;
            this.rightTF.htmlText = this._rightStr;
            this.rightTF.x = this.leftTF.x + this.leftTF.width + 5;
            this.rightTF.width = this.rightTF.textWidth + 5;
            this.rightTF.height = this.rightTF.textHeight + 4;
         }
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this._leftStr = param1;
         this._rightStr = param2;
         this.dirtyData = true;
         validateNow();
      }
   }
}
