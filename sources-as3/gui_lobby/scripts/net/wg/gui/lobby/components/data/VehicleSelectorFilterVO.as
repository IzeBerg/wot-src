package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.VEHICLE_SELECTOR_CONSTANTS;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleSelectorFilterVO extends DAAPIDataClass implements IVehicleSelectorFilterVO
   {
      
      private static const NATION_DP_FIELD_NAME:String = "nationDP";
      
      private static const VEHICLE_TYPES_DP_FIELD_NAME:String = "vehicleTypesDP";
      
      private static const LEVELS_DP_FIELD_NAME:String = "levelsDP";
       
      
      private var _nation:int = -1;
      
      private var _vehicleType:String = "";
      
      private var _isMain:Boolean = false;
      
      private var _level:int = -1;
      
      private var _compatibleOnly:Boolean = true;
      
      private var _compatibleOnlyLabel:String = "";
      
      private var _nationDP:DataProvider = null;
      
      private var _vehicleTypesDP:DataProvider = null;
      
      private var _levelsDP:DataProvider = null;
      
      private var _visibility:int;
      
      public function VehicleSelectorFilterVO(param1:Object)
      {
         this._visibility = VEHICLE_SELECTOR_CONSTANTS.VISIBLE_LEVEL | VEHICLE_SELECTOR_CONSTANTS.VISIBLE_NATION | VEHICLE_SELECTOR_CONSTANTS.VISIBLE_VEHICLE_TYPE | VEHICLE_SELECTOR_CONSTANTS.VISIBLE_IS_MAIN | VEHICLE_SELECTOR_CONSTANTS.VISIBLE_COMPATIBLE_ONLY;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         if(NATION_DP_FIELD_NAME == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,NATION_DP_FIELD_NAME + Errors.CANT_NULL);
            this._nationDP = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._nationDP.push(_loc4_);
            }
            return false;
         }
         if(VEHICLE_TYPES_DP_FIELD_NAME == param1)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,VEHICLE_TYPES_DP_FIELD_NAME + Errors.CANT_NULL);
            this._vehicleTypesDP = new DataProvider();
            for each(_loc6_ in _loc5_)
            {
               this._vehicleTypesDP.push(_loc6_);
            }
            return false;
         }
         if(LEVELS_DP_FIELD_NAME == param1)
         {
            _loc7_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc7_,LEVELS_DP_FIELD_NAME + Errors.CANT_NULL);
            this._levelsDP = new DataProvider();
            for each(_loc8_ in _loc7_)
            {
               this._levelsDP.push(_loc8_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._nationDP)
         {
            this._nationDP.cleanUp();
            this._nationDP = null;
         }
         if(this._vehicleTypesDP)
         {
            this._vehicleTypesDP.cleanUp();
            this._vehicleTypesDP = null;
         }
         if(this._levelsDP)
         {
            this._levelsDP.cleanUp();
            this._levelsDP = null;
         }
         super.onDispose();
      }
      
      public function get nationDP() : DataProvider
      {
         return this._nationDP;
      }
      
      public function get vehicleTypesDP() : DataProvider
      {
         return this._vehicleTypesDP;
      }
      
      public function get levelsDP() : DataProvider
      {
         return this._levelsDP;
      }
      
      public function get nation() : int
      {
         return this._nation;
      }
      
      public function set nation(param1:int) : void
      {
         this._nation = param1;
      }
      
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
      
      public function set vehicleType(param1:String) : void
      {
         this._vehicleType = param1;
      }
      
      public function get isMain() : Boolean
      {
         return this._isMain;
      }
      
      public function set isMain(param1:Boolean) : void
      {
         this._isMain = param1;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get compatibleOnly() : Boolean
      {
         return this._compatibleOnly;
      }
      
      public function set compatibleOnly(param1:Boolean) : void
      {
         this._compatibleOnly = param1;
      }
      
      public function get compatibleOnlyLabel() : String
      {
         return this._compatibleOnlyLabel;
      }
      
      public function set compatibleOnlyLabel(param1:String) : void
      {
         this._compatibleOnlyLabel = param1;
      }
      
      public function get visibility() : int
      {
         return this._visibility;
      }
      
      public function set visibility(param1:int) : void
      {
         this._visibility = param1;
      }
   }
}
