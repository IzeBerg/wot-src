package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleCompareCartPopoverInitDataVO extends DAAPIDataClass
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
       
      
      public var title:String = "";
      
      private var _tableHeaders:DataProvider = null;
      
      public function VehicleCompareCartPopoverInitDataVO(param1:Object)
      {
         super(param1);
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
         super.onDispose();
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
         return super.onDataWrite(param1,param2);
      }
      
      public function get tableHeaders() : DataProvider
      {
         return this._tableHeaders;
      }
   }
}
