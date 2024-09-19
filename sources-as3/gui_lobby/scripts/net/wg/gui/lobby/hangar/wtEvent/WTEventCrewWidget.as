package net.wg.gui.lobby.hangar.wtEvent
{
   import net.wg.infrastructure.base.meta.IWTEventCrewWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventCrewWidgetMeta;
   
   public class WTEventCrewWidget extends WTEventCrewWidgetMeta implements IWTEventCrewWidgetMeta
   {
      
      private static const WIDGET_WIDTH:int = 469;
      
      private static const WIDGET_HEIGHT:int = 215;
       
      
      public function WTEventCrewWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setSize(WIDGET_WIDTH,WIDGET_HEIGHT);
      }
      
      public function as_showWidget() : void
      {
         this.visible = true;
      }
      
      public function as_hideWidget() : void
      {
         this.visible = false;
      }
   }
}
