package net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PlayersPanelSwitchBase;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   
   public class PlayersPanelSwitch extends PlayersPanelSwitchBase implements IClickButtonHandler
   {
       
      
      public var bgMC:BattleAtlasSprite = null;
      
      public function PlayersPanelSwitch()
      {
         super();
         hidenBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_NONE;
         shortBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_SHORT;
         mediumBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_MEDIUM;
         longBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_MEDIUM2;
         fullBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_LARGE;
      }
      
      override public function onButtonClick(param1:Object) : void
      {
         var _loc2_:PlayersPanelSwitchButton = PlayersPanelSwitchButton(param1);
         dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,_loc2_.panelState));
      }
      
      override public function setState(param1:int) : void
      {
         if(param1 == state)
         {
            return;
         }
         if(selectedBt)
         {
            selectedBt.selected = false;
         }
         switch(param1)
         {
            case PLAYERS_PANEL_STATE.HIDDEN:
               selectedBt = hidenBt;
               break;
            case PLAYERS_PANEL_STATE.SHORT:
               selectedBt = shortBt;
               break;
            case PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES:
            case PLAYERS_PANEL_STATE.MEDIUM:
               selectedBt = mediumBt;
               break;
            case PLAYERS_PANEL_STATE.LONG:
               selectedBt = longBt;
               break;
            case PLAYERS_PANEL_STATE.FULL_NO_BADGES:
            case PLAYERS_PANEL_STATE.FULL:
               selectedBt = fullBt;
               break;
            default:
               throw new Error("setting of invalid _state \'" + param1 + "\'");
         }
         selectedBt.selected = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bgMC.imageName = BATTLEATLAS.PLAYERS_PANEL_SWITCH_BG;
         hidenBt.panelState = PLAYERS_PANEL_STATE.HIDDEN;
         shortBt.panelState = PLAYERS_PANEL_STATE.SHORT;
         mediumBt.panelState = PLAYERS_PANEL_STATE.MEDIUM;
         longBt.panelState = PLAYERS_PANEL_STATE.LONG;
         fullBt.panelState = PLAYERS_PANEL_STATE.FULL;
      }
      
      override protected function onDispose() : void
      {
         this.bgMC = null;
         super.onDispose();
      }
   }
}
