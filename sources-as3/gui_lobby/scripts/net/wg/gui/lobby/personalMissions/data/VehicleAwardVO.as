package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleAwardVO extends DAAPIDataClass
   {
      
      private static const FIELD_SLOTS:String = "slots";
      
      private static const FIELD_VEHICLE_SLOT:String = "vehicleSlotData";
       
      
      public var slots:Vector.<PersonalMissionsItemSlotVO> = null;
      
      public var vehicleSlotData:PersonalMissionsVehicleSlotVO = null;
      
      public function VehicleAwardVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.slots)
         {
            for each(_loc1_ in this.slots)
            {
               _loc1_.dispose();
            }
            this.slots.splice(0,this.slots.length);
            this.slots = null;
         }
         this.vehicleSlotData.dispose();
         this.vehicleSlotData = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == FIELD_SLOTS)
         {
            _loc3_ = param2 as Array;
            if(_loc3_)
            {
               this.slots = new Vector.<PersonalMissionsItemSlotVO>();
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.slots.push(new PersonalMissionsItemSlotVO(_loc3_[_loc5_]));
                  _loc5_++;
               }
            }
            return false;
         }
         if(param1 == FIELD_VEHICLE_SLOT)
         {
            this.vehicleSlotData = new PersonalMissionsVehicleSlotVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function getVehicleId() : String
      {
         return Boolean(this.vehicleSlotData) ? this.vehicleSlotData.vehicleId : "";
      }
   }
}
