package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankShieldVO extends DAAPIDataClass
   {
      
      private static const FIELD_ANIMATION_DATA:String = "animationData";
       
      
      public var state:String = "";
      
      public var newState:String = "";
      
      public var prevLabel:String = "";
      
      public var label:String = "";
      
      public var size:String = "";
      
      public var img:String = "";
      
      public var plateImg:String = "";
      
      public var animationData:RankShieldAnimHelperVO = null;
      
      public function RankShieldVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_ANIMATION_DATA)
         {
            this.animationData = new RankShieldAnimHelperVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.animationData)
         {
            this.animationData.dispose();
            this.animationData = null;
         }
         super.onDispose();
      }
   }
}
