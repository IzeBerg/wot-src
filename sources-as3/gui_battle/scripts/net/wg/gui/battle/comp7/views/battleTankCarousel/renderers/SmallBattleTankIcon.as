package net.wg.gui.battle.comp7.views.battleTankCarousel.renderers
{
   import net.wg.gui.battle.comp7.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   
   public class SmallBattleTankIcon extends BaseBattleTankIcon
   {
      
      private static const ROLE_ICON_SIZE:String = "14x14";
       
      
      public function SmallBattleTankIcon()
      {
         super();
      }
      
      override protected function updateSizeRelatedItems(param1:BattleVehicleCarouselVO) : void
      {
         tankType.source = param1.vehicleTypeIconSmall;
      }
      
      override protected function getRoleIconSrc(param1:String) : String
      {
         return RES_ICONS.getRoleIcon(ROLE_ICON_SIZE,param1);
      }
      
      override protected function getFavoriteIconSrc() : String
      {
         return RES_ICONS.MAPS_ICONS_TOOLTIP_MAIN_TYPE_SMALL;
      }
   }
}
