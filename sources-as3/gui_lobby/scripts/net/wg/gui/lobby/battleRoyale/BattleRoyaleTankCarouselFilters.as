package net.wg.gui.lobby.battleRoyale
{
   import net.wg.gui.components.carousels.filters.TankCarouselFilters;
   
   public class BattleRoyaleTankCarouselFilters extends TankCarouselFilters
   {
       
      
      public function BattleRoyaleTankCarouselFilters()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         paramsFilter.visible = false;
      }
   }
}
