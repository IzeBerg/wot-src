package net.wg.gui.components.carousels.data
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FilterRoleStateVO extends DAAPIDataClass
   {
      
      private static const LIGHT_TANK_FIELD:String = "lightTank";
      
      private static const MEDIUM_TANK_FIELD:String = "mediumTank";
      
      private static const HEAVY_TANK_FIELD:String = "heavyTank";
      
      private static const AT_SPG_FIELD:String = "AT-SPG";
      
      private static const SPG_FIELD:String = "SPG";
       
      
      private var _lightTank:Vector.<Boolean> = null;
      
      private var _mediumTank:Vector.<Boolean> = null;
      
      private var _heavyTank:Vector.<Boolean> = null;
      
      private var _AT_SPG:Vector.<Boolean> = null;
      
      private var _SPG:Vector.<Boolean> = null;
      
      private var _vehicleTypesMap:Dictionary = null;
      
      public function FilterRoleStateVO(param1:Object)
      {
         super(param1);
         this._vehicleTypesMap = new Dictionary(true);
         this._vehicleTypesMap[VehicleTypes.LIGHT_TANK] = this._lightTank;
         this._vehicleTypesMap[VehicleTypes.MEDIUM_TANK] = this._mediumTank;
         this._vehicleTypesMap[VehicleTypes.HEAVY_TANK] = this._heavyTank;
         this._vehicleTypesMap[VehicleTypes.AT_SPG] = this._AT_SPG;
         this._vehicleTypesMap[VehicleTypes.SPG] = this._SPG;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 == LIGHT_TANK_FIELD)
         {
            this._lightTank = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._lightTank.push(_loc3_);
            }
            return false;
         }
         if(param1 == MEDIUM_TANK_FIELD)
         {
            this._mediumTank = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._mediumTank.push(_loc3_);
            }
            return false;
         }
         if(param1 == HEAVY_TANK_FIELD)
         {
            this._heavyTank = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._heavyTank.push(_loc3_);
            }
            return false;
         }
         if(param1 == AT_SPG_FIELD)
         {
            this._AT_SPG = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._AT_SPG.push(_loc3_);
            }
            return false;
         }
         if(param1 == SPG_FIELD)
         {
            this._SPG = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._SPG.push(_loc3_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         App.instance.utils.data.cleanupDynamicObject(this._vehicleTypesMap);
         this._vehicleTypesMap = null;
         this._lightTank.splice(0,this._lightTank.length);
         this._lightTank = null;
         this._mediumTank.splice(0,this._mediumTank.length);
         this._mediumTank = null;
         this._heavyTank.splice(0,this._heavyTank.length);
         this._heavyTank = null;
         this._AT_SPG.splice(0,this._AT_SPG.length);
         this._AT_SPG = null;
         this._SPG.splice(0,this._SPG.length);
         this._SPG = null;
         super.onDispose();
      }
      
      public function getStates(param1:String) : Vector.<Boolean>
      {
         return this._vehicleTypesMap[param1];
      }
   }
}
