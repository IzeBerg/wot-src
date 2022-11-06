package net.wg.gui.lobby.vehiclePreview.infoPanel.browse
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class VPCollectibleInfo extends UIComponentEx
   {
      
      private static const ICON_SIZE:int = 80;
      
      private static const TITLE_OFFSET:int = 15;
       
      
      public var desc:TextField;
      
      public var title:TextField;
      
      public function VPCollectibleInfo()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.title.text = VEHICLE_PREVIEW.INFOPANEL_COLLECTIBLE_TITLE;
         this.desc.text = VEHICLE_PREVIEW.INFOPANEL_COLLECTIBLE_DESC;
         TextFieldEx.setVerticalAlign(this.title,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAutoSize(this.desc,TextFieldEx.VAUTOSIZE_TOP);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.title.width = width - ICON_SIZE - TITLE_OFFSET;
            this.desc.width = width;
            dispatchEvent(new Event(InvalidationType.LAYOUT));
         }
      }
      
      override protected function onDispose() : void
      {
         this.desc = null;
         this.title = null;
         super.onDispose();
      }
      
      override public function get height() : Number
      {
         return this.desc.y + this.desc.height;
      }
   }
}
