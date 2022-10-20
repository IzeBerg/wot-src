package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   
   public class HWShellButton extends BattleShellButton
   {
      
      private static const START_FRAME:int = 51;
      
      private static const END_FRAME:int = 96;
      
      private static const END_RELOADING_FRAME:int = 138;
      
      public static const TRANSPARENT_ALPHA:Number = 0.5;
      
      public static const DISABLED_QUANTITY_COLOR:uint = 9211006;
      
      public static const ENABLED_QUANTITY_COLOR:uint = 16768409;
       
      
      public var infinityMC:MovieClip = null;
      
      public var greenGlow:MovieClip = null;
      
      private var _showInfinity:Boolean = false;
      
      public function HWShellButton()
      {
         super();
         _coolDownTimer.setFrames(START_FRAME,END_FRAME);
         addFrameScript(BattleShellButton.END_RELOADING_FRAME,null);
         addFrameScript(END_RELOADING_FRAME,reloadingEnd);
      }
      
      override protected function onDispose() : void
      {
         this.infinityMC = null;
         this.greenGlow = null;
         addFrameScript(END_RELOADING_FRAME,null);
         super.onDispose();
      }
      
      public function setInfinity(param1:Boolean) : void
      {
         if(this._showInfinity == param1)
         {
            return;
         }
         this._showInfinity = param1;
         invalidate(QUANTITY_VALIDATION);
      }
      
      override public function set state(param1:String) : void
      {
         if(_isSelectedIndicatorVisible && param1 != InteractiveStates.UP)
         {
            return;
         }
         super.state = param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = isInvalid(SELECTED_INDICATOR_VISIBILITY);
         if(isInvalid(InvalidationType.STATE) || _loc1_)
         {
            useHandCursor = buttonMode = state != BATTLE_ITEM_STATES.COOLDOWN && !_isSelectedIndicatorVisible;
         }
         if(isInvalid(QUANTITY_VALIDATION))
         {
            quantityField.visible = !this._showInfinity;
            this.infinityMC.visible = this._showInfinity;
            if(getQuantity() == 0)
            {
               quantityField.textColor = DISABLED_QUANTITY_COLOR;
            }
            else
            {
               quantityField.textColor = ENABLED_QUANTITY_COLOR;
            }
         }
         if(_loc1_)
         {
            this.greenGlow.visible = _isSelectedIndicatorVisible;
         }
      }
      
      override public function onCoolDownComplete() : void
      {
         super.onCoolDownComplete();
         this.setTransparent(false);
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         super.setCoolDownTime(param1,param2,param3,param4);
         this.setTransparent(param1 > 0 && _isCurrent);
      }
      
      override public function setCurrent(param1:Boolean, param2:Boolean = false) : void
      {
         super.setCurrent(param1,param2);
         if(!param1)
         {
            this.setTransparent(false);
         }
      }
      
      override protected function startCoolDown(param1:Number, param2:Number) : void
      {
         _coolDownTimer.start(param1,this,(END_FRAME - START_FRAME) * param2,DEFAULT_TIME_COEF);
      }
      
      private function setTransparent(param1:Boolean) : void
      {
         if(param1)
         {
            iconLoader.alpha = this.infinityMC.alpha = quantityField.alpha = TRANSPARENT_ALPHA;
         }
         else
         {
            iconLoader.alpha = this.infinityMC.alpha = quantityField.alpha = Values.DEFAULT_ALPHA;
         }
      }
   }
}
