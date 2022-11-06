package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedRewardYearItemVO extends DAAPIDataClass
   {
      
      private static const POINTS_FIELD:String = "points";
       
      
      public var id:String = "";
      
      public var status:String = "";
      
      public var statusText:String = "";
      
      public var points:RankedRewardYearItemPointsVO = null;
      
      public function RankedRewardYearItemVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == POINTS_FIELD)
         {
            this.points = new RankedRewardYearItemPointsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.points)
         {
            this.points.dispose();
            this.points = null;
         }
         super.onDispose();
      }
   }
}
