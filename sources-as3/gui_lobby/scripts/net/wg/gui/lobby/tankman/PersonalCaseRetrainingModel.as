package net.wg.gui.lobby.tankman
{
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalCaseRetrainingModel implements IDisposable
   {
       
      
      public var vehicles:Array;
      
      public var lightTanks:DataProvider;
      
      public var mediumTanks:DataProvider;
      
      public var heavyTanks:DataProvider;
      
      public var AT_SPG:DataProvider;
      
      public var SPG:DataProvider;
      
      public var currentVehicle:PersonalCaseCurrentVehicle = null;
      
      public var nativeVehicle:Object = null;
      
      public var tankmanID:int;
      
      public var nationID:int;
      
      public var specializationLevel:Number;
      
      public var retrainButtonsData:Vector.<RetrainButtonVO>;
      
      public function PersonalCaseRetrainingModel(param1:Object)
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         this.lightTanks = new DataProvider();
         this.mediumTanks = new DataProvider();
         this.heavyTanks = new DataProvider();
         this.AT_SPG = new DataProvider();
         this.SPG = new DataProvider();
         super();
         this.vehicles = param1.vehicles;
         this.retrainButtonsData = new Vector.<RetrainButtonVO>(0);
         for each(_loc2_ in param1.retrainButtonsData)
         {
            this.retrainButtonsData.push(new RetrainButtonVO(_loc2_));
         }
         _loc3_ = param1.vehicles;
         _loc4_ = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            switch(_loc6_.vehicleType)
            {
               case VehicleTypes.LIGHT_TANK:
                  this.lightTanks.push(_loc6_);
                  break;
               case VehicleTypes.MEDIUM_TANK:
                  this.mediumTanks.push(_loc6_);
                  break;
               case VehicleTypes.HEAVY_TANK:
                  this.heavyTanks.push(_loc6_);
                  break;
               case VehicleTypes.AT_SPG:
                  this.AT_SPG.push(_loc6_);
                  break;
               case VehicleTypes.SPG:
                  this.SPG.push(_loc6_);
                  break;
               default:
                  DebugUtils.LOG_DEBUG("ERROR unknown tank type");
                  break;
            }
            _loc5_++;
         }
      }
      
      public function updateData(param1:PersonalCaseModel) : void
      {
         this.nationID = param1.nationID;
         this.tankmanID = param1.inventoryID;
         this.currentVehicle = param1.currentVehicle;
         this.nativeVehicle = param1.nativeVehicle;
         this.specializationLevel = param1.specializationLevel;
      }
      
      public function dispose() : void
      {
         var _loc1_:RetrainButtonVO = null;
         this.currentVehicle = null;
         this.nativeVehicle = null;
         for each(_loc1_ in this.retrainButtonsData)
         {
            _loc1_.dispose();
         }
         this.retrainButtonsData.length = 0;
         this.retrainButtonsData = null;
      }
   }
}
