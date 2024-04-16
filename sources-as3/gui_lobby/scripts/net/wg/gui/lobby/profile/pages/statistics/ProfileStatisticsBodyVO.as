package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.components.data.StatisticsBodyVO;
   import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsChartsTabDataVO;
   
   public class ProfileStatisticsBodyVO extends StatisticsBodyVO
   {
       
      
      public function ProfileStatisticsBodyVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function createItemData(param1:String, param2:Object) : StatisticsLabelLinkageDataVO
      {
         var _loc3_:StatisticsLabelLinkageDataVO = null;
         if(param1 == Linkages.CHART_STATISTICS_VIEW)
         {
            _loc3_ = new StatisticsChartsTabDataVO(param2);
         }
         else
         {
            _loc3_ = super.createItemData(param1,param2);
         }
         return _loc3_;
      }
   }
}
