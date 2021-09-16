package net.wg.gui.battle.views.damagePanel.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class DamagePanelItemFrameStates extends BattleUIComponent
   {
       
      
      private var _state:String = "normal";
      
      private var _alwaysVisible:Boolean = false;
      
      public function DamagePanelItemFrameStates()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.applyState();
            visible = this.calcVisibility();
         }
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state != param1)
         {
            this.setStateManually(param1);
         }
      }
      
      public function get alwaysVisible() : Boolean
      {
         return this._alwaysVisible;
      }
      
      public function set alwaysVisible(param1:Boolean) : void
      {
         this._alwaysVisible = param1;
         invalidateState();
      }
      
      protected function setStateManually(param1:String) : void
      {
         this._state = param1;
         invalidateState();
      }
      
      protected function calcVisibility() : Boolean
      {
         return this.state != BATTLE_ITEM_STATES.NORMAL || this._alwaysVisible;
      }
      
      protected function applyState() : void
      {
         gotoAndPlay(this._state);
      }
   }
}
