package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVehiclesVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsResultFilterVehiclesPopoverViewMeta extends SmartPopOverView
   {
       
      
      public var setVehicleSelected:Function;
      
      public var applyFilters:Function;
      
      public var resetFilters:Function;
      
      private var _eventBoardTableFilterVehiclesVO:EventBoardTableFilterVehiclesVO;
      
      public function EventBoardsResultFilterVehiclesPopoverViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventBoardTableFilterVehiclesVO)
         {
            this._eventBoardTableFilterVehiclesVO.dispose();
            this._eventBoardTableFilterVehiclesVO = null;
         }
         super.onDispose();
      }
      
      public function setVehicleSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setVehicleSelected,"setVehicleSelected" + Errors.CANT_NULL);
         this.setVehicleSelected(param1);
      }
      
      public function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.applyFilters,"applyFilters" + Errors.CANT_NULL);
         this.applyFilters(param1,param2,param3,param4,param5);
      }
      
      public function resetFiltersS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilters,"resetFilters" + Errors.CANT_NULL);
         this.resetFilters();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:EventBoardTableFilterVehiclesVO = this._eventBoardTableFilterVehiclesVO;
         this._eventBoardTableFilterVehiclesVO = new EventBoardTableFilterVehiclesVO(param1);
         this.setInitData(this._eventBoardTableFilterVehiclesVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:EventBoardTableFilterVehiclesVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
