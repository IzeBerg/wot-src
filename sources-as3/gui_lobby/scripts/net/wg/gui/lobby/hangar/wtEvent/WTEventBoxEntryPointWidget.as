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
         setManageSize(true);
         setSize(WIDGET_WIDTH,WIDGET_HEIGHT);
      }
      
      public function as_hideWidget() : void
      {
         this.visible = false;
      }
      
      public function as_showWidget() : void
      {
         this.visible = true;
      }
   }
}
