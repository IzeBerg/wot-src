package net.wg.gui.battle.ranked.stats.components.playersPanel.list
{
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRankedPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersListItemHolder;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
   
   public class PlayersPanelListItemHolder extends BasePlayersListItemHolder
   {
       
      
      private var _rankedListItem:IRankedPlayersPanelListItem = null;
      
      public function PlayersPanelListItemHolder(param1:PlayersPanelListItem)
      {
         this._rankedListItem = IRankedPlayersPanelListItem(param1);
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._rankedListItem = null;
         super.onDispose();
      }
      
      override protected function updateListItemVehicleDataValues() : void
      {
         var _loc1_:RankedDAAPIVehicleInfoVO = RankedDAAPIVehicleInfoVO(vehicleData);
         this._rankedListItem.setRankIcon(_loc1_.division,_loc1_.level,_loc1_.isGroup);
      }
   }
}
