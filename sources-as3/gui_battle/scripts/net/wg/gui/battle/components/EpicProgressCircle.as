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
         curFrame = this.defaultEmptyFrame;
      }
      
      override public function updateProgress(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = curFrame;
         _loc3_ = param1 * SEMI_LAST_FRAME >> 0;
         if(_loc2_ != _loc3_ && _loc2_ == this.defaultEmptyFrame && _loc3_ > 0)
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
            curFrame = this.defaultEmptyFrame;
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
         curFrame = this.defaultEmptyFrame;
         progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      protected function getCapturingActiveState() : String
      {
         return !!this._isPlayerTeam ? getCorrectState(ENEMY_STATE) : ALLY_STATE;
      }
      
      public function get isPlayerTeam() : Boolean
      {
         return this._isPlayerTeam;
      }
      
      public function set isPlayerTeam(param1:Boolean) : void
      {
         this._isPlayerTeam = param1;
      }
      
      public function get isOwnerSet() : Boolean
      {
         return this._isOwnerSet;
      }
      
      public function set isOwnerSet(param1:Boolean) : void
      {
         this._isOwnerSet = param1;
      }
      
      public function get capturingActive() : Boolean
      {
         return this._capturingActive;
      }
      
      public function set capturingActive(param1:Boolean) : void
      {
         this._capturingActive = param1;
      }
      
      protected function get defaultEmptyFrame() : int
      {
         return SEMI_LAST_FRAME;
      }
   }
}
