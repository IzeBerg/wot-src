package net.wg.gui.components.popovers.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.components.popovers.interfaces.IVehicleSelectPopoverVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleSelectPopoverVO extends DAAPIDataClass implements IVehicleSelectPopoverVO
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
      
      private static const FILTERS:String = "filters";
       
      
      private var _header:String = "";
      
      private var _btnCancel:String = "";
      
      private var _filters:IVehicleSelectorFilterVO = null;
      
      private var _tableHeaders:DataProvider = null;
      
      private var _isMultiSelect:Boolean = false;
      
      public function VehicleSelectPopoverVO(param1:Object = null)
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
            this._filters = this.getVehicleSelectorFilterVO(param2);
            return false;
         }
         return true;
      }
      
      public function getVehicleSelectorFilterVO(param1:Object) : IVehicleSelectorFilterVO
      {
         return new VehicleSelectorFilterVO(param1);
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
      
      public function get filters() : IVehicleSelectorFilterVO
      {
         return this._filters;
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get btnCancel() : String
      {
         return this._btnCancel;
      }
      
      public function set btnCancel(param1:String) : void
      {
         this._btnCancel = param1;
      }
      
      public function get isMultiSelect() : Boolean
      {
         return this._isMultiSelect;
      }
      
      public function set isMultiSelect(param1:Boolean) : void
      {
         this._isMultiSelect = param1;
      }
   }
}
