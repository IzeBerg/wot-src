package net.wg.gui.battle.comp7.views.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.COMP7_CONSTS;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   
   public class Comp7ConsumableButton extends BattleEquipmentButton
   {
      
      private static const INV_PROGRESS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INV_COUNTER:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const INV_GLOW:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const PROGRESS_MIN_DIFF:Number = 0.05;
      
      private static const MAX_LEVEL:uint = 3;
      
      private static const GLOW_LOOP_ANIM_LABEL:String = "start";
       
      
      public var progress:Comp7ProgressContainer = null;
      
      public var counter:Comp7Counter = null;
      
      public var glowLoop:MovieClip = null;
      
      private var _level:int = -1;
      
      private var _progress:Number = 0;
      
      private var _animType:int = 0;
      
      private var _counterValue:int = -1;
      
      private var _glowID:int = -1;
      
      public function Comp7ConsumableButton()
      {
         super();
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
      
      override protected function configUI() : void
      {
         super.configUI();
         this.glowLoop.addFrameScript(this.glowLoop.totalFrames - 1,this.onGlowLoopTweenComplete);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._level > Values.DEFAULT_INT && isInvalid(INV_PROGRESS))
         {
            this.glowLoop.visible = false;
            if(this._animType == COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_NEXT_LEVEL)
            {
               if(this._level == MAX_LEVEL)
               {
                  glow.showGlow(CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_UPGRADE);
                  this.glowLoop.visible = true;
                  this.glowLoop.gotoAndPlay(GLOW_LOOP_ANIM_LABEL);
               }
               else if(this._level != 1 || !enabled && isReloading)
               {
                  glow.showGlow(CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE);
               }
            }
            else if(this._animType == COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_PROGRESS)
            {
               glow.showGlow(CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_SPECIAL);
            }
            this.progress.setData(this._level,this._progress,this._animType);
         }
         if(isInvalid(INV_COUNTER))
         {
            _loc1_ = this._counterValue > Values.DEFAULT_INT;
            this.counter.visible = _loc1_;
            if(_loc1_)
            {
               this.counter.count = this._counterValue;
            }
         }
         if(this._glowID != Values.DEFAULT_INT && isInvalid(INV_GLOW))
         {
            glow.showGlow(this._glowID);
            this._glowID = Values.DEFAULT_INT;
         }
      }
      
      override protected function onDispose() : void
      {
         this.progress.dispose();
         this.progress = null;
         this.counter.dispose();
         this.counter = null;
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
      
      override protected function enableMouse() : void
      {
      }
      
      override protected function disableMouse() : void
      {
      }
      
      public function setCounter(param1:int) : void
      {
         if(this._counterValue != param1)
         {
            this._counterValue = param1;
            invalidate(INV_COUNTER);
         }
      }
      
      public function setProgress(param1:int, param2:Number) : void
      {
         if(param1 == this._level && param2 < 1 && Math.abs(param2 - this._progress) < PROGRESS_MIN_DIFF)
         {
            return;
         }
         this._animType = this.getAnimationType(param1,param2);
         this._level = param1;
         this._progress = param2;
         invalidate(INV_PROGRESS);
      }
      
      private function getAnimationType(param1:int, param2:Number) : int
      {
         if(this._level == Values.DEFAULT_INT)
         {
            return COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_NONE;
         }
         if(param1 > this._level)
         {
            return COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_NEXT_LEVEL;
         }
         if(param2 - this._progress > PROGRESS_MIN_DIFF)
         {
            return COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_PROGRESS;
         }
         return COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_NONE;
      }
      
      private function onGlowLoopTweenComplete() : void
      {
         if(this.glowLoop.visible)
         {
            this.glowLoop.gotoAndPlay(GLOW_LOOP_ANIM_LABEL);
         }
      }
      
      override public function set icon(param1:String) : void
      {
         super.icon = param1;
         Comp7ConsumableButtonGlow(glow).setIcon(param1);
      }
   }
}
