package net.wg.gui.prebattle.squads
{
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.infrastructure.base.meta.ISquadPromoWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SquadPromoWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SquadPromoWindow extends SquadPromoWindowMeta implements ISquadPromoWindowMeta
   {
      
      private static const TEXT_HORIZONTAL_MARGIN:int = 34;
      
      private static const LINK_GAP:int = 4;
      
      private static const BOTTOM_MARGIN:int = 4;
      
      private static const DESCRIPTION_GAP:int = 3;
       
      
      public var hyperlink:HyperLink = null;
      
      public function SquadPromoWindow()
      {
         super();
         contentBottomMargin = BOTTOM_MARGIN;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hyperlink.addEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.hyperlink.removeEventListener(ButtonEvent.CLICK,this.onHyperlinkClickHandler);
         this.hyperlink.dispose();
         this.hyperlink = null;
         super.onDispose();
      }
      
      override protected function updateCustomLayout(param1:Number, param2:Number) : Rectangle
      {
         App.utils.commons.updateTextFieldSize(headerTf,false);
         App.utils.commons.updateTextFieldSize(descriptionTF,false);
         this.hyperlink.validateNow();
         headerTf.y = image.height - headerTf.height - descriptionTF.height - this.hyperlink.height - DESCRIPTION_GAP - LINK_GAP >> 1;
         descriptionTF.y = headerTf.y + headerTf.height + DESCRIPTION_GAP >> 0;
         this.hyperlink.y = descriptionTF.y + descriptionTF.height + LINK_GAP >> 0;
         return new Rectangle(0,0,param1,param2);
      }
      
      override protected function initTexts() : void
      {
         super.initTexts();
         this.hyperlink.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.hyperlink.x = TEXT_HORIZONTAL_MARGIN;
            descriptionTF.x = TEXT_HORIZONTAL_MARGIN;
            headerTf.x = TEXT_HORIZONTAL_MARGIN;
            this.hyperlink.y = descriptionTF.y + descriptionTF.textHeight + LINK_GAP >> 0;
         }
      }
      
      public function as_setHyperlink(param1:String) : void
      {
         this.hyperlink.label = param1;
      }
      
      private function onHyperlinkClickHandler(param1:ButtonEvent) : void
      {
         onHyperlinkClickS();
      }
   }
}
