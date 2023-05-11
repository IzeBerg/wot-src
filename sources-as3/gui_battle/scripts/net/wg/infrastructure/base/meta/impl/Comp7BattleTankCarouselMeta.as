package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.BattleCarouselEnvironment;
   
   public class Comp7BattleTankCarouselMeta extends BattleCarouselEnvironment
   {
       
      
      public var setFilter:Function;
      
      public var onViewIsHidden:Function;
      
      public function Comp7BattleTankCarouselMeta()
      {
         super();
      }
      
      public function setFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1);
      }
      
      public function onViewIsHiddenS() : void
      {
         App.utils.asserter.assertNotNull(this.onViewIsHidden,"onViewIsHidden" + Errors.CANT_NULL);
         this.onViewIsHidden();
      }
   }
}
