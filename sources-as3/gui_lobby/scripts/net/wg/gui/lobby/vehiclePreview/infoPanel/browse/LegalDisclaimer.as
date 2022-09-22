package net.wg.gui.lobby.vehiclePreview.infoPanel.browse
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class LegalDisclaimer extends UIComponentEx
   {
      
      public static const CLICK_EVENT_TYPE:String = "disclaimerClick";
      
      private static const TOP_OFFSET:int = 2;
       
      
      public var disclaimerTF:TextField;
      
      public var disclaimerLink:HyperLink;
      
      public function LegalDisclaimer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.disclaimerTF.autoSize = TextFieldAutoSize.LEFT;
         this.disclaimerTF.wordWrap = true;
         this.disclaimerTF.multiline = true;
         this.disclaimerTF.text = VEHICLE_PREVIEW.DISCLAIMER;
         this.disclaimerTF.appendText(Values.SPACE_STR);
         this.disclaimerLink.label = VEHICLE_PREVIEW.DISCLAIMER_BUTTON;
         this.disclaimerLink.setWhiteLinkStyle();
         this.disclaimerLink.isShowLinkIco = true;
         this.disclaimerLink.addEventListener(MouseEvent.CLICK,this.onDisclaimerLinkClickHandler);
         var _loc1_:Rectangle = this.disclaimerTF.getCharBoundaries(this.disclaimerTF.length - 1);
         var _loc2_:int = this.disclaimerTF.numLines > 2 ? int(1) : int(TOP_OFFSET);
         this.disclaimerLink.y = _loc1_.top - _loc2_ >> 0;
         this.disclaimerLink.x = _loc1_.right >> 0;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.disclaimerTF = null;
         this.disclaimerLink.removeEventListener(MouseEvent.CLICK,this.onDisclaimerLinkClickHandler);
         this.disclaimerLink.dispose();
         this.disclaimerLink = null;
         super.onDispose();
      }
      
      override public function set width(param1:Number) : void
      {
         this.disclaimerTF.width = param1;
         setSize(param1,_height);
      }
      
      private function onDisclaimerLinkClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(CLICK_EVENT_TYPE));
      }
   }
}
