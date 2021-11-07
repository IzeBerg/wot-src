package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.panelSwitch
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButton;
   import scaleform.gfx.MouseEventEx;
   
   public class PlayersPanelSwitchButtonEx extends PlayersPanelSwitchButton
   {
       
      
      public function PlayersPanelSwitchButtonEx()
      {
         super();
      }
      
      override protected function invokeReleaseActions() : void
      {
         super.invokeReleaseActions();
         if(_toggle)
         {
            selected = !selected;
         }
      }
      
      override protected function getStateImageName(param1:int) : String
      {
         switch(param1)
         {
            case PLAYERS_PANEL_STATE.HIDDEN:
               return BATTLEATLAS.EPIC_RANDOM_SWITCH_BT_HIDDEN;
            case PLAYERS_PANEL_STATE.SHORT:
               return BATTLEATLAS.EPIC_RANDOM_SWITCH_BT_SHORT;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER:
               return BATTLEATLAS.EPIC_RANDOM_SWITCH_BT_PLAYERNAMES;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK:
               return BATTLEATLAS.EPIC_RANDOM_SWITCH_BT_TANKS;
            case PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_BUTTON:
               return BATTLEATLAS.EPIC_RANDOM_SWITCH_BT_3COLS;
            default:
               return null;
         }
      }
      
      override protected function isClickAllowed(param1:MouseEvent) : Boolean
      {
         if(!(param1 is MouseEventEx))
         {
            return true;
         }
         var _loc2_:uint = MouseEventEx(param1).buttonIdx;
         return _loc2_ == MouseEventEx.LEFT_BUTTON || _isRightClickAllowed && _loc2_ == MouseEventEx.RIGHT_BUTTON;
      }
   }
}
