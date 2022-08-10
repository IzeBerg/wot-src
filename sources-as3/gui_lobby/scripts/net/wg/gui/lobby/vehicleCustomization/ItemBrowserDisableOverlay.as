package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ItemBrowserDisableOverlay extends UIComponentEx
   {
       
      
      public var mc:MovieClip = null;
      
      public var tooltip:String = "";
      
      public function ItemBrowserDisableOverlay()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mc = new MovieClip();
         addChild(this.mc);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMcMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMcMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMcMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMcMouseOutHandler);
         this.mc = null;
         super.onDispose();
      }
      
      private function onMcMouseOverHandler(param1:MouseEvent) : void
      {
         if(this.tooltip.length > 0)
         {
            App.toolTipMgr.showComplex(this.tooltip);
         }
      }
      
      private function onMcMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
