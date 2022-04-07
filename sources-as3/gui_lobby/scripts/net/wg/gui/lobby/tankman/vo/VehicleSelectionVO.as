package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleSelectionVO extends DAAPIDataClass
   {
      
      private static const ITEMS:String = "items";
       
      
      public var light:DataProvider;
      
      public var medium:DataProvider;
      
      public var heavy:DataProvider;
      
      public var at_spg:DataProvider;
      
      public var spg:DataProvider;
      
      public var nativeVehicleId:int = -1;
      
      public var nativeVehicleType:String = "";
      
      public var currentVehicleId:int = -1;
      
      public var currentVehicleType:String = "";
      
      public function VehicleSelectionVO(param1:Object)
      {
         this.light = new DataProvider();
         this.medium = new DataProvider();
         this.heavy = new DataProvider();
         this.at_spg = new DataProvider();
         this.spg = new DataProvider();
         this.nativeVehicleId = param1.nativeVehicleId;
         this.currentVehicleId = param1.currentVehicleId;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:VehicleSelectionItemVO = null;
         if(param1 == ITEMS)
         {
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = new VehicleSelectionItemVO(_loc3_[_loc5_]);
               if(this.nativeVehicleId == _loc6_.id)
               {
                  this.nativeVehicleType = _loc6_.type;
               }
               if(this.currentVehicleId == _loc6_.id)
               {
                  this.currentVehicleType = _loc6_.type;
               }
               switch(_loc6_.type)
               {
                  case VehicleTypes.LIGHT_TANK:
                     this.light.push(_loc6_);
                     break;
                  case VehicleTypes.MEDIUM_TANK:
                     this.medium.push(_loc6_);
                     break;
                  case VehicleTypes.HEAVY_TANK:
                     this.heavy.push(_loc6_);
                     break;
                  case VehicleTypes.AT_SPG:
                     this.at_spg.push(_loc6_);
                     break;
                  case VehicleTypes.SPG:
                     this.spg.push(_loc6_);
                     break;
                  default:
                     DebugUtils.LOG_DEBUG("ERROR unknown tank type");
                     break;
               }
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.light)
         {
            _loc1_.dispose();
         }
         this.light.cleanUp();
         this.light = null;
         for each(_loc1_ in this.medium)
         {
            _loc1_.dispose();
         }
         this.medium.cleanUp();
         this.medium = null;
         for each(_loc1_ in this.heavy)
         {
            _loc1_.dispose();
         }
         this.heavy.cleanUp();
         this.heavy = null;
         for each(_loc1_ in this.at_spg)
         {
            _loc1_.dispose();
         }
         this.at_spg.cleanUp();
         this.at_spg = null;
         for each(_loc1_ in this.spg)
         {
            _loc1_.dispose();
         }
         this.spg.cleanUp();
         this.spg = null;
         super.onDispose();
      }
      
      public function getVehiclesForType(param1:String) : DataProvider
      {
         switch(param1)
         {
            case VehicleTypes.LIGHT_TANK:
               return this.light;
            case VehicleTypes.MEDIUM_TANK:
               return this.medium;
            case VehicleTypes.HEAVY_TANK:
               return this.heavy;
            case VehicleTypes.AT_SPG:
               return this.at_spg;
            case VehicleTypes.SPG:
               return this.spg;
            default:
               return new DataProvider();
         }
      }
   }
}
