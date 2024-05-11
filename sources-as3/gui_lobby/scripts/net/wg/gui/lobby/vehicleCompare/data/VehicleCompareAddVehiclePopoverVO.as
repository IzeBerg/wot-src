package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleCompareAddVehiclePopoverVO extends DAAPIDataClass
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
      
      private static const FILTERS:String = "filters";
       
      
      public var header:String = "";
      
      public var btnCancel:String = "";
      
      private var _filters:VehicleSelectorFilterVO = null;
      
      private var _tableHeaders:DataProvider = null;
      
      public function VehicleCompareAddVehiclePopoverVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(TABLE_HEADERS == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,TABLE_HEADERS + Errors.CANT_NULL);
            this._tableHeaders = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._tableHeaders.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
         }
         if(param1 == FILTERS)
         {
            this._filters = new VehicleSelectorFilterVO(param2);
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._tableHeaders)
         {
            _loc1_.dispose();
         }
         this._tableHeaders.cleanUp();
         this._tableHeaders = null;
         this._filters.dispose();
         this._filters = null;
         super.onDispose();
      }
      
      public function get tableHeaders() : DataProvider
      {
         return this._tableHeaders;
      }
      
      public function get filters() : VehicleSelectorFilterVO
      {
         return this._filters;
      }
   }
}
