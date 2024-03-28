package net.wg.gui.lobby.clans.profile.cmp
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.clans.profile.interfaces.ITextFieldFrame;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class TextFieldFrame extends UIComponentEx implements ITextFieldFrame
   {
      
      private static const UPDATE_TEXT_FIELD_PROPS:String = "updateTextFieldProps";
       
      
      public var labelTF:TextField = null;
      
      public var imageLoader:UILoaderAlt = null;
      
      private var _label:String = "";
      
      private var _verticalTextPosition:String = "center";
      
      private var _textAlign:String = "center";
      
      public function TextFieldFrame()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.imageLoader.x = 0;
         this.imageLoader.y = 0;
         this.imageLoader.addEventListener(UILoaderEvent.COMPLETE,this.onLoadHandler);
      }
      
      override protected function onDispose() : void
      {
         this.labelTF = null;
         this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadHandler);
         this.imageLoader.dispose();
         this.imageLoader = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.labelTF.x = 0;
            this.labelTF.y = 0;
            this.labelTF.width = this._width;
            this.labelTF.height = this._height;
         }
         if(isInvalid(UPDATE_TEXT_FIELD_PROPS))
         {
            TextFieldEx.setVerticalAlign(this.labelTF,this._verticalTextPosition);
            _loc1_ = this.labelTF.getTextFormat();
            _loc1_.align = this._textAlign;
            this.labelTF.setTextFormat(_loc1_);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.labelTF.htmlText = this._label;
         }
      }
      
      public function get imageSource() : String
      {
         return this.imageLoader.source;
      }
      
      public function set imageSource(param1:String) : void
      {
         this.imageLoader.source = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         if(!param1 || this._label == param1)
         {
            return;
         }
         this._label = param1;
         invalidateData();
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         this._textAlign = param1;
      }
      
      private function onLoadHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
   }
}
