package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.data.FilterCarouseInitVO;
   import net.wg.gui.components.carousels.data.FiltersStateVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TankCarouselFilterPopoverMeta extends SmartPopOverView
   {
       
      
      public var changeFilter:Function;
      
      public var changeSearchNameVehicle:Function;
      
      public var switchCarouselType:Function;
      
      private var _filterCarouseInitVO:FilterCarouseInitVO;
      
      private var _filtersStateVO:FiltersStateVO;
      
      public function TankCarouselFilterPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._filterCarouseInitVO)
         {
            this._filterCarouseInitVO.dispose();
            this._filterCarouseInitVO = null;
         }
         if(this._filtersStateVO)
         {
            this._filtersStateVO.dispose();
            this._filtersStateVO = null;
         }
         super.onDispose();
      }
      
      public function changeFilterS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeFilter,"changeFilter" + Errors.CANT_NULL);
         this.changeFilter(param1,param2);
      }
      
      public function changeSearchNameVehicleS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.changeSearchNameVehicle,"changeSearchNameVehicle" + Errors.CANT_NULL);
         this.changeSearchNameVehicle(param1);
      }
      
      public function switchCarouselTypeS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.switchCarouselType,"switchCarouselType" + Errors.CANT_NULL);
         this.switchCarouselType(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:FilterCarouseInitVO = this._filterCarouseInitVO;
         this._filterCarouseInitVO = new FilterCarouseInitVO(param1);
         this.setInitData(this._filterCarouseInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setState(param1:Object) : void
      {
         var _loc2_:FiltersStateVO = this._filtersStateVO;
         this._filtersStateVO = new FiltersStateVO(param1);
         this.setState(this._filtersStateVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:FilterCarouseInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setState(param1:FiltersStateVO) : void
      {
         var _loc2_:String = "as_setState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
