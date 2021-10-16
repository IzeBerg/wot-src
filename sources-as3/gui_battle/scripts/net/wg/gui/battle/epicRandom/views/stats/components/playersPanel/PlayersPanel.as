package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehiclesDataVO;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IEpicPlayersPanelList;
   import net.wg.infrastructure.base.meta.IEpicRandomPlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicRandomPlayersPanelMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class PlayersPanel extends EpicRandomPlayersPanelMeta implements IEpicRandomPlayersPanelMeta
   {
      
      private static const MIDDLE_COLUMN:int = 1;
      
      private static const OUTER_COLUMN:int = 2;
       
      
      private var _listLeftEpic:IEpicPlayersPanelList = null;
      
      private var _listRightEpic:IEpicPlayersPanelList = null;
      
      public function PlayersPanel()
      {
         super();
         isPlayerSwitchingAllowed = false;
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._listLeftEpic = IEpicPlayersPanelList(listLeft);
         this._listRightEpic = IEpicPlayersPanelList(listRight);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._listLeftEpic.addEventListener(PlayersPanelListEvent.ITEMS_GROUP_CHANGED,this.onListItemsGroupChangedHandler);
         this._listLeftEpic.addEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,this.onListLeftEpicItemsCountChangeHandler);
         this._listLeftEpic.addEventListener(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,this.onListItemsGroupMouseOverChangedHandler);
         this._listRightEpic.addEventListener(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,this.onListItemsGroupMouseOverChangedHandler);
         this._listRightEpic.addEventListener(PlayersPanelListEvent.ITEMS_GROUP_CHANGED,this.onListItemsGroupChangedHandler);
         this._listLeftEpic.updateColorBlind();
         this._listRightEpic.updateColorBlind();
      }
      
      override protected function onDispose() : void
      {
         this._listLeftEpic.removeEventListener(PlayersPanelListEvent.ITEMS_GROUP_CHANGED,this.onListItemsGroupChangedHandler);
         this._listLeftEpic.removeEventListener(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,this.onListLeftEpicItemsCountChangeHandler);
         this._listLeftEpic.removeEventListener(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,this.onListItemsGroupMouseOverChangedHandler);
         this._listRightEpic.removeEventListener(PlayersPanelListEvent.ITEMS_GROUP_MOUSE_OVER_CHANGED,this.onListItemsGroupMouseOverChangedHandler);
         this._listRightEpic.removeEventListener(PlayersPanelListEvent.ITEMS_GROUP_CHANGED,this.onListItemsGroupChangedHandler);
         this._listLeftEpic = null;
         this._listRightEpic = null;
         super.onDispose();
      }
      
      override protected function setListsState(param1:int) : void
      {
         if(state == param1)
         {
            return;
         }
         this._listLeftEpic.state = param1;
         this._listRightEpic.state = param1;
         state = param1;
         dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,param1));
      }
      
      override protected function applyVehicleData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:EpicRandomDAAPIVehiclesDataVO = EpicRandomDAAPIVehiclesDataVO(param1);
         this._listLeftEpic.setVehicleData(_loc2_.leftVehicleInfos);
         this._listLeftEpic.updateOrder(_loc2_.leftVehiclesIDs);
         this._listRightEpic.selectedPlayerGroup = this._listLeftEpic.selectedPlayerGroup;
         this._listRightEpic.setVehicleData(_loc2_.rightVehicleInfos);
         this._listRightEpic.updateOrder(_loc2_.rightVehiclesIDs);
      }
      
      public function as_setPlayersSwitchingAllowed(param1:Boolean) : void
      {
         isPlayerSwitchingAllowed = param1;
      }
      
      private function updateColumnAndStateLayout(param1:int) : void
      {
         if(PLAYERS_PANEL_STATE.EXTENDED_STATES.indexOf(state) > -1)
         {
            currentColumnOver = param1;
            if(param1 == MIDDLE_COLUMN)
            {
               this.setListsState(PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS);
            }
            else if(param1 == OUTER_COLUMN)
            {
               this.setListsState(PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS);
            }
            else
            {
               this.setListsState(PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER);
            }
         }
      }
      
      override protected function onListItemSelected(param1:PlayersPanelListEvent) : void
      {
         if(!isPlayerSwitchingAllowed)
         {
            focusedColumnChangedS(param1.group);
         }
         if(param1.group != currentColumnOver)
         {
            this.updateColumnAndStateLayout(param1.group);
         }
      }
      
      override protected function onListRollOver(param1:MouseEvent) : void
      {
         if(PLAYERS_PANEL_STATE.EXTENDED_STATES.indexOf(state) == -1 && state != PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER)
         {
            this.setListsState(PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER);
         }
      }
      
      override protected function onListRollOut(param1:MouseEvent) : void
      {
         if(state == PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER)
         {
            this.setListsState(expandState);
         }
         else if(state == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER || state == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS || state == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS)
         {
            this.setListsState(expandState);
            currentColumnOver = -1;
         }
         expandState = PLAYERS_PANEL_STATE.NONE;
      }
      
      override protected function onListItemContextMenuOpen(param1:PlayersPanelListEvent) : void
      {
         if(param1.group > -1 && param1.group != currentColumnOver)
         {
            this.updateColumnAndStateLayout(param1.group);
         }
      }
      
      private function onListLeftEpicItemsCountChangeHandler(param1:PlayersPanelListEvent) : void
      {
         dispatchEvent(new PlayersPanelEvent(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE));
      }
      
      private function onListItemsGroupChangedHandler(param1:PlayersPanelListEvent) : void
      {
         this._listLeftEpic.setAndSortByGroup(param1.group,param1.vehicleID);
         this._listRightEpic.setAndSortByGroup(param1.group,param1.vehicleID);
      }
      
      private function onListItemsGroupMouseOverChangedHandler(param1:PlayersPanelListEvent) : void
      {
         if(param1.group != currentColumnOver && param1.group > -1 && !contextMenuMgr.isShown() && PLAYERS_PANEL_STATE.EXTENDED_STATES.indexOf(state) > -1)
         {
            this.updateColumnAndStateLayout(param1.group);
         }
      }
      
      override public function as_setChatCommandsVisibility(param1:Boolean) : void
      {
         this._listLeftEpic.setChatCommandVisibility(param1);
         this._listRightEpic.setChatCommandVisibility(param1);
      }
      
      override public function as_setPanelHPBarVisibilityState(param1:uint) : void
      {
         this._listLeftEpic.setPanelHPBarVisibilityState(param1);
         this._listRightEpic.setPanelHPBarVisibilityState(param1);
      }
   }
}
