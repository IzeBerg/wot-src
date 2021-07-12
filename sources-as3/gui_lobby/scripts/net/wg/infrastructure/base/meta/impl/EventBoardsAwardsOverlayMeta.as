package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsAwardsOverlayVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsAwardsOverlayMeta extends BaseDAAPIComponent
   {
       
      
      public var changeFilter:Function;
      
      private var _eventBoardTableFilterVO:EventBoardTableFilterVO;
      
      private var _vehicleVO:VehicleVO;
      
      private var _eventBoardsAwardsOverlayVO:EventBoardsAwardsOverlayVO;
      
      public function EventBoardsAwardsOverlayMeta()
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
         if(this._vehicleVO)
         {
            this._vehicleVO.dispose();
            this._vehicleVO = null;
         }
         if(this._eventBoardsAwardsOverlayVO)
         {
            this._eventBoardsAwardsOverlayVO.dispose();
            this._eventBoardsAwardsOverlayVO = null;
         }
         super.onDispose();
      }
      
      public function changeFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeFilter,"changeFilter" + Errors.CANT_NULL);
         this.changeFilter(param1);
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
      
      public final function as_setVehicle(param1:Object) : void
      {
         var _loc2_:VehicleVO = this._vehicleVO;
         this._vehicleVO = new VehicleVO(param1);
         this.setVehicle(this._vehicleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EventBoardsAwardsOverlayVO = this._eventBoardsAwardsOverlayVO;
         this._eventBoardsAwardsOverlayVO = new EventBoardsAwardsOverlayVO(param1);
         this.setData(this._eventBoardsAwardsOverlayVO);
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
      
      protected function setVehicle(param1:VehicleVO) : void
      {
         var _loc2_:String = "as_setVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:EventBoardsAwardsOverlayVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
