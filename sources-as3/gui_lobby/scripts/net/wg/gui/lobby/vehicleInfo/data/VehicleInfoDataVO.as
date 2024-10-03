package net.wg.gui.lobby.vehicleInfo.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleInfoDataVO extends DAAPIDataClass
   {
      
      private static const PROPS_DATA:String = "propsData";
      
      private static const CREW_DATA:String = "crewData";
      
      private static const BASE_DATA:String = "baseData";
      
      private static const ABILITY_DATA:String = "abilityData";
       
      
      public var vehicleName:String = "";
      
      public var vehicleDescription:String = "";
      
      public var vehicleImage:String = "";
      
      public var vehicleLevel:int = -1;
      
      public var vehicleNation:int = -1;
      
      public var vehicleType:String = "";
      
      public var roleStr:String = "";
      
      public var vehicleElite:Boolean = false;
      
      private var _propsData:Vector.<Object>;
      
      private var _crewData:Vector.<Object>;
      
      private var _baseData:Vector.<Object>;
      
      private var _abilityData:Vector.<Object>;
      
      public function VehicleInfoDataVO(param1:Object)
      {
         this._propsData = new Vector.<Object>();
         this._crewData = new Vector.<Object>();
         this._baseData = new Vector.<Object>();
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:IDisposable = null;
         var _loc3_:IDisposable = null;
         for each(_loc1_ in this._propsData)
         {
            _loc1_.dispose();
         }
         this._propsData.splice(0,this._propsData.length);
         this._propsData = null;
         for each(_loc2_ in this._crewData)
         {
            _loc2_.dispose();
         }
         this._crewData.splice(0,this._crewData.length);
         this._crewData = null;
         this._baseData.splice(0,this._baseData.length);
         this._baseData = null;
         for each(_loc3_ in this._abilityData)
         {
            _loc3_.dispose();
         }
         this._abilityData.splice(0,this._abilityData.length);
         this._abilityData = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:Object = null;
         if(param1 == PROPS_DATA)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,PROPS_DATA + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._propsData.push(new VehicleInfoPropBlockVO(_loc4_));
            }
            return false;
         }
         if(param1 == CREW_DATA)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,CREW_DATA + Errors.CANT_NULL);
            for each(_loc6_ in _loc5_)
            {
               this._crewData.push(new VehicleInfoCrewBlockVO(_loc6_));
            }
            return false;
         }
         if(param1 == BASE_DATA)
         {
            _loc7_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc7_,BASE_DATA + Errors.CANT_NULL);
            for each(_loc8_ in _loc7_)
            {
               this._baseData.push(_loc8_);
            }
            return false;
         }
         if(param1 == ABILITY_DATA)
         {
            if(param2)
            {
               this._abilityData = new Vector.<Object>(0);
               _loc9_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc9_,ABILITY_DATA + Errors.CANT_NULL);
               for each(_loc10_ in _loc9_)
               {
                  this._abilityData.push(new VehicleInfoAbilityBlockVO(_loc10_));
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get propsData() : Vector.<Object>
      {
         return this._propsData;
      }
      
      public function get crewData() : Vector.<Object>
      {
         return this._crewData;
      }
      
      public function get baseData() : Vector.<Object>
      {
         return this._baseData;
      }
      
      public function get abilityData() : Vector.<Object>
      {
         return this._abilityData;
      }
   }
}
