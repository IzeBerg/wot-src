package net.wg.gui.battle.commander.views.common
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.clik.motion.Tween;
   
   public class HealthBar extends BattleUIComponent
   {
      
      private static const FX_DURATION:Number = 2 * Time.MILLISECOND_IN_SECOND;
       
      
      public var bgMC:MovieClip = null;
      
      public var healthMC:MovieClip = null;
      
      public var fxMC:MovieClip = null;
      
      public var textTF:TextField = null;
      
      private var _currentHP:Number = 0.0;
      
      private var _maxHP:Number = 0.0;
      
      private var _isAlive:Boolean = true;
      
      private var _isDeadInvisible:Boolean = false;
      
      private var _fxTween:Tween = null;
      
      public function HealthBar()
      {
         super();
         this.textTF.mouseEnabled = false;
         this.textTF.mouseWheelEnabled = false;
      }
      
      public function set currentHP(param1:Number) : void
      {
         param1 = Math.max(0,param1);
         if(this._currentHP != param1)
         {
            this._currentHP = param1;
            invalidateData();
         }
      }
      
      public function get currentHP() : Number
      {
         return this._currentHP;
      }
      
      public function set maxHP(param1:Number) : void
      {
         if(this._maxHP != param1)
         {
            this._maxHP = param1;
            invalidateData();
         }
      }
      
      public function get maxHP() : Number
      {
         return this._maxHP;
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidateData();
         }
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set fontSize(param1:Number) : void
      {
         var _loc2_:TextFormat = this.textTF.getTextFormat();
         _loc2_.size = param1;
         this.textTF.setTextFormat(_loc2_);
         this.textTF.defaultTextFormat = _loc2_;
      }
      
      public function get fontSize() : Number
      {
         return Number(this.textTF.getTextFormat().size);
      }
      
      public function set isDeadInvisible(param1:Boolean) : void
      {
         this._isDeadInvisible = param1;
         invalidateData();
      }
      
      public function get isDeadInvisible() : Boolean
      {
         return this._isDeadInvisible;
      }
      
      override public function set width(param1:Number) : void
      {
         this.bgMC.width = param1;
         this.healthMC.width = param1;
         this.fxMC.width = param1;
         this.textTF.width = param1;
         invalidateData();
      }
      
      override public function set height(param1:Number) : void
      {
         this.bgMC.height = param1;
         this.healthMC.height = param1;
         this.fxMC.height = param1;
         this.textTF.y = param1 - this.textTF.height >> 1 | 0;
         invalidateData();
      }
      
      override public function get height() : Number
      {
         return this.bgMC.height;
      }
      
      override protected function onDispose() : void
      {
         this.disposeFx();
         this.bgMC = null;
         this.healthMC = null;
         this.fxMC = null;
         this.textTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.disposeFx();
            if(this.isDeadInvisible && !this.isAlive)
            {
               visible = false;
            }
            if(!visible)
            {
               return;
            }
            this.textTF.text = this.currentHP + " / " + this.maxHP;
            this.healthMC.visible = this.isAlive;
            if(this.maxHP > 0)
            {
               _loc1_ = this.healthMC.width;
               this.healthMC.width = width * (this.currentHP / this.maxHP) | 0;
               this.fxMC.visible = _loc1_ > this.healthMC.width;
               if(this.fxMC.visible)
               {
                  this.fxMC.x = this.healthMC.x + this.healthMC.width;
                  this.fxMC.width = _loc1_ - this.healthMC.width;
                  this.fxMC.alpha = 1;
                  this._fxTween = new Tween(FX_DURATION,this.fxMC,{"alpha":0},{
                     "onComplete":this.disposeFx,
                     "paused":false
                  });
               }
            }
         }
      }
      
      private function disposeFx(param1:Tween = null) : void
      {
         if(this._fxTween != null)
         {
            this._fxTween.dispose();
            this._fxTween = null;
         }
         this.fxMC.visible = false;
      }
   }
}
