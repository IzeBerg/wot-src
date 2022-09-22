package net.wg.gui.lobby.hangar.wtEvent
{
   import net.wg.infrastructure.base.meta.IWTEventBoxEntryPointWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventBoxEntryPointWidgetMeta;
   
   public class WTEventBoxEntryPointWidget extends WTEventBoxEntryPointWidgetMeta implements IWTEventBoxEntryPointWidgetMeta
   {
      
      public static const WIDGET_WIDTH:int = 400;
      
      public static const WIDGET_HEIGHT:int = 300;
       
      
      public function WTEventBoxEntryPointWidget()
      {
         super();
         setSize(WIDGET_WIDTH,WIDGET_HEIGHT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
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
