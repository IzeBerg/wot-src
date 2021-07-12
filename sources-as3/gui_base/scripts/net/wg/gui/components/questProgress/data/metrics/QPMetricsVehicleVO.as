package net.wg.gui.components.questProgress.data.metrics
{
   import net.wg.data.constants.Errors;
   
   public class QPMetricsVehicleVO extends QPMetricsSimpleVO
   {
      
      private static const VEH_TYPES_ICONS_FIELD:String = "vehicleTypes";
       
      
      public var title:String = "";
      
      public var value:String = "";
      
      public var vehicleTypes:Vector.<String> = null;
      
      public function QPMetricsVehicleVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == VEH_TYPES_ICONS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            this.vehicleTypes = new Vector.<String>();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.vehicleTypes.push(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.vehicleTypes)
         {
            this.vehicleTypes.splice(0,this.vehicleTypes.length);
            this.vehicleTypes = null;
         }
         super.onDispose();
      }
   }
}
