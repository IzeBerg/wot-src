package net.wg.gui.lobby.window
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
   import scaleform.clik.data.DataProvider;
   
   public class ExchangeXPWindowVO extends NormalSortingTableHeaderVO
   {
      
      private static const VEHICLE_LIST:String = "vehicleList";
      
      private static const EXCHANGE_HEADER_DATA:String = "exchangeHeaderData";
       
      
      public var isHaveElite:Boolean = false;
      
      public var xpForFree:int = -1;
      
      public var exchangeHeaderData:ExchangeHeaderVO = null;
      
      private var _vehicleList:DataProvider = null;
      
      public function ExchangeXPWindowVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == VEHICLE_LIST)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,VEHICLE_LIST + Errors.CANT_NULL);
            this._vehicleList = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._vehicleList.push(new ExchangeXPVehicleVO(_loc4_));
            }
            return false;
         }
         if(param1 == EXCHANGE_HEADER_DATA)
         {
            App.utils.asserter.assertNotNull(param2,EXCHANGE_HEADER_DATA + Errors.CANT_NULL);
            this.exchangeHeaderData = new ExchangeHeaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ExchangeXPVehicleVO = null;
         for each(_loc1_ in this._vehicleList)
         {
            _loc1_.dispose();
         }
         this._vehicleList.splice(0,this._vehicleList.length);
         this._vehicleList = null;
         this.exchangeHeaderData.dispose();
         this.exchangeHeaderData = null;
         super.onDispose();
      }
      
      public function get vehicleList() : DataProvider
      {
         return this._vehicleList;
      }
   }
}
