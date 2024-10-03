package net.wg.gui.battle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesButtonEvent;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOptionalDeviceButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class BattleOptionalDeviceButton extends BattleToolTipButton implements IBattleOptionalDeviceButton
   {
       
      
      public var iconLoader:UILoaderAlt = null;
      
      public var glow:IBattleEquipmentButtonGlow = null;
      
      public var hit:MovieClip = null;
      
      private var _isEmpty:Boolean = false;
      
      private var _lockColorTransform:Boolean = false;
      
      private var _consumablesVO:ConsumablesVO;
      
      private var _intCD:int = -1;
      
      private var _delayColorTransform:ColorTransform = null;
      
      private var _isUsed:Boolean = false;
      
      public function BattleOptionalDeviceButton()
      {
         this._consumablesVO = new ConsumablesVO();
         super();
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
         enabled = false;
         state = InteractiveStates.UP;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.glow.removeEventListener(ConsumablesButtonEvent.GLOW_ON_IDLE_STATE,this.onGlowOnIdleStateHandler);
         this.glow.dispose();
         this.glow = null;
         this._consumablesVO = null;
         this._delayColorTransform = null;
         this.hit = null;
         super.onDispose();
      }
      
      override protected function showSpecialTooltip() : void
      {
         App.toolTipMgr.showSpecial(_tooltipStr,null,this._intCD,state);
      }
      
      public function flushColorTransform() : void
      {
         this._lockColorTransform = this._isEmpty;
         if(this._lockColorTransform)
         {
            this.clearColorTransform();
         }
         else
         {
            this.setColorTransform(this._delayColorTransform);
            this._delayColorTransform = null;
         }
      }
      
      public function clearColorTransform() : void
      {
         if(this._lockColorTransform)
         {
            return;
         }
         this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
      }
      
      public function clearCoolDownTime() : void
      {
         state = InteractiveStates.UP;
      }
      
      public function hideGlow() : void
      {
         this.glow.removeEventListener(ConsumablesButtonEvent.GLOW_ON_IDLE_STATE,this.onGlowOnIdleStateHandler);
         this.glow.hideGlow(false);
      }
      
      public function set activated(param1:Boolean) : void
      {
      }
      
      public function setUsed(param1:Boolean, param2:Boolean = false) : void
      {
         this._isUsed = param1;
         if(param2 && this._isUsed)
         {
            this._lockColorTransform = true;
            this.setDarkColorTransform();
         }
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         if(this._lockColorTransform)
         {
            this._delayColorTransform = param1;
            return;
         }
         if(param1)
         {
            this.iconLoader.transform.colorTransform = param1;
         }
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
      }
      
      public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         if(param1 > 0)
         {
            this.clearCoolDownTime();
            this._delayColorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
         }
         else
         {
            if(param1 == -1)
            {
               state = BATTLE_ITEM_STATES.PERMANENT;
            }
            else if(param1 == 0)
            {
               this.clearCoolDownTime();
            }
            this.flushColorTransform();
         }
      }
      
      public function setTimerSnapshot(param1:int, param2:Boolean) : void
      {
      }
      
      public function showGlow(param1:int) : void
      {
         this.glow.addEventListener(ConsumablesButtonEvent.GLOW_ON_IDLE_STATE,this.onGlowOnIdleStateHandler);
         this.glow.showGlow(param1,false);
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVO;
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.source = param1;
      }
      
      public function set key(param1:Number) : void
      {
      }
      
      public function set quantity(param1:int) : void
      {
      }
      
      public function get empty() : Boolean
      {
         return this._isEmpty;
      }
      
      public function set empty(param1:Boolean) : void
      {
         if(this._isEmpty == param1)
         {
            return;
         }
         this._isEmpty = param1;
         if(this._isEmpty)
         {
            state = InteractiveStates.EMPTY_UP;
         }
         else
         {
            state = InteractiveStates.UP;
            if(this.icon)
            {
               this.flushColorTransform();
            }
         }
      }
      
      public function get showConsumableBorder() : Boolean
      {
         return false;
      }
      
      public function set showConsumableBorder(param1:Boolean) : void
      {
      }
      
      public function set isReplay(param1:Boolean) : void
      {
      }
      
      public function get intCD() : int
      {
         return this._intCD;
      }
      
      public function set intCD(param1:int) : void
      {
         this._intCD = param1;
      }
      
      public function get icon() : String
      {
         return this.iconLoader.source;
      }
      
      public function updateLockedInformation(param1:int, param2:String) : void
      {
      }
      
      public function updateLevelInformation(param1:int) : void
      {
      }
      
      private function onGlowOnIdleStateHandler(param1:Event) : void
      {
         if(this._lockColorTransform)
         {
            return;
         }
         if(this._isUsed)
         {
            this.glow.removeEventListener(ConsumablesButtonEvent.GLOW_ON_IDLE_STATE,this.onGlowOnIdleStateHandler);
            this.setDarkColorTransform();
            this._lockColorTransform = true;
         }
      }
      
      private function setDarkColorTransform() : void
      {
         this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
      }
      
      public function setStage(param1:int) : void
      {
      }
   }
}
