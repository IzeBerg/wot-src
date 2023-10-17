package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.lobby.missions.data.MissionVehicleSelectorVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MissionsVehicleSelectorMeta extends BaseDAAPIComponent
   {
       
      
      private var _missionVehicleSelectorVO:MissionVehicleSelectorVO;
      
      private var _vehicleCarouselVO:VehicleCarouselVO;
      
      public function MissionsVehicleSelectorMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._missionVehicleSelectorVO)
         {
            this._missionVehicleSelectorVO.dispose();
            this._missionVehicleSelectorVO = null;
         }
         if(this._vehicleCarouselVO)
         {
            this._vehicleCarouselVO.dispose();
            this._vehicleCarouselVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:MissionVehicleSelectorVO = this._missionVehicleSelectorVO;
         this._missionVehicleSelectorVO = new MissionVehicleSelectorVO(param1);
         this.setInitData(this._missionVehicleSelectorVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showSelectedVehicle(param1:Object) : void
      {
         var _loc2_:VehicleCarouselVO = this._vehicleCarouselVO;
         this._vehicleCarouselVO = new VehicleCarouselVO(param1);
         this.showSelectedVehicle(this._vehicleCarouselVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:MissionVehicleSelectorVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showSelectedVehicle(param1:VehicleCarouselVO) : void
      {
         var _loc2_:String = "as_showSelectedVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
