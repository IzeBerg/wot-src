package net.wg.gui.lobby.hangar.wtEvent
{
   import net.wg.infrastructure.base.meta.IWTEventParamsWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventParamsWidgetMeta;
   
   public class WTEventParamsWidget extends WTEventParamsWidgetMeta implements IWTEventParamsWidgetMeta
   {
      
      public static const WIDGET_WIDTH:int = 282;
      
      public static const WIDGET_HEIGHT:int = 490;
      
      public static const WIDGET_WIDTH_WIDE:int = 347;
      
      public static const WIDGET_HEIGHT_WIDE:int = 550;
       
      
      public function WTEventParamsWidget()
      {
         super();
         setManageSize(true);
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
