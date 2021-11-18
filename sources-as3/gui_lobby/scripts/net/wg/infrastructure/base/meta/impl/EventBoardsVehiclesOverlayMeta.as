package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsVehiclesOverlayVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsVehiclesOverlayMeta extends BaseDAAPIComponent
   {
       
      
      public var changeFilter:Function;
      
      public var applyFilters:Function;
      
      private var _eventBoardTableFilterVO:EventBoardTableFilterVO;
      
      private var _vehicleSelectorFilterVO:VehicleSelectorFilterVO;
      
      private var _eventBoardsVehiclesOverlayVO:EventBoardsVehiclesOverlayVO;
      
      public function EventBoardsVehiclesOverlayMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventBoardTableFilterVO)
         {
            this._eventBoardTableFilterVO.dispose();
            this._eventBoardTableFilterVO = null;
         }
         if(this._vehicleSelectorFilterVO)
         {
            this._vehicleSelectorFilterVO.dispose();
            this._vehicleSelectorFilterVO = null;
         }
         if(this._eventBoardsVehiclesOverlayVO)
         {
            this._eventBoardsVehiclesOverlayVO.dispose();
            this._eventBoardsVehiclesOverlayVO = null;
         }
         super.onDispose();
      }
      
      public function changeFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeFilter,"changeFilter" + Errors.CANT_NULL);
         this.changeFilter(param1);
      }
      
      public function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.applyFilters,"applyFilters" + Errors.CANT_NULL);
         this.applyFilters(param1,param2,param3,param4,param5);
      }
      
      public final function as_setHeader(param1:Object) : void
      {
         var _loc2_:EventBoardTableFilterVO = this._eventBoardTableFilterVO;
         this._eventBoardTableFilterVO = new EventBoardTableFilterVO(param1);
         this.setHeader(this._eventBoardTableFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setFilters(param1:Object) : void
      {
         var _loc2_:VehicleSelectorFilterVO = this._vehicleSelectorFilterVO;
         this._vehicleSelectorFilterVO = new VehicleSelectorFilterVO(param1);
         this.setFilters(this._vehicleSelectorFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setVehicles(param1:Object) : void
      {
         var _loc2_:EventBoardsVehiclesOverlayVO = this._eventBoardsVehiclesOverlayVO;
         this._eventBoardsVehiclesOverlayVO = new EventBoardsVehiclesOverlayVO(param1);
         this.setVehicles(this._eventBoardsVehiclesOverlayVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeader(param1:EventBoardTableFilterVO) : void
      {
         var _loc2_:String = "as_setHeader" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFilters(param1:VehicleSelectorFilterVO) : void
      {
         var _loc2_:String = "as_setFilters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicles(param1:EventBoardsVehiclesOverlayVO) : void
      {
         var _loc2_:String = "as_setVehicles" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
