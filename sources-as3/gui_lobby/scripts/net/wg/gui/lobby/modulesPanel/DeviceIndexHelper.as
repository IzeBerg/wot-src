package net.wg.gui.lobby.modulesPanel
{
   import net.wg.data.constants.generated.FITTING_TYPES;
   
   public class DeviceIndexHelper
   {
       
      
      public function DeviceIndexHelper()
      {
         super();
      }
      
      public static function getDeviceIndex(param1:String) : int
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:int = FITTING_TYPES.MANDATORY_SLOTS.indexOf(param1);
         if(_loc2_ != -1)
         {
            return _loc2_;
         }
         for each(_loc3_ in FITTING_TYPES.MANDATORY_SLOTS_OVERRIDES)
         {
            _loc4_ = _loc3_[0];
            _loc5_ = _loc3_[1];
            if(_loc5_ == param1)
            {
               _loc2_ = FITTING_TYPES.MANDATORY_SLOTS.indexOf(_loc4_);
               if(_loc2_ != -1)
               {
                  return _loc2_;
               }
               App.utils.asserter.assert(false,"Undefined slotType: " + _loc4_);
            }
         }
         return -1;
      }
   }
}
