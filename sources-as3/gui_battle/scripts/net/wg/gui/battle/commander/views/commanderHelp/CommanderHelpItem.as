package net.wg.gui.battle.commander.views.commanderHelp
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIHelpVO;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
   
   public class CommanderHelpItem extends BattleToolTipButton implements IBattleToolTipButton
   {
       
      
      public var keyMC:ButtonKeyContainer = null;
      
      public var hit:MovieClip = null;
      
      public var commandIconMC:MovieClip = null;
      
      public var activationMC:MovieClip = null;
      
      private var _voData:DAAPIHelpVO = null;
      
      private var _isActivated:Boolean = false;
      
      private var _isPressed:Boolean = false;
      
      private var _isDisabled:Boolean = false;
      
      public function CommanderHelpItem()
      {
         super();
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
      }
      
      override protected function onDispose() : void
      {
         this._voData.dispose();
         this._voData = null;
         this.keyMC.dispose();
         this.keyMC = null;
         this.commandIconMC = null;
         this.hit = null;
         if(this.activationMC)
         {
            this.activationMC.stop();
            this.activationMC = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.mouseEnabled = false;
         hitArea = this.hit;
      }
      
      override protected function showSpecialTooltip() : void
      {
         App.toolTipMgr.showSpecial(_tooltipStr,null,this._voData.orderIcon);
      }
      
      public function getHelpVO() : DAAPIHelpVO
      {
         return this._voData;
      }
      
      public function isDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      public function setData(param1:DAAPIHelpVO) : void
      {
         this._voData = param1;
         tooltipStr = param1.tooltipStr;
         this.keyMC.setKeyValue(param1.keyID,param1.keyText,param1.isModifier);
         this.commandIconMC.gotoAndStop(param1.orderIcon);
         if(param1.isModifier)
         {
            this.hit.mouseEnabled = this.hit.mouseChildren = false;
            this.keyMC.mouseEnabled = this.keyMC.mouseChildren = false;
            this.commandIconMC.mouseEnabled = this.commandIconMC.mouseChildren = false;
         }
      }
      
      public function updateButtonState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1 == this._isActivated && param2 == this._isPressed && param3 == this._isDisabled)
         {
            return;
         }
         this._isActivated = param1;
         this._isPressed = param2;
         this._isDisabled = param3;
         if(this._isDisabled)
         {
            this.state = InteractiveStates.DISABLED;
         }
         else
         {
            this.state = !!this._isActivated ? InteractiveStates.DOWN : InteractiveStates.UP;
         }
      }
      
      override public function set state(param1:String) : void
      {
         if(this.getHelpVO().isModifier && param1 == InteractiveStates.DOWN)
         {
            return;
         }
         this.keyMC.setActiveState(this._isPressed || param1 == InteractiveStates.DOWN);
         if(param1 == InteractiveStates.DOWN && !this.getHelpVO().isModifier)
         {
            this.activationMC.gotoAndPlay(1);
         }
         if(this._isActivated && param1 != InteractiveStates.DOWN || this._isDisabled && super.state == InteractiveStates.DISABLED)
         {
            return;
         }
         super.state = param1;
      }
   }
}
