package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
   import flash.events.Event;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelList;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
   
   public class PlayersPanelList extends BasePlayersPanelList
   {
       
      
      public var inviteReceivedIndicator:InviteReceivedIndicator;
      
      private var _isInviteReceived:Boolean = false;
      
      private var _isInteractive:Boolean = false;
      
      private var _isInviteShown:Boolean = false;
      
      public function PlayersPanelList()
      {
         super();
         this.inviteReceivedIndicator.visible = false;
      }
      
      override public function getItemHolderClass() : Class
      {
         return PlayersPanelListItemHolder;
      }
      
      override public function setInvitationStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IPlayersPanelListItemHolder = getHolderByVehicleID(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.setInvitationStatus(param2);
         if(_loc3_.isInviteReceived)
         {
            this._isInviteReceived = true;
         }
         else
         {
            this._isInviteReceived = checkInviteReceived();
         }
         this.updateInviteIndicator();
         dispatchEvent(new Event(Event.CHANGE,true));
      }
      
      override public function setIsInteractive(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._isInteractive == param1)
         {
            return;
         }
         this._isInteractive = param1;
         for each(_loc2_ in panelListItems)
         {
            _loc2_.setIsInteractive(param1);
         }
      }
      
      override public function setIsInviteShown(param1:Boolean) : void
      {
         var _loc2_:PlayersPanelListItem = null;
         if(this._isInviteShown == param1)
         {
            return;
         }
         this._isInviteShown = param1;
         for each(_loc2_ in panelListItems)
         {
            _loc2_.setIsInviteShown(param1);
         }
      }
      
      override protected function updateVehicleData() : void
      {
         super.updateVehicleData();
         this.updateInviteIndicator();
      }
      
      override protected function onDispose() : void
      {
         this.inviteReceivedIndicator.dispose();
         this.inviteReceivedIndicator = null;
         super.onDispose();
      }
      
      override protected function initializeListItem(param1:IPlayersPanelListItem) : void
      {
         super.initializeListItem(param1);
         param1.setIsInviteShown(this._isInviteShown);
         param1.setIsInteractive(this._isInteractive);
      }
      
      override protected function initializeState() : void
      {
         super.initializeState();
         this.updateInviteIndicator();
      }
      
      private function updateInviteIndicator() : void
      {
         this.inviteReceivedIndicator.visible = state == PLAYERS_PANEL_STATE.HIDDEN && this._isInviteReceived;
      }
      
      override public function get isInviteReceived() : Boolean
      {
         return this._isInviteReceived;
      }
      
      override protected function onPlayersListItemRightClick(param1:PlayersPanelItemEvent) : void
      {
         super.onPlayersListItemRightClick(param1);
         var _loc2_:IPlayersPanelListItemHolder = getItemHolderByIndex(param1.holderItemID);
         var _loc3_:PlayersPanelDynamicSquad = IRandomPlayersPanelListItem(param1.playersListItem).getDynamicSquad();
         _loc3_.onItemOut();
         dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,_loc2_.vehicleID));
      }
   }
}
