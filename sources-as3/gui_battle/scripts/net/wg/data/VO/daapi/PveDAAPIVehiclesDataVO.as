package net.wg.data.VO.daapi
{
   public class PveDAAPIVehiclesDataVO extends DAAPIVehiclesDataVO
   {
       
      
      public function PveDAAPIVehiclesDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case COND_LEFT_INFO_FIELD_NAME:
               leftVehicleInfos = Vector.<DAAPIVehicleInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,PveDAAPIVehicleInfoVO));
               return false;
            case COND_RIGHT_INFO_FIELD_NAME:
               rightVehicleInfos = Vector.<DAAPIVehicleInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,PveDAAPIVehicleInfoVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
   }
}
