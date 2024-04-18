package net.wg.data.components
{
   import net.wg.data.VO.ContextItem;
   import net.wg.data.constants.ContextMenuConstants;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.ContextMenuVehicleVo;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.infrastructure.interfaces.IVehicleContextMenuGenerator;
   
   public class VehicleContextMenuGenerator implements IVehicleContextMenuGenerator
   {
      
      public static var VEHICLE_INFO:String = "vehicleInfo";
      
      public static var VEHICLE_SELL:String = "vehicleSell";
      
      public static var VEHICLE_RESEARCH:String = "vehicleResearch";
      
      public static var VEHICLE_CHECK:String = "vehicleCheck";
      
      public static var VEHICLE_UNCHECK:String = "vehicleUncheck";
      
      public static var VEHICLE_STATISTIC:String = "showVehicleStatistics";
      
      public static var VEHICLE_BUY:String = "vehicleBuy";
      
      public static var VEHICLE_REMOVE:String = "vehicleRemove";
      
      public static var COMPONENT_HANGAR:String = "hangar";
       
      
      public function VehicleContextMenuGenerator()
      {
         super();
      }
      
      public function generateData(param1:ContextMenuVehicleVo) : Vector.<IContextItem>
      {
         return this.getContextItems(param1);
      }
      
      private function getContextItems(param1:ContextMenuVehicleVo) : Vector.<IContextItem>
      {
         var _loc6_:Object = null;
         var _loc7_:* = null;
         var _loc8_:String = null;
         var _loc2_:Vector.<IContextItem> = new Vector.<IContextItem>();
         var _loc3_:Array = this.getVehicleMapForComponent(param1);
         App.utils.asserter.assertNotNull(_loc3_,"variable idsData:Map, method getContextItems, class VehicleContextMenuGenerator " + Errors.CANT_NULL);
         var _loc4_:Number = _loc3_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            for(_loc7_ in _loc6_)
            {
               if(_loc7_ != Values.EMPTY_STR)
               {
                  _loc8_ = _loc7_ == ContextMenuConstants.SEPARATE ? null : MENU.contextmenu(_loc7_);
                  _loc2_.push(new ContextItem(_loc7_,_loc8_,_loc6_[_loc7_]));
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function getVehicleMapForComponent(param1:ContextMenuVehicleVo) : Array
      {
         switch(param1.component)
         {
            case VehicleContextMenuGenerator.COMPONENT_HANGAR:
               return this.getHangarMap(param1);
            default:
               return null;
         }
      }
      
      private function getHangarMap(param1:ContextMenuVehicleVo) : Array
      {
         var _loc2_:Array = [VEHICLE_INFO,{},VEHICLE_STATISTIC,{"enabled":param1.wasInBattle},ContextMenuConstants.SEPARATE,{}];
         if(param1.isRented)
         {
            if(!param1.isPremiumIGR)
            {
               _loc2_.push(VEHICLE_BUY);
               _loc2_.push({"enabled":param1.canBuyOrRent});
            }
            _loc2_.push(VEHICLE_REMOVE);
            _loc2_.push({"enabled":param1.rentalIsOver && param1.canSell});
         }
         else
         {
            _loc2_.push(VEHICLE_SELL);
            _loc2_.push({"enabled":param1.canSell});
         }
         _loc2_.push(ContextMenuConstants.SEPARATE);
         _loc2_.push({});
         _loc2_.push(VEHICLE_RESEARCH);
         _loc2_.push({});
         if(param1.favorite)
         {
            _loc2_.push(VEHICLE_UNCHECK);
         }
         else
         {
            _loc2_.push(VEHICLE_CHECK);
         }
         _loc2_.push({});
         return App.utils.data.createMappedArray(_loc2_);
      }
   }
}
