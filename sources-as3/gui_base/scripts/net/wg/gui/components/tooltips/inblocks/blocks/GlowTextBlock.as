package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.inblocks.data.GlowTextBlockVO;
   
   public class GlowTextBlock extends BaseTextBlock
   {
       
      
      public var textTF:TextField;
      
      private var _originDim:Point;
      
      private var _data:GlowTextBlockVO;
      
      public function GlowTextBlock()
      {
         this._originDim = new Point();
         super();
         this._originDim.x = this.textTF.width;
         this._originDim.y = this.textTF.height;
      }
      
      override public function cleanUp() : void
      {
         this.clearData();
         this.textTF.htmlText = null;
         this.textTF.text = null;
         this.textTF.width = this._originDim.x;
         this.textTF.height = this._originDim.y;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new GlowTextBlockVO(param1);
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.textTF.width = param1;
         }
      }
      
      override protected function onValidateBlock() : Boolean
      {
         this.applyData();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.textTF = null;
         this._originDim = null;
         super.onDispose();
      }
      
      protected function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function applyData() : void
      {
         if(this._data.useHtml)
         {
            this.textTF.htmlText = this._data.text;
         }
         else
         {
            this.textTF.text = this._data.text;
         }
         App.utils.commons.setShadowFilterWithParams(this.textTF,this._data.distance,this._data.angle,this._data.color,this._data.alpha,this._data.blurX,this._data.blurY,this._data.strength,this._data.quality);
         updateTextFieldHeight(this.textTF);
      }
   }
}
