package net.wg.gui.battle.components
{
   public class EpicProgressCircle extends BaseProgressCircle
   {
       
      
      private var _capturingActive:Boolean = false;
      
      private var _isPlayerTeam:Boolean = false;
      
      private var _isOwnerSet:Boolean = false;
      
      public function EpicProgressCircle()
      {
         super();
      }
      
      public function setOwner(param1:Boolean) : void
      {
         if(this._isPlayerTeam == param1 && this._isOwnerSet || this._capturingActive)
         {
            return;
         }
         this._isOwnerSet = true;
         this._isPlayerTeam = param1;
         this._capturingActive = false;
         state = !!param1 ? ALLY_STATE : getCorrectState(ENEMY_STATE);
         gotoAndStop(state);
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
            curFrame = _loc3_;
            progressCircle.gotoAndStop(_loc3_);
         }
      }
      
      public function setColorBlindMode(param1:Boolean) : void
      {
         colorblindMode = param1;
         this._isOwnerSet = false;
         this.setOwner(this._isPlayerTeam);
      }
      
      public function get capturingActive() : Boolean
      {
         return this._capturingActive;
      }
      
      private function getCapturingActiveState() : String
      {
         return !!this._isPlayerTeam ? getCorrectState(ENEMY_STATE) : ALLY_STATE;
      }
   }
}
