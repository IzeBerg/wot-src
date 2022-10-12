package net.wg.gui.battle.comp7.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Comp7DAAPIVehicleStatsVO extends DAAPIVehicleStatsVO
   {
      
      private static const INTEREST_POINTS_FIELD_NAME:String = "interestPoints";
       
      
      private var _interestPoints:Vector.<Comp7InterestPointVO> = null;
      
      public function Comp7DAAPIVehicleStatsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == INTEREST_POINTS_FIELD_NAME)
         {
            this._interestPoints = Vector.<Comp7InterestPointVO>(App.utils.data.convertVOArrayToVector(param1,param2,Comp7InterestPointVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._interestPoints)
         {
            for each(_loc1_ in this._interestPoints)
            {
               _loc1_.dispose();
            }
            this._interestPoints.splice(0,this._interestPoints.length);
            this._interestPoints = null;
         }
         super.onDispose();
      }
      
      public function get interestPoints() : Vector.<Comp7InterestPointVO>
      {
         return this._interestPoints;
      }
   }
}
