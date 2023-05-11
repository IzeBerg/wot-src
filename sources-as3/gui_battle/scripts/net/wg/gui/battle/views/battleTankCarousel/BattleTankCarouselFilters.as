package net.wg.gui.battle.views.battleTankCarousel
{
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.components.carousels.filters.TankCarouselFilters;
   
   public class BattleTankCarouselFilters extends TankCarouselFilters
   {
       
      
      public function BattleTankCarouselFilters()
      {
         super();
      }
      
      override protected function showPopup() : void
      {
         popoverMgr.show(this,BATTLE_VIEW_ALIASES.EPIC_CAROUSEL_FILTER_POPOVER);
      }
   }
}
