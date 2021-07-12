package net.wg.gui.components.miniclient
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.infrastructure.base.meta.IMiniClientComponentMeta;
   import net.wg.infrastructure.base.meta.impl.MiniClientComponentMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class HangarMiniClientComponent extends MiniClientComponentMeta implements IMiniClientComponentMeta
   {
       
      
      public var descriptionTF:TextField = null;
      
      public var hyperlink:HyperLink = null;
      
      public var background:Sprite = null;
      
      public function HangarMiniClientComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.hyperlink.autoSize = TextFieldAutoSize.LEFT;
         this.hyperlink.addEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.descriptionTF.x = this.width - this.descriptionTF.width - this.hyperlink.textField.textWidth >> 1;
            this.hyperlink.x = this.descriptionTF.x + this.descriptionTF.width >> 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.hyperlink.removeEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
         this.descriptionTF = null;
         this.background = null;
         this.hyperlink.dispose();
         this.hyperlink = null;
         super.onDispose();
      }
      
      public function update(param1:String, param2:String) : void
      {
         this.descriptionTF.htmlText = param1;
         this.hyperlink.label = param2;
         this.hyperlink.validateNow();
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return this.background.width >> 0;
      }
      
      private function onHyperlinkClickHandler(param1:ButtonEvent) : void
      {
         onHyperlinkClickS();
      }
   }
}
