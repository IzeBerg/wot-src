package net.wg.gui.battle.components.buttons
{
   import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
   
   public class BattleToolTipButton extends BattleButton implements IBattleToolTipButton
   {
       
      
      protected var _isTooltipVisible:Boolean = false;
      
      protected var _isAllowedToShowTooltipOnDisabled:Boolean = false;
      
      protected var _hideToolTipOnClickActions:Boolean = true;
      
      protected var _tooltipStr:String = "";
      
      private var _isTooltipSpecial:Boolean = false;
      
      public function BattleToolTipButton()
      {
         super();
      }
      
      override protected function invokeReleaseOutsideActions() : void
      {
         this.tryToHideTooltip();
         super.invokeReleaseOutsideActions();
      }
      
      override protected function invokeReleaseActions() : void
      {
         this.tryToHideTooltip();
         super.invokeReleaseActions();
      }
      
      override protected function invokePressActions() : void
      {
         this.tryToHideTooltip();
         super.invokePressActions();
      }
      
      override protected function invokeRollOutActions() : void
      {
         this.hideTooltip();
         super.invokeRollOutActions();
      }
      
      override protected function invokeRollOverActions() : void
      {
         if(enabled || this.isAllowedToShowToolTipOnDisabledState)
         {
            this.showTooltip();
         }
         super.invokeRollOverActions();
      }
      
      protected function showSpecialTooltip() : void
      {
         App.toolTipMgr.showSpecial(this._tooltipStr,null);
      }
      
      protected function showTooltip() : void
      {
         if(!this._isTooltipVisible)
         {
            this._isTooltipVisible = true;
            if(this.isTooltipSpecial)
            {
               this.showSpecialTooltip();
            }
            else
            {
               App.toolTipMgr.showComplex(this._tooltipStr);
            }
         }
      }
      
      private function tryToHideTooltip() : void
      {
         if(this.hideToolTipOnClickActions)
         {
            this.hideTooltip();
         }
      }
      
      private function hideTooltip() : void
      {
         if(this._isTooltipVisible)
         {
            this._isTooltipVisible = false;
            App.toolTipMgr.hide();
         }
      }
      
      private function updateMouseEnabled() : void
      {
         mouseEnabled = !!this.isAllowedToShowToolTipOnDisabledState ? Boolean(true) : Boolean(enabled);
      }
      
      public function get isAllowedToShowToolTipOnDisabledState() : Boolean
      {
         return this._isAllowedToShowTooltipOnDisabled;
      }
      
      public function set isAllowedToShowToolTipOnDisabledState(param1:Boolean) : void
      {
         this._isAllowedToShowTooltipOnDisabled = param1;
         this.updateMouseEnabled();
      }
      
      public function get tooltipStr() : String
      {
         return this._tooltipStr;
      }
      
      public function set tooltipStr(param1:String) : void
      {
         this._tooltipStr = param1;
      }
      
      public function get isTooltipSpecial() : Boolean
      {
         return this._isTooltipSpecial;
      }
      
      public function set isTooltipSpecial(param1:Boolean) : void
      {
         this._isTooltipSpecial = param1;
      }
      
      private function get allowShowTooltip() : Boolean
      {
         return !!this.isAllowedToShowToolTipOnDisabledState ? Boolean(true) : Boolean(enabled);
      }
      
      public function get hideToolTipOnClickActions() : Boolean
      {
         return this._hideToolTipOnClickActions;
      }
      
      public function set hideToolTipOnClickActions(param1:Boolean) : void
      {
         this._hideToolTipOnClickActions = param1;
      }
   }
}
