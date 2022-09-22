package net.wg.gui.lobby.storage.categories.storage
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class ExtraParamsRenderer extends UIComponentEx implements IUpdatable
   {
      
      private static const DOTS:String = "...";
      
      private static const SEARCH_PATTERN:String = "\n";
      
      private static const REPLACE_PATTERN:String = " ";
       
      
      public var descTF:TextField;
      
      private var _maxTextWidth:int;
      
      private var _truncHtmlText:String;
      
      private var _originalHtmlText:String;
      
      public function ExtraParamsRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.descTF.multiline = true;
         this.descTF.autoSize = TextFieldAutoSize.LEFT;
         this.descTF.wordWrap = true;
      }
      
      override protected function onDispose() : void
      {
         this.descTF = null;
         this._truncHtmlText = null;
         this._originalHtmlText = null;
         super.onDispose();
      }
      
      public function getLinesCount() : int
      {
         return this.descTF.numLines;
      }
      
      public function setMaxTextWidth(param1:int) : void
      {
         this._maxTextWidth = param1;
         this.descTF.width = param1;
         this.updateText();
      }
      
      public function truncateText() : void
      {
         var _loc3_:int = 0;
         var _loc1_:TextFormat = this.descTF.defaultTextFormat;
         var _loc2_:TextField = new TextField();
         _loc2_.multiline = false;
         _loc2_.defaultTextFormat = _loc1_;
         _loc2_.wordWrap = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.width = this._maxTextWidth;
         this._truncHtmlText = this.descTF.text;
         _loc2_.text = this._truncHtmlText;
         if(_loc2_.textWidth > this._maxTextWidth)
         {
            _loc3_ = this.getTruncCount(_loc2_);
            this._truncHtmlText = this._originalHtmlText.substr(0,this._originalHtmlText.length - _loc3_ - DOTS.length);
            this._truncHtmlText += DOTS;
            this.descTF.htmlText = this._truncHtmlText;
         }
         else
         {
            this.descTF.htmlText = this._originalHtmlText;
         }
         this.descTF.height = _loc2_.height;
         this.descTF.multiline = false;
         this.descTF.wordWrap = false;
         this.descTF.width = this._maxTextWidth;
         height = this.descTF.height;
      }
      
      public function update(param1:Object) : void
      {
         this.descTF.multiline = true;
         this.descTF.autoSize = TextFieldAutoSize.LEFT;
         this.descTF.wordWrap = true;
         this._truncHtmlText = String(param1);
         while(this._truncHtmlText.indexOf(SEARCH_PATTERN) > -1)
         {
            this._truncHtmlText = this._truncHtmlText.replace(SEARCH_PATTERN,REPLACE_PATTERN);
         }
         this._originalHtmlText = this._truncHtmlText;
      }
      
      private function getTruncCount(param1:TextField) : int
      {
         var _loc2_:int = 0;
         var _loc3_:String = param1.text;
         while(param1.textWidth > this._maxTextWidth)
         {
            _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
            _loc2_++;
            param1.text = _loc3_;
         }
         return _loc2_;
      }
      
      private function updateText() : void
      {
         var _loc1_:TextFormat = this.descTF.defaultTextFormat;
         var _loc2_:TextField = new TextField();
         _loc2_.multiline = false;
         _loc2_.defaultTextFormat = _loc1_;
         _loc2_.wordWrap = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         this.descTF.htmlText = this._truncHtmlText;
         this.descTF.height = this.descTF.textHeight;
         height = this.descTF.height;
      }
   }
}
