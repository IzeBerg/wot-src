package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IScheduler;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.events.BossWidgetEvent;
   
   public class BossVehicleShield extends BattleUIComponent
   {
      
      private static const DEBUFF_SUFFIX:String = "_debuff";
      
      private static const SPECIAL_SUFFIX:String = "_golden";
      
      private static const INVALIDATE_DEBUFF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALIDATE_SPECIAL:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALIDATE_GENERATORS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const DELAY_SHOW_TANK_ICON:uint = 200;
      
      private static const DELAY_SHOW_WT_ICON:uint = 350;
      
      private static const DELAY_SHOW_REVEAL_AFTER_ANIMATION:uint = 550;
      
      private static const FRAME_ANIM_OFF:String = "off";
      
      private static const FRAME_ANIM_START:String = "start";
      
      private static const FRAME_REVEAL_ANIM_END:uint = 12;
      
      private static const FRAME_REVEAL_AFTER_ANIM_END:uint = 25;
      
      private static const STATE_OFF:String = "state_off";
      
      private static const STATE_SHOW:String = "state_show";
      
      private static const FRAME_SHIELD_STATIC:String = "static";
      
      private static const FRAME_SHIELD_ANIMATION:String = "animation";
       
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var shield:MovieClip = null;
      
      public var bgShield:BattleAtlasSprite = null;
      
      public var shieldRevealAnimation:MovieClip = null;
      
      public var shieldAfterRevealAnimation:MovieClip = null;
      
      public var redExplodeAnimation:MovieClip = null;
      
      private var _shieldInnerShield:MovieClip = null;
      
      private var _availableGenerators:int = 0;
      
      private var _isDebuff:Boolean = false;
      
      private var _isSpecial:Boolean = false;
      
      private var _isIdleAnimationVisible:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      public function BossVehicleShield()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this.shield.gotoAndStop(this.shield.totalFrames);
         this._shieldInnerShield = this.shield.shield;
         gotoAndStop(STATE_OFF);
         this.shieldRevealAnimation.gotoAndStop(FRAME_ANIM_OFF);
         this.shieldAfterRevealAnimation.gotoAndStop(FRAME_ANIM_OFF);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bgShield.imageName = BATTLEATLAS.WT_BG_SHIELD;
         this.shieldRevealAnimation.addFrameScript(FRAME_REVEAL_ANIM_END - 1,this.scheduleAnimationsAfterRevealAnimationEnd);
         this.shieldAfterRevealAnimation.addFrameScript(FRAME_REVEAL_AFTER_ANIM_END - 1,this.processAfterRevealAnimationEnd);
      }
      
      override protected function onDispose() : void
      {
         this.vehicleIcon = null;
         this._shieldInnerShield = null;
         this.shield = null;
         this.bgShield = null;
         this.redExplodeAnimation = null;
         this.shieldRevealAnimation.addFrameScript(FRAME_REVEAL_ANIM_END - 1,null);
         this.shieldRevealAnimation = null;
         this.shieldAfterRevealAnimation.addFrameScript(FRAME_REVEAL_AFTER_ANIM_END - 1,null);
         this.shieldAfterRevealAnimation = null;
         this._scheduler.cancelTask(this.showShieldIcon);
         this._scheduler.cancelTask(this.showBossIcon);
         this._scheduler.cancelTask(this.showAfterRevealAnimation);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = isInvalid(INVALIDATE_DEBUFF);
         var _loc2_:Boolean = isInvalid(INVALIDATE_SPECIAL);
         var _loc3_:Boolean = isInvalid(INVALIDATE_GENERATORS);
         if(_loc1_ || _loc3_ || _loc2_)
         {
            this.updateVehicleIcon();
            if(_loc1_ || _loc3_)
            {
               this.shield.visible = this.isIdleAnimationVisible = !this._isDebuff && this._availableGenerators > 0;
               if(this.shield.visible)
               {
                  this.shield.gotoAndStop(this._availableGenerators);
                  this._shieldInnerShield = this.shield.shield;
               }
            }
         }
      }
      
      public function showRedExplodeAnimation() : void
      {
         this.redExplodeAnimation.gotoAndPlay(FRAME_ANIM_START);
      }
      
      public function showRevealAnimation() : void
      {
         this.shieldRevealAnimation.gotoAndPlay(FRAME_ANIM_START);
         BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_SHIELD_SHOW);
      }
      
      private function updateVehicleIcon() : void
      {
         var _loc1_:String = null;
         if(this._availableGenerators > 0)
         {
            _loc1_ = BATTLEATLAS.WT_E100 + (!!this._isDebuff ? DEBUFF_SUFFIX : Values.EMPTY_STR) + (!!this._isSpecial ? SPECIAL_SUFFIX : Values.EMPTY_STR);
         }
         else
         {
            _loc1_ = BATTLEATLAS.WT_E100_R + (!!this._isSpecial ? SPECIAL_SUFFIX : Values.EMPTY_STR);
         }
         this.vehicleIcon.imageName = _loc1_;
      }
      
      private function scheduleAnimationsAfterRevealAnimationEnd() : void
      {
         this._scheduler.scheduleTask(this.showShieldIcon,DELAY_SHOW_TANK_ICON);
         this._scheduler.scheduleTask(this.showBossIcon,DELAY_SHOW_WT_ICON);
         this._scheduler.scheduleTask(this.showAfterRevealAnimation,DELAY_SHOW_REVEAL_AFTER_ANIMATION);
      }
      
      private function showAfterRevealAnimation() : void
      {
         this._scheduler.cancelTask(this.showAfterRevealAnimation);
         this.shieldAfterRevealAnimation.gotoAndPlay(FRAME_ANIM_START);
      }
      
      private function processAfterRevealAnimationEnd() : void
      {
         this.shieldRevealAnimation.gotoAndStop(FRAME_ANIM_OFF);
         this.shield.visible = this.isIdleAnimationVisible = !this._isDebuff && this._availableGenerators > 0;
      }
      
      private function showShieldIcon() : void
      {
         this._scheduler.cancelTask(this.showShieldIcon);
         gotoAndPlay(STATE_SHOW);
         BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_TANK_ICON_SHOW);
      }
      
      private function showBossIcon() : void
      {
         this._scheduler.cancelTask(this.showBossIcon);
         dispatchEvent(new BossWidgetEvent(BossWidgetEvent.SHOW_BOSS_ICON_ANIMATION));
      }
      
      public function set isSpecial(param1:Boolean) : void
      {
         if(this._isSpecial == param1)
         {
            return;
         }
         this._isSpecial = param1;
         invalidate(INVALIDATE_SPECIAL);
      }
      
      public function set isDebuff(param1:Boolean) : void
      {
         if(this._isDebuff == param1)
         {
            return;
         }
         this._isDebuff = param1;
         invalidate(INVALIDATE_DEBUFF);
      }
      
      public function set availableGenerators(param1:int) : void
      {
         if(this._availableGenerators == param1)
         {
            return;
         }
         this._availableGenerators = param1;
         invalidate(INVALIDATE_GENERATORS);
      }
      
      public function set isIdleAnimationVisible(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(this._isIdleAnimationVisible != param1)
         {
            this._isIdleAnimationVisible = param1;
            this._shieldInnerShield.gotoAndStop(!!this._isIdleAnimationVisible ? FRAME_SHIELD_ANIMATION : FRAME_SHIELD_STATIC);
            this.bgShield.visible = !this._isIdleAnimationVisible;
            _loc2_ = !!this._isIdleAnimationVisible ? BossWidgetEvent.SHOW_SHIELD_IDLE_ANIMATION : BossWidgetEvent.HIDE_SHIELD_IDLE_ANIMATION;
            dispatchEvent(new BossWidgetEvent(_loc2_));
         }
      }
   }
}
