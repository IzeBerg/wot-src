package net.wg.gui.lobby.hangar.tcarousel
{
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   
   public class SmallTankCarouselItemRenderer extends TankCarouselItemRenderer
   {
      
      private static const LEVEL_INFO_OFFSET:int = -19;
       
      
      public function SmallTankCarouselItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         missionBadge.isSmall = true;
      }
      
      override public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.SMALL_SIZE;
      }
      
      override protected function get levelInfoOffset() : int
      {
         return LEVEL_INFO_OFFSET;
      }
   }
}
