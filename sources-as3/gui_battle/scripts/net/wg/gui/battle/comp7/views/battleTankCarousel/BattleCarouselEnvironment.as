package net.wg.gui.battle.comp7.views.battleTankCarousel
{
   import net.wg.gui.battle.comp7.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.components.carousels.CarouselEnvironment;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class BattleCarouselEnvironment extends CarouselEnvironment implements IUIComponentEx, IDisplayableComponent
   {
       
      
      public function BattleCarouselEnvironment()
      {
         super();
      }
      
      override protected function getRendererVo() : Class
      {
         return BattleVehicleCarouselVO;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
   }
}
