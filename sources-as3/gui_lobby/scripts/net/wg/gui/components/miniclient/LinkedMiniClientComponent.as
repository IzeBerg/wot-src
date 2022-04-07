package net.wg.gui.components.miniclient
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.infrastructure.base.meta.IMiniClientComponentMeta;
   import net.wg.infrastructure.base.meta.impl.MiniClientComponentMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class LinkedMiniClientComponent extends MiniClientComponentMeta implements IMiniClientComponentMeta
   {
       
      
      public var descriptionTF:TextField = null;
      
      public var hyperlink:HyperLink = null;
      
      private var _gap:int = 10;
      
      private var _autoAlignVerticalCenter:Boolean = false;
      
      private var _autoAlignHorizontalCenter:Boolean = false;
      
      public function LinkedMiniClientComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hyperlink.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.wordWrap = true;
         this.descriptionTF.multiline = true;
         this.hyperlink.addEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._autoAlignVerticalCenter)
            {
               this.descriptionTF.y = height - this.getTextHeight() >> 1;
            }
            App.utils.commons.updateTextFieldSize(this.descriptionTF,false);
            this.hyperlink.y = this.descriptionTF.y + this.descriptionTF.height + this._gap >> 0;
            if(this._autoAlignHorizontalCenter)
            {
               this.descriptionTF.x = width - this.descriptionTF.width >> 1;
               this.hyperlink.validateNow();
               this.hyperlink.x = width - this.hyperlink.textField.width >> 1;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.hyperlink.removeEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
         this.descriptionTF = null;
         this.hyperlink.dispose();
         this.hyperlink = null;
         super.onDispose();
      }
      
      public function update(param1:String, param2:String) : void
      {
         this.descriptionTF.htmlText = param1;
         this.hyperlink.label = param2;
         invalidateData();
      }
      
      private function getTextHeight() : int
      {
         return this.descriptionTF.textHeight + this.hyperlink.height + this._gap >> 0;
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      public function set gap(param1:int) : void
      {
         this._gap = param1;
         invalidateData();
      }
      
      public function set autoAlignVerticalCenter(param1:Boolean) : void
      {
         this._autoAlignVerticalCenter = param1;
         invalidateData();
      }
      
      public function set autoAlignHorizontalCenter(param1:Boolean) : void
      {
         this._autoAlignHorizontalCenter = param1;
         invalidateData();
      }
      
      private function onHyperlinkClickHandler(param1:ButtonEvent) : void
      {
         onHyperlinkClickS();
      }
   }
}
