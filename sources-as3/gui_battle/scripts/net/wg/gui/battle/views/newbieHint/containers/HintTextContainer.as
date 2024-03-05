package net.wg.gui.battle.views.newbieHint.containers
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HintTextContainer extends HintComponentContainer
   {
       
      
      public var txt:TextField = null;
      
      private const BIG:String = "big";
      
      private const SMALL:String = "small";
      
      private var _message:String = "";
      
      public function HintTextContainer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.txt = null;
         super.dispose();
      }
      
      public function clear() : void
      {
         this._message = Values.EMPTY_STR;
         this.txt.htmlText = Values.EMPTY_STR;
      }
      
      public function setHintData(param1:String) : void
      {
         this._message = param1;
         this.updateMessage();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:String = param1 <= StageSizeBoundaries.WIDTH_1366 ? this.SMALL : this.BIG;
         if(_loc3_ != currentFrameLabel)
         {
            gotoAndStop(_loc3_);
            this.updateMessage();
         }
      }
      
      public function getWidth() : int
      {
         return this.txt.textWidth;
      }
      
      override protected function get content() : DisplayObject
      {
         return this.txt;
      }
      
      private function updateMessage() : void
      {
         this.txt.autoSize = TextFieldAutoSize.LEFT;
         this.txt.htmlText = this._message;
      }
   }
}
