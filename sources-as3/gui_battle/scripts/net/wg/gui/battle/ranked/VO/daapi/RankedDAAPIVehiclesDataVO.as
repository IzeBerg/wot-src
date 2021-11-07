package net.wg.gui.battle.ranked.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   
   public class RankedDAAPIVehiclesDataVO extends DAAPIVehiclesDataVO
   {
       
      
      public function RankedDAAPIVehiclesDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case COND_LEFT_INFO_FIELD_NAME:
               leftVehicleInfos = Vector.<DAAPIVehicleInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,RankedDAAPIVehicleInfoVO));
               return false;
            case COND_RIGHT_INFO_FIELD_NAME:
               rightVehicleInfos = Vector.<DAAPIVehicleInfoVO>(App.utils.data.convertVOArrayToVector(param1,param2,RankedDAAPIVehicleInfoVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
   }
}
