package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.panelSwitch
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.PlayersPanelSwitchBase;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButton;
   
   public class PlayersPanelSwitch extends PlayersPanelSwitchBase implements IClickButtonHandler
   {
      
      private static const STATES_MAP:Dictionary = new Dictionary();
      
      private static const ERROR_INVALID_STATE:String = "[PlayersPanelSwitch] State not supported ";
      
      {
         STATES_MAP[PLAYERS_PANEL_STATE.HIDDEN] = PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN;
         STATES_MAP[PLAYERS_PANEL_STATE.SHORT] = PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER] = PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK] = PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN] = PLAYERS_PANEL_STATE.HIDDEN;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT] = PLAYERS_PANEL_STATE.SHORT;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS] = PLAYERS_PANEL_STATE.SHORT;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS] = PLAYERS_PANEL_STATE.SHORT;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER;
         STATES_MAP[PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS] = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK;
      }
      
      private var _extendedState:Boolean = false;
      
      public function PlayersPanelSwitch()
      {
         super();
         hidenBt.tooltipStr = INGAME_GUI.EPIC_PLAYERS_PANEL_STATE_HIDDEN;
         shortBt.tooltipStr = INGAME_GUI.EPIC_PLAYERS_PANEL_STATE_SHORT;
         mediumBt.tooltipStr = INGAME_GUI.EPIC_PLAYERS_PANEL_STATE_MEDIUM_PLAYER;
         longBt.tooltipStr = INGAME_GUI.EPIC_PLAYERS_PANEL_STATE_MEDIUM_TANK;
         fullBt.tooltipStr = INGAME_GUI.EPIC_PLAYERS_PANEL_STATE_TOGGLE;
         selectedBt = fullBt;
      }
      
      override public function onButtonClick(param1:Object) : void
      {
         var _loc2_:PlayersPanelSwitchButton = PlayersPanelSwitchButton(param1);
         if(_loc2_ == fullBt)
         {
            dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,STATES_MAP[state]));
         }
         else
         {
            dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,!!this._extendedState ? int(STATES_MAP[_loc2_.panelState]) : int(_loc2_.panelState)));
         }
      }
      
      override public function setState(param1:int) : void
      {
         if(param1 == state)
         {
            return;
         }
         state = param1;
         selectedBt.selected = false;
         switch(param1)
         {
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN:
            case PLAYERS_PANEL_STATE.HIDDEN:
               selectedBt = hidenBt;
               break;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS:
            case PLAYERS_PANEL_STATE.SHORT:
               selectedBt = shortBt;
               break;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS:
               selectedBt = mediumBt;
               break;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS:
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS:
               selectedBt = longBt;
               break;
            default:
               throw new Error(ERROR_INVALID_STATE + param1);
         }
         selectedBt.selected = true;
         this._extendedState = param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN || PLAYERS_PANEL_STATE.EXTENDED_STATES.indexOf(param1) > -1;
         fullBt.selected = this._extendedState;
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(STATES_MAP);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hidenBt.panelState = PLAYERS_PANEL_STATE.HIDDEN;
         shortBt.panelState = PLAYERS_PANEL_STATE.SHORT;
         mediumBt.panelState = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER;
         longBt.panelState = PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK;
         fullBt.panelState = PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_BUTTON;
         fullBt.toggle = true;
      }
   }
}
