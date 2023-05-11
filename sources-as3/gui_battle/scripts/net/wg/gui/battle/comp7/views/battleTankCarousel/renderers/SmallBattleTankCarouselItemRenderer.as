package net.wg.gui.battle.comp7.views.battleTankCarousel.renderers
{
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   
   public class SmallBattleTankCarouselItemRenderer extends BattleTankCarouselItemRenderer
   {
       
      
      public function SmallBattleTankCarouselItemRenderer()
      {
         super();
      }
      
      override public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.SMALL_SIZE;
      }
      
      override protected function updateFlag() : void
      {
         flagLoader.source = data.flagIconSmall;
      }
      
      override protected function updateTankIcon() : void
      {
         tankIcon.source = data.vehicleIconSmall;
      }
   }
}
