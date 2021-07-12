package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.VO.TankCarouselFilterSelectedVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.battleTankCarousel.BattleCarouselEnvironment;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleTankCarouselMeta extends BattleCarouselEnvironment
   {
       
      
      public var setFilter:Function;
      
      public var updateHotFilters:Function;
      
      private var _tankCarouselFilterSelectedVO:TankCarouselFilterSelectedVO;
      
      private var _tankCarouselFilterInitVO:TankCarouselFilterInitVO;
      
      public function BattleTankCarouselMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tankCarouselFilterSelectedVO)
         {
            this._tankCarouselFilterSelectedVO.dispose();
            this._tankCarouselFilterSelectedVO = null;
         }
         if(this._tankCarouselFilterInitVO)
         {
            this._tankCarouselFilterInitVO.dispose();
            this._tankCarouselFilterInitVO = null;
         }
         super.onDispose();
      }
      
      public function setFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1);
      }
      
      public function updateHotFiltersS() : void
      {
         App.utils.asserter.assertNotNull(this.updateHotFilters,"updateHotFilters" + Errors.CANT_NULL);
         this.updateHotFilters();
      }
      
      public final function as_setCarouselFilter(param1:Object) : void
      {
         var _loc2_:TankCarouselFilterSelectedVO = this._tankCarouselFilterSelectedVO;
         this._tankCarouselFilterSelectedVO = new TankCarouselFilterSelectedVO(param1);
         this.setCarouselFilter(this._tankCarouselFilterSelectedVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_initCarouselFilter(param1:Object) : void
      {
         var _loc2_:TankCarouselFilterInitVO = this._tankCarouselFilterInitVO;
         this._tankCarouselFilterInitVO = new TankCarouselFilterInitVO(param1);
         this.initCarouselFilter(this._tankCarouselFilterInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO) : void
      {
         var _loc2_:String = "as_setCarouselFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
      {
         var _loc2_:String = "as_initCarouselFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
