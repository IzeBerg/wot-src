package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.clik.motion.Tween;
   
   public class SupplyHealthBar extends BattleUIComponent
   {
      
      private static const ENTITY_NAME_TO_FRAME:Object = {
         "green":1,
         "red":2,
         "gold":3,
         "ally":1,
         "enemy":2
      };
      
      private static const INVALIDATE_COLOR:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const FX_DURATION:Number = 2 * Time.MILLISECOND_IN_SECOND;
       
      
      public var bgMC:MovieClip = null;
      
      public var healthMC:MovieClip = null;
      
      public var fxMC:MovieClip = null;
      
      private var _currentHP:Number = 0.0;
      
      private var _maxHP:Number = 0.0;
      
      private var _isAlive:Boolean = true;
      
      private var _fxTween:Tween = null;
      
      private var _entityName:String;
      
      public function SupplyHealthBar()
      {
         super();
      }
      
      public function get entityName() : String
      {
         return this._entityName;
      }
      
      public function set entityName(param1:String) : void
      {
         if(param1 == this._entityName && param1 == Values.EMPTY_STR)
         {
            return;
         }
         this._entityName = param1;
         gotoAndStop(ENTITY_NAME_TO_FRAME[this._entityName]);
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
      
      override public function set width(param1:Number) : void
      {
         this.bgMC.width = param1;
         this.healthMC.width = param1;
         this.fxMC.width = param1;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return this.bgMC.width;
      }
      
      override public function set height(param1:Number) : void
      {
         this.bgMC.height = param1;
         this.healthMC.height = param1;
         this.fxMC.height = param1;
         invalidateData();
      }
      
      override public function get height() : Number
      {
         return this.bgMC.height;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.disposeFx();
         this.bgMC = null;
         this.healthMC = null;
         this.fxMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.disposeFx();
            this.healthMC.visible = this.isAlive;
            if(this.maxHP > 0)
            {
               _loc1_ = this.healthMC.width;
               this.healthMC.width = this.width * (this.currentHP / this.maxHP) | 0;
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
         if(this.fxMC != null)
         {
            this.fxMC.visible = false;
         }
      }
   }
}
