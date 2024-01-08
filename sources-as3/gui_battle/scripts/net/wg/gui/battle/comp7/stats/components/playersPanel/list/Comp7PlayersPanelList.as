package net.wg.gui.battle.comp7.stats.components.playersPanel.list
{
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelList;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class Comp7PlayersPanelList extends BasePlayersPanelList implements IComp7PlayersPanelList
   {
       
      
      public function Comp7PlayersPanelList()
      {
         super();
      }
      
      override public function getItemHolderClass() : Class
      {
         return Comp7PlayersPanelListItemHolder;
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         var _loc3_:Comp7PlayersPanelListItemHolder = getHolderByVehicleID(param1) as Comp7PlayersPanelListItemHolder;
         if(_loc3_ != null)
         {
            _loc3_.removePointOfInterest(param2);
         }
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO) : void
      {
         var _loc2_:Comp7PlayersPanelListItemHolder = getHolderByVehicleID(param1.vehicleID) as Comp7PlayersPanelListItemHolder;
         if(_loc2_ != null)
         {
            _loc2_.updatePointOfInterest(param1.type,param1.progress);
         }
      }
      
      override protected function onPlayersListItemRightClick(param1:PlayersPanelItemEvent) : void
      {
         var _loc2_:IPlayersPanelListItemHolder = getItemHolderByIndex(param1.holderItemID);
         App.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL,this,new PlayersPanelContextMenuSentData(_loc2_.vehicleID));
         MinimapEntryController.instance.unhighlight();
         App.toolTipMgr.hide();
      }
   }
}
