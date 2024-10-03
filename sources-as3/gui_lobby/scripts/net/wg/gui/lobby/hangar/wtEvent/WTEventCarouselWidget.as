package net.wg.gui.lobby.hangar.wtEvent
{
   import net.wg.infrastructure.base.meta.IWTEventCarouselWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventCarouselWidgetMeta;
   
   public class WTEventCarouselWidget extends WTEventCarouselWidgetMeta implements IWTEventCarouselWidgetMeta
   {
      
      public static const WIDGET_WIDTH_SMALL:int = 1024;
      
      public static const WIDGET_HEIGHT_SMALL:int = 260;
      
      public static const WIDGET_WIDTH_MEDIUM:int = 1124;
      
      public static const WIDGET_HEIGHT_MEDIUM:int = 260;
      
      public static const WIDGET_WIDTH_LARGE:int = 1461;
      
      public static const WIDGET_HEIGHT_LARGE:int = 320;
       
      
      public function WTEventCarouselWidget()
      {
         super();
         setManageSize(true);
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
