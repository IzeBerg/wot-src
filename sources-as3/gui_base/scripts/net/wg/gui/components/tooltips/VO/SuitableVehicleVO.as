package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SuitableVehicleVO extends DAAPIDataClass implements IDisposable
   {
       
      
      public var toolTipType:String = "cyberSportSlot";
      
      public var leftCount:uint = 0;
      
      public var vehiclesList:Vector.<VehicleVO> = null;
      
      public var conditions:Array = null;
      
      public var isCreator:Boolean = false;
      
      private const MAX_VEHICLES:uint = 5;
      
      public function SuitableVehicleVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:VehicleVO = null;
         switch(param1)
         {
            case "vehicles":
               if(App.instance)
               {
                  App.utils.asserter.assert(param2 is Array,"value must extends an Array class.");
               }
               _loc3_ = null;
               if(param2)
               {
                  if((param2 as Array).length > 0)
                  {
                     _loc3_ = param2 as Array;
                  }
               }
               else
               {
                  _loc3_ = null;
               }
               _loc4_ = 0;
               if(_loc3_ && _loc3_.length > 0)
               {
                  this.vehiclesList = new Vector.<VehicleVO>();
                  _loc4_ = 0;
                  while(_loc4_ < this.MAX_VEHICLES && _loc4_ < _loc3_.length)
                  {
                     _loc6_ = new VehicleVO(_loc3_[_loc4_]);
                     this.vehiclesList.push(_loc6_);
                     _loc4_++;
                  }
                  this.leftCount = _loc3_.length - _loc4_ > 0 ? uint(_loc3_.length - _loc4_) : uint(0);
               }
               return false;
            case "conditions":
               if(App.instance)
               {
                  App.utils.asserter.assert(param2 is Array,"value must extends an Array class.");
               }
               if(param2)
               {
                  if((param2 as Array).length > 0)
                  {
                     this.conditions = param2 as Array;
                  }
               }
               else
               {
                  this.conditions = null;
               }
               _loc5_ = true;
               if(this.conditions)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this.conditions.length)
                  {
                     if(this.conditions[_loc4_] != null)
                     {
                        _loc5_ = false;
                        break;
                     }
                     _loc4_++;
                  }
               }
               if(_loc5_)
               {
                  this.conditions = null;
               }
               return false;
            default:
               return true;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleVO = null;
         if(this.vehiclesList && this.vehiclesList.length > 0)
         {
            while(this.vehiclesList.length)
            {
               _loc1_ = this.vehiclesList.pop();
               _loc1_ = null;
            }
         }
         this.vehiclesList = null;
         this.conditions = null;
      }
   }
}
