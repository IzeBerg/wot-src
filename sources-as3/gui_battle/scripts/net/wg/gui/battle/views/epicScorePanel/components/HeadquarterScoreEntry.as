package net.wg.gui.battle.views.epicScorePanel.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HeadquarterScoreEntry extends BattleUIComponent
   {
      
      private static const INACTIVE_STATE:String = "inactive";
      
      private static const ACTIVE_STATE:String = "active";
      
      private static const ATTACK_GREEN_STATE:String = "attack_green";
      
      private static const ATTACK_RED_STATE:String = "attack_red";
      
      private static const DESTROYED_GREEN_STATE:String = "destroyed_green";
      
      private static const DESTROYED_RED_STATE:String = "destroyed_red";
       
      
      public var hqId:MovieClip = null;
      
      public var healthbar:MovieClip = null;
      
      private var _isDestroyed:Boolean = false;
      
      private var _health:Number = 1;
      
      private var _isAttacker:Boolean = false;
      
      private var _isActive:Boolean = false;
      
      private var _state:String = "";
      
      public function HeadquarterScoreEntry()
      {
         super();
         invalidateState();
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.healthbar.stop();
         this.healthbar = null;
         this.hqId.stop();
         this.hqId = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._isDestroyed)
            {
               _loc1_ = !!this._isAttacker ? DESTROYED_GREEN_STATE : DESTROYED_RED_STATE;
            }
            else if(this._health <= 0.99)
            {
               _loc1_ = !!this._isAttacker ? ATTACK_GREEN_STATE : ATTACK_RED_STATE;
               this.healthbar.gotoAndStop((1 - this._health) * 100 >> 0);
            }
            else if(this._isActive && this._health == 1)
            {
               _loc1_ = !!this._isActive ? ACTIVE_STATE : INACTIVE_STATE;
            }
            else
            {
               _loc1_ = INACTIVE_STATE;
            }
            if(this._state != _loc1_)
            {
               this._state = _loc1_;
               gotoAndPlay(_loc1_);
            }
         }
      }
      
      public function initData(param1:int, param2:Boolean) : void
      {
         if(param1 < 1)
         {
            App.utils.asserter.assert(param1 > 0,"headquarter id" + Errors.WRONG_VALUE);
            return;
         }
         this.hqId.gotoAndStop(param1);
         this._isAttacker = param2;
         this._isDestroyed = false;
         this._isActive = true;
         this._health = 1;
         invalidateState();
      }
      
      public function set attacker(param1:Boolean) : void
      {
         if(this._isAttacker == param1)
         {
            return;
         }
         this._isAttacker = param1;
         invalidateState();
      }
      
      public function set destroyed(param1:Boolean) : void
      {
         if(this._isDestroyed == param1)
         {
            return;
         }
         this._isDestroyed = param1;
         invalidateState();
      }
      
      public function set active(param1:Boolean) : void
      {
         if(this._isActive == param1)
         {
            return;
         }
         this._isActive = param1;
         invalidateState();
      }
      
      public function set health(param1:Number) : void
      {
         if(this._health == param1)
         {
            return;
         }
         this._health = param1;
         invalidateState();
      }
   }
}
