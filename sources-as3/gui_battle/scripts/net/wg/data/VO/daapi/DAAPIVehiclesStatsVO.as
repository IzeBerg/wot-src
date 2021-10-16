package net.wg.data.VO.daapi
{
   import flash.utils.getQualifiedClassName;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehiclesStatsVO extends DAAPIDataClass
   {
      
      private static const COND_LEFT_FIELD_NAME:String = "leftItems";
      
      private static const COND_RIGHT_FIELD_NAME:String = "rightItems";
      
      private static const TOTAL_STATS_FIELD_NAME:String = "totalStats";
       
      
      public var leftFrags:Vector.<DAAPIVehicleStatsVO> = null;
      
      public var rightFrags:Vector.<DAAPIVehicleStatsVO> = null;
      
      public var totalStats:DAAPITotalStatsVO = null;
      
      public function DAAPIVehiclesStatsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case COND_LEFT_FIELD_NAME:
               this.leftFrags = Vector.<DAAPIVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIVehicleStatsVO));
               return false;
            case COND_RIGHT_FIELD_NAME:
               this.rightFrags = Vector.<DAAPIVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPIVehicleStatsVO));
               return false;
            case TOTAL_STATS_FIELD_NAME:
               this.totalStats = new DAAPITotalStatsVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPIVehicleStatsVO = null;
         if(this.leftFrags)
         {
            for each(_loc1_ in this.leftFrags)
            {
               _loc1_.dispose();
            }
            this.leftFrags.fixed = false;
            this.leftFrags.splice(0,this.leftFrags.length);
            this.leftFrags = null;
         }
         if(this.rightFrags)
         {
            for each(_loc1_ in this.rightFrags)
            {
               _loc1_.dispose();
            }
            this.rightFrags.fixed = false;
            this.rightFrags.splice(0,this.rightFrags.length);
            this.rightFrags = null;
         }
         if(this.totalStats)
         {
            this.totalStats.dispose();
            this.totalStats = null;
         }
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[" + getQualifiedClassName(this) + " > left: " + this.leftFrags + ", right:" + this.rightFrags + "]";
      }
   }
}
