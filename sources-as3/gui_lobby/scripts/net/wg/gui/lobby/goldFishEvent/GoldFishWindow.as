package net.wg.gui.lobby.goldFishEvent
{
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.infrastructure.base.meta.IGoldFishWindowMeta;
   import net.wg.infrastructure.base.meta.impl.GoldFishWindowMeta;
   
   public class GoldFishWindow extends GoldFishWindowMeta implements IGoldFishWindowMeta
   {
      
      private static const TF_LINK_GAP:Number = 5;
      
      private static const TF_DESCRIPTION_GAP:Number = 24;
      
      private static const BUTTON_TOP_MARGIN:Number = 3;
       
      
      public var titleTf:TextField = null;
      
      public var eventHyperLink:HyperLink = null;
      
      public function GoldFishWindow()
      {
         super();
         contentBottomMargin = 0;
      }
      
      override protected function updateCustomLayout(param1:Number, param2:Number) : Rectangle
      {
         return new Rectangle(0,0,param1,param2 + BUTTON_TOP_MARGIN);
      }
      
      override protected function initTexts() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this.eventHyperLink.dispose();
         this.eventHyperLink = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.eventHyperLink.addEventListener(MouseEvent.CLICK,this.onEvenLinkClicked);
      }
      
      public function as_setWindowTexts(param1:String, param2:String, param3:String, param4:String) : void
      {
         super.as_setText(param1,param3);
         this.titleTf.htmlText = param2;
         this.eventHyperLink.label = param4;
         descriptionTF.y = this.titleTf.y + this.titleTf.textHeight + TF_DESCRIPTION_GAP;
         this.eventHyperLink.y = descriptionTF.y + descriptionTF.textHeight + TF_LINK_GAP;
      }
      
      private function onEvenLinkClicked(param1:MouseEvent) : void
      {
         eventHyperLinkClickedS();
      }
   }
}
