package net.wg.gui.battle.views.calloutPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class InteractionDynamicTextLabel extends MovieClip implements IDisposable
   {
      
      private static const KEY_TF_WIDTH_NORM:int = 25;
      
      private static const KEY_TF_PADDING:int = 14;
      
      private static const BG_IMAGE_LEFT_OFFSET:int = 4;
      
      private static const BG_IMAGE_MIN_WIDTH:int = 22;
      
      private static const BG_SLICE_PADDING:int = 14;
       
      
      public var keyTF:TextField = null;
      
      public var leftTextMC:TextField = null;
      
      public var keyButtonBackgroundMC:MovieClip = null;
      
      public var rightTextMC:TextField = null;
      
      public function InteractionDynamicTextLabel()
      {
         super();
         TextFieldEx.setNoTranslate(this.keyTF,true);
         this.rightTextMC.autoSize = TextFieldAutoSize.LEFT;
         this.leftTextMC.autoSize = TextFieldAutoSize.LEFT;
         this.keyTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public final function dispose() : void
      {
         this.keyTF = null;
         this.keyButtonBackgroundMC = null;
         this.leftTextMC = null;
         this.rightTextMC = null;
      }
      
      public function updatePositionOnDraw() : void
      {
         var _loc1_:int = this.leftTextMC.textWidth + this.keyButtonBackgroundMC.width + this.rightTextMC.textWidth + BG_SLICE_PADDING;
         var _loc2_:int = -(_loc1_ >> 1);
         this.leftTextMC.x = _loc2_;
         var _loc3_:int = this.leftTextMC.x + this.leftTextMC.textWidth + BG_SLICE_PADDING / 2;
         this.keyButtonBackgroundMC.x = _loc3_ + BG_IMAGE_LEFT_OFFSET;
         this.rightTextMC.x = _loc3_ + this.keyButtonBackgroundMC.width + BG_SLICE_PADDING / 2;
         this.keyTF.x = this.keyButtonBackgroundMC.x + (this.keyButtonBackgroundMC.width - this.keyTF.width) / 2 - Math.ceil(this.keyTF.width / KEY_TF_WIDTH_NORM);
      }
      
      public function setTextData(param1:String, param2:String, param3:String) : void
      {
         this.keyTF.text = param2;
         this.leftTextMC.text = param1;
         this.rightTextMC.text = param3;
         this.keyButtonBackgroundMC.width = Math.max(this.keyTF.textWidth + KEY_TF_PADDING,BG_IMAGE_MIN_WIDTH);
      }
   }
}
