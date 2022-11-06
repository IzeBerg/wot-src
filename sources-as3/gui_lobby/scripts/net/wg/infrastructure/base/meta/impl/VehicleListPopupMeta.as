package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.rally.vo.VehicleAlertVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleListPopupMeta extends AbstractWindowView
   {
       
      
      public var onSelectVehicles:Function;
      
      public var applyFilters:Function;
      
      private var _dataProviderVehicleSelectorItemVO:DataProvider;
      
      private var _arrayVehicleAlertVO:Array;
      
      private var _vehicleSelectorFilterVO:VehicleSelectorFilterVO;
      
      public function VehicleListPopupMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleSelectorItemVO = null;
         var _loc2_:VehicleAlertVO = null;
         if(this._dataProviderVehicleSelectorItemVO)
         {
            for each(_loc1_ in this._dataProviderVehicleSelectorItemVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderVehicleSelectorItemVO.cleanUp();
            this._dataProviderVehicleSelectorItemVO = null;
         }
         if(this._arrayVehicleAlertVO)
         {
            for each(_loc2_ in this._arrayVehicleAlertVO)
            {
               _loc2_.dispose();
            }
            this._arrayVehicleAlertVO.splice(0,this._arrayVehicleAlertVO.length);
            this._arrayVehicleAlertVO = null;
         }
         if(this._vehicleSelectorFilterVO)
         {
            this._vehicleSelectorFilterVO.dispose();
            this._vehicleSelectorFilterVO = null;
         }
         super.onDispose();
      }
      
      public function onSelectVehiclesS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectVehicles,"onSelectVehicles" + Errors.CANT_NULL);
         this.onSelectVehicles(param1);
      }
      
      public function applyFiltersS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.applyFilters,"applyFilters" + Errors.CANT_NULL);
         this.applyFilters(param1,param2);
      }
      
      public final function as_setListData(param1:Array, param2:Array) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:VehicleSelectorItemVO = null;
         var _loc10_:VehicleAlertVO = null;
         var _loc3_:DataProvider = this._dataProviderVehicleSelectorItemVO;
         this._dataProviderVehicleSelectorItemVO = new DataProvider();
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._dataProviderVehicleSelectorItemVO[_loc5_] = new VehicleSelectorItemVO(param1[_loc5_]);
            _loc5_++;
         }
         var _loc6_:Array = this._arrayVehicleAlertVO;
         this._arrayVehicleAlertVO = [];
         if(param2)
         {
            _loc7_ = param2.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               this._arrayVehicleAlertVO[_loc8_] = new VehicleAlertVO(param2[_loc8_]);
               _loc8_++;
            }
         }
         this.setListData(this._dataProviderVehicleSelectorItemVO,this._arrayVehicleAlertVO);
         if(_loc3_)
         {
            for each(_loc9_ in _loc3_)
            {
               _loc9_.dispose();
            }
            _loc3_.cleanUp();
         }
         if(_loc6_)
         {
            for each(_loc10_ in _loc6_)
            {
               _loc10_.dispose();
            }
            _loc6_.splice(0,_loc6_.length);
         }
      }
      
      public final function as_setFiltersData(param1:Object) : void
      {
         var _loc2_:VehicleSelectorFilterVO = this._vehicleSelectorFilterVO;
         this._vehicleSelectorFilterVO = new VehicleSelectorFilterVO(param1);
         this.setFiltersData(this._vehicleSelectorFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setListData(param1:DataProvider, param2:Array) : void
      {
         var _loc3_:String = "as_setListData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setFiltersData(param1:VehicleSelectorFilterVO) : void
      {
         var _loc2_:String = "as_setFiltersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
