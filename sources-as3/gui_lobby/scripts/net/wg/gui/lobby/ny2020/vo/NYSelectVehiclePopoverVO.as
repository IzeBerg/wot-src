package net.wg.gui.lobby.ny2020.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class NYSelectVehiclePopoverVO extends DAAPIDataClass
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
      
      private static const FILTERS:String = "filters";
       
      
      public var defaultSortField:String = "";
      
      public var defaultSortDirection:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      private var _filters:IVehicleSelectorFilterVO = null;
      
      private var _tableHeaders:DataProvider;
      
      public function NYSelectVehiclePopoverVO(param1:Object)
      {
         super(param1);
      }
      
      private static function getTypedDataProvider(param1:*, param2:Class) : DataProvider
      {
         var _loc3_:DataProvider = new DataProvider();
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = new param2(param1[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._tableHeaders)
         {
            for each(_loc1_ in this._tableHeaders)
            {
               _loc1_.dispose();
            }
            this._tableHeaders.cleanUp();
            this._tableHeaders = null;
         }
         if(this._filters)
         {
            this._filters.dispose();
            this._filters = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(TABLE_HEADERS == param1)
         {
            App.utils.asserter.assertNotNull(param2 as Array,TABLE_HEADERS + Errors.CANT_NULL);
            this._tableHeaders = getTypedDataProvider(param2,NormalSortingBtnVO);
            return false;
         }
         if(param1 == FILTERS)
         {
            this._filters = new VehicleSelectorFilterVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get filters() : IVehicleSelectorFilterVO
      {
         return this._filters;
      }
      
      public function get tableHeaders() : DataProvider
      {
         return this._tableHeaders;
      }
   }
}
