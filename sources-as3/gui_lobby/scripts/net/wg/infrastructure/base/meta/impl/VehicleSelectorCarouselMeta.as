package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.CarouselEnvironment;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleSelectorCarouselMeta extends CarouselEnvironment
   {
       
      
      public var setFilter:Function;
      
      private var _tankCarouselFilterInitVO:TankCarouselFilterInitVO;
      
      public function VehicleSelectorCarouselMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tankCarouselFilterInitVO)
         {
            this._tankCarouselFilterInitVO.dispose();
            this._tankCarouselFilterInitVO = null;
         }
         super.onDispose();
      }
      
      public function setFilterS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1,param2);
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
      
      protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
      {
         var _loc2_:String = "as_initCarouselFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
