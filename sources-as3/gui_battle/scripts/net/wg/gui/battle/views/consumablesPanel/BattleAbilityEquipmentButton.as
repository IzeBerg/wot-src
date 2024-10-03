package net.wg.gui.battle.views.consumablesPanel
{
   import fl.motion.easing.Circular;
   import flash.display.MovieClip;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import scaleform.clik.motion.Tween;
   
   public class BattleAbilityEquipmentButton extends BattleEquipmentButton
   {
      
      private static const INV_GLOW:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const LEFT_DELIMITER_STR:String = "left";
      
      private static const GLOW_LOOP_ANIM_LABEL:String = "start";
      
      private static const HIDE_GLOW_TWEEN_DURATION:int = 250;
      
      private static const HIDE_GLOW_TWEEN_DELAY:int = 5000;
       
      
      public var usagesCounter:MovieClip = null;
      
      public var glowLoop:MovieClip = null;
      
      private var _tween:Tween = null;
      
      private var _glowID:int = -1;
      
      private var _usagesLeft:int = -1;
      
      private var _usagesCount:int = -1;
      
      public function BattleAbilityEquipmentButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.glowLoop.addFrameScript(this.glowLoop.totalFrames - 1,this.onGlowLoopAnimationCompleted);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._glowID != Values.DEFAULT_INT && isInvalid(INV_GLOW))
         {
            glow.showGlow(this._glowID);
            this._glowID = Values.DEFAULT_INT;
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.usagesCounter = null;
         this.glowLoop.addFrameScript(this.glowLoop.totalFrames - 1,null);
         this.glowLoop = null;
         super.onDispose();
      }
      
      override protected function updateStateBeforeCooldown() : void
      {
         super.updateStateBeforeCooldown();
         if(this.state != InteractiveStates.UP)
         {
            state = InteractiveStates.UP;
         }
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         super.setCoolDownTime(param1,param2,param3,param4);
         this.updateGlowLoop();
      }
      
      override public function showGlow(param1:int) : void
      {
         if(isReloading || !enabled)
         {
            return;
         }
         this._glowID = param1;
         invalidate(INV_GLOW);
      }
      
      private function onGlowLoopAnimationCompleted() : void
      {
         if(this.glowLoop.visible)
         {
            this.glowLoop.gotoAndPlay(GLOW_LOOP_ANIM_LABEL);
         }
      }
      
      private function onHideGlowLoopTweenCompleted() : void
      {
         this.glowLoop.visible = false;
         this.glowLoop.alpha = 1;
      }
      
      private function updateGlowLoop() : void
      {
         this.glowLoop.visible = enabled && !isReloading;
         if(this.glowLoop.visible)
         {
            this.glowLoop.gotoAndPlay(GLOW_LOOP_ANIM_LABEL);
            this.clearTween();
            this._tween = new Tween(HIDE_GLOW_TWEEN_DURATION,this.glowLoop,{"alpha":0},{
               "delay":HIDE_GLOW_TWEEN_DELAY,
               "ease":Circular.easeIn,
               "onComplete":this.onHideGlowLoopTweenCompleted
            });
         }
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      override public function set quantity(param1:int) : void
      {
         if(this._usagesCount == Values.DEFAULT_INT)
         {
            this._usagesCount = param1;
         }
         if(this._usagesLeft != param1)
         {
            this._usagesLeft = param1;
            if(this._usagesCount > 1)
            {
               this.usagesCounter.gotoAndStop(this._usagesCount + LEFT_DELIMITER_STR + this._usagesLeft);
            }
            this.updateGlowLoop();
         }
         super.quantity = param1;
      }
      
      override public function set icon(param1:String) : void
      {
         super.icon = param1;
         BattleAbilityEquipmentButtonGlow(glow).setIcon(param1);
      }
   }
}
