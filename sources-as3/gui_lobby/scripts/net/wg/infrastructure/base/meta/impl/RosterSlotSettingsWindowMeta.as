package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.cyberSport.data.RosterSlotSettingsWindowStaticVO;
   import net.wg.gui.cyberSport.vo.RosterLimitsVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class RosterSlotSettingsWindowMeta extends AbstractWindowView
   {
       
      
      public var onFiltersUpdate:Function;
      
      public var requestVehicleFilters:Function;
      
      public var submitButtonHandler:Function;
      
      public var cancelButtonHandler:Function;
      
      private var _vehicleVO:VehicleVO;
      
      private var _dataProviderVehicleSelectorItemVO:DataProvider;
      
      private var _rosterSlotSettingsWindowStaticVO:RosterSlotSettingsWindowStaticVO;
      
      private var _rosterLimitsVO:RosterLimitsVO;
      
      private var _vehicleSelectorFilterVO:VehicleSelectorFilterVO;
      
      public function RosterSlotSettingsWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleSelectorItemVO = null;
         if(this._vehicleVO)
         {
            this._vehicleVO.dispose();
            this._vehicleVO = null;
         }
         if(this._dataProviderVehicleSelectorItemVO)
         {
            for each(_loc1_ in this._dataProviderVehicleSelectorItemVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderVehicleSelectorItemVO.cleanUp();
            this._dataProviderVehicleSelectorItemVO = null;
         }
         if(this._rosterSlotSettingsWindowStaticVO)
         {
            this._rosterSlotSettingsWindowStaticVO.dispose();
            this._rosterSlotSettingsWindowStaticVO = null;
         }
         if(this._rosterLimitsVO)
         {
            this._rosterLimitsVO.dispose();
            this._rosterLimitsVO = null;
         }
         if(this._vehicleSelectorFilterVO)
         {
            this._vehicleSelectorFilterVO.dispose();
            this._vehicleSelectorFilterVO = null;
         }
         super.onDispose();
      }
      
      public function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFiltersUpdate,"onFiltersUpdate" + Errors.CANT_NULL);
         this.onFiltersUpdate(param1,param2,param3,param4,param5);
      }
      
      public function requestVehicleFiltersS() : void
      {
         App.utils.asserter.assertNotNull(this.requestVehicleFilters,"requestVehicleFilters" + Errors.CANT_NULL);
         this.requestVehicleFilters();
      }
      
      public function submitButtonHandlerS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.submitButtonHandler,"submitButtonHandler" + Errors.CANT_NULL);
         this.submitButtonHandler(param1);
      }
      
      public function cancelButtonHandlerS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelButtonHandler,"cancelButtonHandler" + Errors.CANT_NULL);
         this.cancelButtonHandler();
      }
      
      public final function as_setVehicleSelection(param1:Object) : void
      {
         var _loc2_:VehicleVO = this._vehicleVO;
         this._vehicleVO = new VehicleVO(param1);
         this.setVehicleSelection(this._vehicleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRangeSelection(param1:Object) : void
      {
         var _loc2_:SettingRosterVO = new SettingRosterVO(param1);
         this.setRangeSelection(_loc2_);
      }
      
      public final function as_setListData(param1:Array) : void
      {
         var _loc5_:VehicleSelectorItemVO = null;
         var _loc2_:DataProvider = this._dataProviderVehicleSelectorItemVO;
         this._dataProviderVehicleSelectorItemVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderVehicleSelectorItemVO[_loc4_] = new VehicleSelectorItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setListData(this._dataProviderVehicleSelectorItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setStaticData(param1:Object) : void
      {
         var _loc2_:RosterSlotSettingsWindowStaticVO = this._rosterSlotSettingsWindowStaticVO;
         this._rosterSlotSettingsWindowStaticVO = new RosterSlotSettingsWindowStaticVO(param1);
         this.setStaticData(this._rosterSlotSettingsWindowStaticVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRosterLimits(param1:Object) : void
      {
         var _loc2_:RosterLimitsVO = this._rosterLimitsVO;
         this._rosterLimitsVO = new RosterLimitsVO(param1);
         this.setRosterLimits(this._rosterLimitsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateVehicleFilters(param1:Object) : void
      {
         var _loc2_:VehicleSelectorFilterVO = this._vehicleSelectorFilterVO;
         this._vehicleSelectorFilterVO = new VehicleSelectorFilterVO(param1);
         this.updateVehicleFilters(this._vehicleSelectorFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVehicleSelection(param1:VehicleVO) : void
      {
         var _loc2_:String = "as_setVehicleSelection" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRangeSelection(param1:SettingRosterVO) : void
      {
         var _loc2_:String = "as_setRangeSelection" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setListData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setListData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStaticData(param1:RosterSlotSettingsWindowStaticVO) : void
      {
         var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRosterLimits(param1:RosterLimitsVO) : void
      {
         var _loc2_:String = "as_setRosterLimits" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateVehicleFilters(param1:VehicleSelectorFilterVO) : void
      {
         var _loc2_:String = "as_updateVehicleFilters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
