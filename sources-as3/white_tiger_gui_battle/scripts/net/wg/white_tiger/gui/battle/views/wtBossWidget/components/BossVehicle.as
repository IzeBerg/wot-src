package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.events.BossWidgetEvent;
   import scaleform.clik.motion.Tween;
   
   public class BossVehicle extends BattleUIComponent
   {
      
      private static const INVALIDATE_AVAILABLE_GENERATORS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const STATE_OFF:String = "state_off";
      
      private static const STATE_SHOW_REVEAL:String = "state_show_reveal";
      
      private static const WT_ICON_NORMAL:String = "normal";
      
      private static const WT_ICON_SPECIAL:String = "special";
      
      private static const FRAME_SHIELD_STATIC:String = "static";
      
      private static const FRAME_SHIELD_ANIMATION:String = "animation";
      
      private static const DELAY_GENERATOR_POWER_SHOW:int = 160;
      
      private static const DELAY_GENERATOR_POWER_HIDE:int = 180;
      
      private static const DURATION_GENERATOR_POWER_SHOW:int = 200;
      
      private static const DURATION_GENERATOR_POWER_HIDE:int = 160;
      
      private static const DELAY_SHOW_EXPLODE:int = 40;
       
      
      public var generatorPower:MovieClip = null;
      
      public var wfIcon:MovieClip = null;
      
      public var outer:MovieClip = null;
      
      public var bgOuter:BattleAtlasSprite = null;
      
      public var shield:BossVehicleShield = null;
      
      public var debuff:BossVehicleDebuff = null;
      
      private var _availableGenerators:int = 0;
      
      private var _powersList:Array;
      
      private var _generatorPowerVisible:Boolean = true;
      
      private var _tweenGeneratorPower:Tween = null;
      
      private var _powerTF:TextFieldContainer = null;
      
      public function BossVehicle()
      {
         this._powersList = [];
         super();
         gotoAndStop(STATE_OFF);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._powerTF = this.generatorPower.powerTF;
         this.bgOuter.imageName = BATTLEATLAS.WT_OUTER2;
         this._powersList.push(EVENT.BOSS_WIDGET_SHIELD_STAGE1);
         this._powersList.push(EVENT.BOSS_WIDGET_SHIELD_STAGE2);
         this._powersList.push(EVENT.BOSS_WIDGET_SHIELD_STAGE3);
         this._powersList.push(EVENT.BOSS_WIDGET_SHIELD_STAGE4);
         this.shield.addEventListener(BossWidgetEvent.SHOW_BOSS_ICON_ANIMATION,this.onShowBossIcon);
         this.shield.addEventListener(BossWidgetEvent.SHOW_SHIELD_IDLE_ANIMATION,this.onShowIdleAnimation);
         this.shield.addEventListener(BossWidgetEvent.HIDE_SHIELD_IDLE_ANIMATION,this.onHideIdleAnimation);
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this._powersList.splice(0,this._powersList.length);
         this.debuff.dispose();
         this.debuff = null;
         this.shield.removeEventListener(BossWidgetEvent.SHOW_BOSS_ICON_ANIMATION,this.onShowBossIcon);
         this.shield.removeEventListener(BossWidgetEvent.SHOW_SHIELD_IDLE_ANIMATION,this.onShowIdleAnimation);
         this.shield.removeEventListener(BossWidgetEvent.HIDE_SHIELD_IDLE_ANIMATION,this.onHideIdleAnimation);
         this.shield.dispose();
         this.shield = null;
         this._powerTF.dispose();
         this._powerTF = null;
         this.generatorPower = null;
         this.wfIcon = null;
         this.outer = null;
         this.bgOuter = null;
         App.utils.scheduler.cancelTask(this.callShowRedExplode);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_AVAILABLE_GENERATORS))
         {
            if(this._availableGenerators > 0 && this._availableGenerators <= this._powersList.length)
            {
               this._powerTF.label = this._powersList[this._availableGenerators - 1];
            }
            this.generatorPower.visible = this._availableGenerators > 0;
         }
      }
      
      public function showStartAnimation() : void
      {
         this.shield.showRevealAnimation();
      }
      
      public function updateDebuffTime(param1:Number, param2:Number) : void
      {
         this.debuff.updateDebuffTime(param1,param2);
         this.shield.isDebuff = param2 > 0;
         this.generatorPowerVisibility = param2 <= 0 && this._availableGenerators > 0;
      }
      
      private function onShowRedExplode() : void
      {
         this.clearTween();
         App.utils.scheduler.scheduleTask(this.callShowRedExplode,DELAY_SHOW_EXPLODE);
      }
      
      private function callShowRedExplode() : void
      {
         App.utils.scheduler.cancelTask(this.callShowRedExplode);
         this.shield.showRedExplodeAnimation();
      }
      
      private function clearTween() : void
      {
         if(this._tweenGeneratorPower != null)
         {
            this._tweenGeneratorPower.dispose();
            this._tweenGeneratorPower = null;
         }
      }
      
      public function set availableGenerators(param1:int) : void
      {
         if(this._availableGenerators == param1)
         {
            return;
         }
         this._availableGenerators = param1;
         this.shield.availableGenerators = param1;
         invalidate(INVALIDATE_AVAILABLE_GENERATORS);
      }
      
      public function set isSpecial(param1:Boolean) : void
      {
         this.shield.isSpecial = param1;
         this.wfIcon.gotoAndStop(!!param1 ? WT_ICON_SPECIAL : WT_ICON_NORMAL);
      }
      
      private function set generatorPowerVisibility(param1:Boolean) : void
      {
         if(this._generatorPowerVisible != param1)
         {
            this._generatorPowerVisible = param1;
            this.clearTween();
            if(this._generatorPowerVisible)
            {
               this._tweenGeneratorPower = new Tween(DURATION_GENERATOR_POWER_SHOW,this.generatorPower,{"alpha":1},{
                  "delay":DELAY_GENERATOR_POWER_SHOW,
                  "ease":Cubic.easeIn
               });
            }
            else
            {
               this._tweenGeneratorPower = new Tween(DURATION_GENERATOR_POWER_HIDE,this.generatorPower,{"alpha":0},{
                  "delay":DELAY_GENERATOR_POWER_HIDE,
                  "ease":Cubic.easeIn,
                  "onComplete":this.onShowRedExplode
               });
            }
         }
      }
      
      private function set isIdleAnimationVisible(param1:Boolean) : void
      {
         this.outer.gotoAndStop(!!param1 ? FRAME_SHIELD_ANIMATION : FRAME_SHIELD_STATIC);
      }
      
      private function onShowBossIcon(param1:BossWidgetEvent) : void
      {
         gotoAndPlay(STATE_SHOW_REVEAL);
      }
      
      private function onShowIdleAnimation(param1:BossWidgetEvent) : void
      {
         this.isIdleAnimationVisible = true;
      }
      
      private function onHideIdleAnimation(param1:BossWidgetEvent) : void
      {
         this.isIdleAnimationVisible = false;
      }
   }
}
