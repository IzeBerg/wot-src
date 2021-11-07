package net.wg.gui.battle.eventBattle.views.bossIndicatorProgress
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IPveBossIndicatorProgressMeta;
   import net.wg.infrastructure.base.meta.impl.PveBossIndicatorProgressMeta;
   
   public class BossIndicatorProgress extends PveBossIndicatorProgressMeta implements IPveBossIndicatorProgressMeta
   {
      
      private static const BOSS_VALUE_IDLE:int = 0;
      
      private static const BOSS_VALUE_MEDIUM:int = 50;
      
      private static const BOSS_VALUE_HIGH:int = 100;
      
      private static const BOSS_LABEL_IDLE:String = "idle";
      
      private static const BOSS_LABEL_LOW:String = "low";
      
      private static const BOSS_LABEL_MEDIUM:String = "medium";
      
      private static const BOSS_LABEL_HIGH:String = "high";
       
      
      public var icon:MovieClip = null;
      
      public var fxLeft:MovieClip = null;
      
      public var fxRight:MovieClip = null;
      
      public var gradientLeft:MovieClip = null;
      
      public var gradientRight:MovieClip = null;
      
      private var _value:int = 0;
      
      private var _isEnabled:Boolean = false;
      
      public function BossIndicatorProgress()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._value == BOSS_VALUE_IDLE)
            {
               this.icon.gotoAndStop(BOSS_LABEL_IDLE);
               this.fxLeft.gotoAndStop(BOSS_LABEL_IDLE);
               this.fxRight.gotoAndStop(BOSS_LABEL_IDLE);
               this.gradientLeft.gotoAndStop(BOSS_LABEL_IDLE);
               this.gradientRight.gotoAndStop(BOSS_LABEL_IDLE);
            }
            else if(this._value == BOSS_VALUE_HIGH)
            {
               this.icon.gotoAndStop(BOSS_LABEL_HIGH);
               this.fxLeft.gotoAndStop(BOSS_LABEL_HIGH);
               this.fxRight.gotoAndStop(BOSS_LABEL_HIGH);
               this.gradientLeft.gotoAndStop(BOSS_LABEL_HIGH);
               this.gradientRight.gotoAndStop(BOSS_LABEL_HIGH);
            }
            else if(this._value < BOSS_VALUE_MEDIUM)
            {
               this.icon.gotoAndStop(BOSS_LABEL_LOW);
               this.fxLeft.gotoAndStop(BOSS_LABEL_LOW);
               this.fxRight.gotoAndStop(BOSS_LABEL_LOW);
               this.gradientLeft.gotoAndStop(BOSS_LABEL_LOW);
               this.gradientRight.gotoAndStop(BOSS_LABEL_LOW);
            }
            else if(this._value >= BOSS_VALUE_MEDIUM)
            {
               this.icon.gotoAndStop(BOSS_LABEL_MEDIUM);
               this.fxLeft.gotoAndStop(BOSS_LABEL_MEDIUM);
               this.fxRight.gotoAndStop(BOSS_LABEL_MEDIUM);
               this.gradientLeft.gotoAndStop(BOSS_LABEL_MEDIUM);
               this.gradientRight.gotoAndStop(BOSS_LABEL_MEDIUM);
            }
            gotoAndStop(this._value);
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.fxLeft = null;
         this.fxRight = null;
         this.gradientLeft = null;
         this.gradientRight = null;
         super.onDispose();
      }
      
      public function as_setValue(param1:int) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            invalidateData();
         }
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function as_setIndicatorEnabled(param1:Boolean) : void
      {
         visible = param1;
         this._isEnabled = param1;
         dispatchEvent(new BossIndicatorEvent(BossIndicatorEvent.INDICATOR_ENABLED));
      }
   }
}
