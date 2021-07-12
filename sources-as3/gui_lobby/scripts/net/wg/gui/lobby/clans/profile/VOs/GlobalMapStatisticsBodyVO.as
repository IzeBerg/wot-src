package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.lobby.components.data.StatisticsBodyVO;
   import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
   
   public class GlobalMapStatisticsBodyVO extends StatisticsBodyVO
   {
       
      
      public function GlobalMapStatisticsBodyVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function createItemData(param1:String, param2:Object) : StatisticsLabelLinkageDataVO
      {
         var _loc3_:StatisticsLabelLinkageDataVO = null;
         if(param1 == CLANS_ALIASES.CLAN_PROFILE_TABLE_STATISTICS_VIEW_LINKAGE)
         {
            _loc3_ = new StatisticsLabelLinkageDataVO(param2);
         }
         else
         {
            _loc3_ = super.createItemData(param1,param2);
         }
         return _loc3_;
      }
   }
}
