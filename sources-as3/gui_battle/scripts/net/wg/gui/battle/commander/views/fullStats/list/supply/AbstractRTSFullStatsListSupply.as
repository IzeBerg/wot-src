package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   import net.wg.gui.battle.commander.VO.daapi.DAAPISupplyInfoVO;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsListSupply;
   import net.wg.gui.battle.commander.views.fullStats.list.base.AbstractRTSFullStatsList;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class AbstractRTSFullStatsListSupply extends AbstractRTSFullStatsList implements IRTSFullStatsListSupply
   {
       
      
      public function AbstractRTSFullStatsListSupply()
      {
         super();
      }
      
      override protected function getItemID(param1:IDAAPIDataClass) : Number
      {
         return DAAPISupplyInfoVO(param1).supplyID;
      }
   }
}
