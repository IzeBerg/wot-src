package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SummaryInitVO extends DAAPIDataClass
   {
      
      private static const COMMON_SCORES:String = "commonScores";
       
      
      public var significantAwardsLabel:String = "";
      
      public var significantAwardsErrorText:String = "";
      
      public var commonScores:SummaryCommonScoresVO;
      
      public function SummaryInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == COMMON_SCORES)
         {
            this.commonScores = new SummaryCommonScoresVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.commonScores.dispose();
         this.commonScores = null;
         super.onDispose();
      }
   }
}
