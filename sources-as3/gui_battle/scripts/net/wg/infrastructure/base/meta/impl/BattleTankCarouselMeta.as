package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.battleTankCarousel.BattleCarouselEnvironment;
   
   public class BattleTankCarouselMeta extends BattleCarouselEnvironment
   {
       
      
      public var setFilter:Function;
      
      public function BattleTankCarouselMeta()
      {
         super();
      }
      
      public function setFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1);
      }
   }
}
