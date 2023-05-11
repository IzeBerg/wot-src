package net.wg.gui.battle.comp7.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   
   public class Comp7DAAPIVehiclesStatsVO extends DAAPIVehiclesStatsVO
   {
       
      
      public function Comp7DAAPIVehiclesStatsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case COND_LEFT_FIELD_NAME:
               leftFrags = Vector.<DAAPIVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1,param2,Comp7DAAPIVehicleStatsVO));
               return false;
            case COND_RIGHT_FIELD_NAME:
               rightFrags = Vector.<DAAPIVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1,param2,Comp7DAAPIVehicleStatsVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
   }
}
