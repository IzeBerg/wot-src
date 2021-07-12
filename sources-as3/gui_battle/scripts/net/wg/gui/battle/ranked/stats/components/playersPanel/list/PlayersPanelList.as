package net.wg.gui.battle.ranked.stats.components.playersPanel.list
{
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class PlayersPanelList extends BasePlayersPanelList
   {
       
      
      public function PlayersPanelList()
      {
         super();
      }
      
      override public function getItemHolderClass() : Class
      {
         return PlayersPanelListItemHolder;
      }
      
      override protected function onPlayersListItemRightClick(param1:PlayersPanelItemEvent) : void
      {
         super.onPlayersListItemRightClick(param1);
         var _loc2_:IPlayersPanelListItemHolder = getItemHolderByIndex(param1.holderItemID);
         App.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL,this,new PlayersPanelContextMenuSentData(_loc2_.vehicleID));
         MinimapEntryController.instance.unhighlight();
         App.toolTipMgr.hide();
      }
   }
}
