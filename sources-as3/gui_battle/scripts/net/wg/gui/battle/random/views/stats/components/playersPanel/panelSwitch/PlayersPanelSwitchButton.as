package net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   
   public class PlayersPanelSwitchButton extends BattleToolTipButton
   {
      
      private static const FRAME_NAME_SEPARATOR:String = "_";
       
      
      public var typeSP:BattleAtlasSprite = null;
      
      protected var _toggle:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _type:int = 0;
      
      public function PlayersPanelSwitchButton()
      {
         super();
         this._type = PLAYERS_PANEL_STATE.NONE;
      }
      
      override protected function getFrameLabel(param1:String) : String
      {
         return !!this._selected ? InteractiveStates.SELECTED + FRAME_NAME_SEPARATOR + param1 : param1;
      }
      
      override protected function onDispose() : void
      {
         this.typeSP = null;
         super.onDispose();
      }
      
      protected function getStateImageName(param1:int) : String
      {
         switch(param1)
         {
            case PLAYERS_PANEL_STATE.HIDDEN:
               return BATTLEATLAS.PLAYERS_PANEL_SWITCH_BT_HIDDEN;
            case PLAYERS_PANEL_STATE.SHORT:
               return BATTLEATLAS.PLAYERS_PANEL_SWITCH_BT_SHORT;
            case PLAYERS_PANEL_STATE.MEDIUM:
               return BATTLEATLAS.PLAYERS_PANEL_SWITCH_BT_MEDIUM;
            case PLAYERS_PANEL_STATE.LONG:
               return BATTLEATLAS.PLAYERS_PANEL_SWITCH_BT_LONG;
            case PLAYERS_PANEL_STATE.FULL:
               return BATTLEATLAS.PLAYERS_PANEL_SWITCH_BT_FULL;
            default:
               return null;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         state = _buttonState;
      }
      
      public function get panelState() : int
      {
         return this._type;
      }
      
      public function set panelState(param1:int) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         var _loc2_:String = this.getStateImageName(param1);
         if(_loc2_)
         {
            this.typeSP.imageName = _loc2_;
         }
      }
      
      override protected function isClickAllowed(param1:MouseEvent) : Boolean
      {
         return !this.selected && super.isClickAllowed(param1);
      }
      
      public function get toggle() : Boolean
      {
         return this._toggle;
      }
      
      public function set toggle(param1:Boolean) : void
      {
         this._toggle = param1;
      }
   }
}
