package net.wg.gui.login.legal
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class LegalContent extends UIComponentEx
   {
      
      private static var LOGOS_TOP_MARGIN:Number = 15;
      
      private static var LOGOS_LEFT_MARGIN:Number = 20;
      
      private static var FRAME_MARGIN:Number = 0;
       
      
      public var textField:TextField = null;
      
      public var logos:UILoaderAlt = null;
      
      private var _textInfo:String = "";
      
      public function LegalContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.logos.addEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.logos.addEventListener(UILoaderEvent.IOERROR,this.onLoadError);
         this.logos.source = RES_COMMON.MAPS_LEGAL_BRANDS;
      }
      
      private function onLoadError(param1:UILoaderEvent) : void
      {
         this.logos.visible = false;
         invalidateSize();
      }
      
      private function onLoadComplete(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.textField.text = this._textInfo;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.logos.visible)
            {
               this.logos.x = this.textField.x - LOGOS_LEFT_MARGIN;
               this.logos.y = this.textField.y + this.textField.textHeight + LOGOS_TOP_MARGIN ^ 0;
               _height = this.logos.y + this.logos.height;
            }
            else
            {
               this.logos.y = 0;
               _height = this.textField.y + this.textField.textHeight;
            }
            _height += FRAME_MARGIN;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.logos.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.logos.removeEventListener(UILoaderEvent.IOERROR,this.onLoadError);
         super.onDispose();
      }
      
      public function updateData(param1:String) : void
      {
         this._textInfo = param1;
         invalidateData();
      }
   }
}
