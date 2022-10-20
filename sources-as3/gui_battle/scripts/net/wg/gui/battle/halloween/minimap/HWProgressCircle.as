package net.wg.gui.battle.halloween.minimap
{
   import net.wg.gui.battle.components.BaseProgressCircle;
   
   public class HWProgressCircle extends BaseProgressCircle
   {
      
      private static const NONE:String = "none";
      
      private static const ALLY:String = "ally";
      
      private static const NEUTRAL_STATE:String = "neutral";
       
      
      private var _capturingActive:Boolean = false;
      
      private var _isPlayerTeam:Boolean = false;
      
      private var _isPlayerTeamAttack:Boolean = false;
      
      private var _isOwnerSet:Boolean = false;
      
      private var _owningTeam:String = "none";
      
      private var _attackingTeam:String = "none";
      
      public function HWProgressCircle()
      {
         super();
      }
      
      public function setOwningTeam(param1:String, param2:String) : void
      {
         this._owningTeam = param1;
         this._attackingTeam = param2;
         if(this._owningTeam == NONE && this._attackingTeam == NONE)
         {
            this.setNeutral();
         }
         if(this._owningTeam != NONE)
         {
            this._isPlayerTeam = param1 == ALLY;
            this._isOwnerSet = true;
            this._capturingActive = false;
            state = !!this._isPlayerTeam ? ALLY_STATE : getCorrectState(ENEMY_STATE);
            gotoAndStop(state);
            curFrame = SEMI_LAST_FRAME;
            progressCircle.gotoAndStop(SEMI_LAST_FRAME);
         }
      }
      
      public function setNeutral() : void
      {
         this._capturingActive = false;
         this._isOwnerSet = false;
         gotoAndStop(NEUTRAL_STATE);
         curFrame = SEMI_LAST_FRAME;
         progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      override public function updateProgress(param1:Number) : void
      {
         var _loc2_:int = curFrame;
         var _loc3_:int = param1 * SEMI_LAST_FRAME >> 0;
         if(_loc2_ != _loc3_ && _loc2_ == SEMI_LAST_FRAME && _loc3_ > 0)
         {
            this._capturingActive = true;
            state = this.getCapturingActiveState();
            curFrame = _loc3_;
            gotoAndStop(state);
            progressCircle.gotoAndStop(_loc3_);
         }
         else if(_loc2_ > 0 && _loc3_ == 0 && this._capturingActive)
         {
            this._capturingActive = false;
            state = !!this._isPlayerTeam ? ALLY_STATE : getCorrectState(ENEMY_STATE);
            curFrame = SEMI_LAST_FRAME;
            gotoAndStop(state);
            progressCircle.gotoAndStop(SEMI_LAST_FRAME);
         }
         else if(this._capturingActive)
         {
            state = this.getCapturingActiveState();
            curFrame = _loc3_;
            gotoAndStop(state);
            progressCircle.gotoAndStop(_loc3_);
         }
      }
      
      public function setColorBlindMode(param1:Boolean) : void
      {
         colorblindMode = param1;
         this._isOwnerSet = false;
         this.setOwningTeam(this._owningTeam,this._attackingTeam);
      }
      
      public function get capturingActive() : Boolean
      {
         return this._capturingActive;
      }
      
      private function getCapturingActiveState() : String
      {
         this._isPlayerTeamAttack = this._attackingTeam == ALLY;
         return !!this._isPlayerTeamAttack ? ALLY_STATE : getCorrectState(ENEMY_STATE);
      }
   }
}
