package net.wg.gui.battle.comp7.views.battleTankCarousel
{
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.components.carousels.filters.TankCarouselFilters;
   
   public class BattleTankCarouselFilters extends TankCarouselFilters
   {
      
      private static const TILE_WIDTH:int = 42;
      
      private static const TILE_LIST_RENDERER_LINKAGE:String = "Comp7FilterRendererUI";
       
      
      private var _rowCount:uint;
      
      public function BattleTankCarouselFilters()
      {
         super();
      }
      
      override protected function showPopup() : void
      {
         popoverMgr.show(this,BATTLE_VIEW_ALIASES.COMP7_TANK_CAROUSEL_FILTER_POPOVER,{"rowCount":this._rowCount});
      }
      
      override protected function getTileWidth() : int
      {
         return TILE_WIDTH;
      }
      
      override protected function getTileListRenderer() : String
      {
         return TILE_LIST_RENDERER_LINKAGE;
      }
      
      public function setRowCount(param1:uint) : void
      {
         this._rowCount = param1;
      }
   }
}
