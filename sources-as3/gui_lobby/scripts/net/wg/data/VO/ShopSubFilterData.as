package net.wg.data.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ShopSubFilterData extends DAAPIDataClass
   {
      
      private static const DATA_PROVIDER_FIELD_NAME:String = "dataProvider";
      
      private static const ASSERTION_MESSAGE_TYPE_MUST_BE_ARRAY:String = Errors.INVALID_TYPE + "Array";
       
      
      private var _current:Number = 0;
      
      private var _dataProvider:DataProvider = null;
      
      private var _nation:int = -1;
      
      private var _kind:String = "";
      
      private var _requestTypes:Array = null;
      
      private var _fitsType:String = "";
      
      public function ShopSubFilterData(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._dataProvider != null)
         {
            _loc1_ = this._dataProvider.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               IDisposable(this._dataProvider[_loc2_]).dispose();
               _loc2_++;
            }
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         if(this._requestTypes != null)
         {
            this._requestTypes.splice(0,this._requestTypes.length);
            this._requestTypes = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == DATA_PROVIDER_FIELD_NAME)
         {
            if(App.instance)
            {
               App.utils.asserter.assert(param2 is Array,ASSERTION_MESSAGE_TYPE_MUST_BE_ARRAY);
            }
            if(this._dataProvider)
            {
               this._dataProvider.cleanUp();
            }
            else
            {
               this._dataProvider = new DataProvider();
            }
            for each(_loc3_ in param2)
            {
               this._dataProvider.push(new ShopVehicleFilterElementData(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get current() : Number
      {
         return this._current;
      }
      
      public function set current(param1:Number) : void
      {
         if(App.instance)
         {
            if(isNaN(param1))
            {
               DebugUtils.LOG_WARNING("value \"current\" for filter data" + Errors.CANT_NULL);
            }
            App.utils.asserter.assert(param1 != 0,"invalid current value for filter data: " + param1);
         }
         this._current = param1;
      }
      
      public function get dataProvider() : DataProvider
      {
         return this._dataProvider;
      }
      
      public function get nation() : int
      {
         return this._nation;
      }
      
      public function set nation(param1:int) : void
      {
         this._nation = param1;
      }
      
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function set kind(param1:String) : void
      {
         this._kind = param1;
      }
      
      public function get requestTypes() : Array
      {
         return this._requestTypes;
      }
      
      public function set requestTypes(param1:Array) : void
      {
         this._requestTypes = param1;
      }
      
      public function get fitsType() : String
      {
         return this._fitsType;
      }
      
      public function set fitsType(param1:String) : void
      {
         this._fitsType = param1;
      }
   }
}
