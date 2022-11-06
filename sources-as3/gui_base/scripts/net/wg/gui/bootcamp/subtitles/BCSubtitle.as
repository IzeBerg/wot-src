package net.wg.gui.bootcamp.subtitles
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class BCSubtitle extends UIComponentEx
   {
      
      private static const PADDING:int = 14;
       
      
      public var textField:TextField = null;
      
      public var back:MovieClip = null;
      
      private var _text:String = null;
      
      private var _commons:ICommons;
      
      public function BCSubtitle()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._text != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
         {
            this.textField.width = App.appWidth;
            this.textField.text = this._text;
            this._commons.updateTextFieldSize(this.textField,true);
            this.textField.x = -this.textField.width >> 1;
            this.back.x = this.textField.x - PADDING;
            this.back.width = PADDING + this.textField.width + PADDING;
         }
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.back = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         this._text = param1;
         invalidateData();
      }
   }
}
