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
   
   public class TechTreeMiniClientComponent extends MiniClientComponentMeta implements IMiniClientComponentMeta
   {
      
      private static const IMAGE_GAP:int = 2;
      
      private static const HYPERLINK_ADD_SPACE:int = 5;
       
      
      public var descriptionTF:TextField = null;
      
      public var hyperlink:HyperLink = null;
      
      public var icon:Sprite = null;
      
      public function TechTreeMiniClientComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.icon.mouseEnabled = false;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.mouseEnabled = false;
         this.hyperlink.autoSize = TextFieldAutoSize.LEFT;
         this.hyperlink.addEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.icon.x = this.width - this.icon.width - IMAGE_GAP - this.descriptionTF.width - this.hyperlink.textField.textWidth - HYPERLINK_ADD_SPACE >> 1;
            this.descriptionTF.x = this.icon.x + this.icon.width + IMAGE_GAP >> 0;
            this.hyperlink.x = this.descriptionTF.x + this.descriptionTF.width >> 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.hyperlink.removeEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
         this.descriptionTF = null;
         this.icon = null;
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
         return 0;
      }
      
      private function onHyperlinkClickHandler(param1:ButtonEvent) : void
      {
         onHyperlinkClickS();
      }
   }
}
