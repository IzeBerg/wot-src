package net.wg.gui.battle.historicalBattles.playersPanel.components.healthBar
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.utils.FrameHelper;
   
   public class HBHealthBar extends BattleUIComponent
   {
      
      private static const INV_IS_BLIND:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INV_IS_CURRENT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INV_OFFLINE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const ALPHA_DISABLE:Number = 0.4;
      
      private static const ALPHA_AVAILABLE:Number = 0.8;
      
      private static const CURRENT_PLAYER:String = "currentPlayer";
      
      private static const REGULAR_LABEL:String = "regular";
      
      private static const REGULAR_BLIND_LABEL:String = "regularBlind";
       
      
      public var fxMask:MovieClip = null;
      
      public var fx:HBHealthBarFx = null;
      
      public var hpMask:MovieClip = null;
      
      public var hp:FrameStateCmpnt = null;
      
      public var bg:MovieClip = null;
      
      private var _isBlindEnabled:Boolean = false;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _isEnemiesPanel:Boolean = false;
      
      private var _isOffline:Boolean = true;
      
      private var _hpCurrent:int = 0;
      
      private var _hpMax:int = 0;
      
      private var _skipAnimation:Boolean = false;
      
      private var _maskWidth:int = 0;
      
      private var _isAnimationInProgress:Boolean = false;
      
      private var _frameHelper:FrameHelper = null;
      
      public function HBHealthBar()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._frameHelper = new FrameHelper(this.fx);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._frameHelper.addScriptToFrame(this.fx.totalFrames - 1,this.onAnimationCompleteCallback);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(!this._isAnimationInProgress)
            {
               this._maskWidth = this.hpMask.width;
            }
            _loc1_ = totalFrames * (1 - this._hpCurrent / this._hpMax);
            gotoAndStop(_loc1_);
            if(!this._skipAnimation)
            {
               _loc2_ = this.hpMask.width;
               this.playFx(this._maskWidth,_loc2_);
            }
            this._skipAnimation = false;
         }
         if(this._isEnemiesPanel)
         {
            if(isInvalid(INV_IS_BLIND))
            {
               this.fx.isBlindEnabled = this._isBlindEnabled;
               this.hp.frameLabel = !!this._isBlindEnabled ? REGULAR_BLIND_LABEL : REGULAR_LABEL;
            }
         }
         else if(isInvalid(INV_IS_CURRENT))
         {
            this.fx.isCurrentPlayer = this._isCurrentPlayer;
            this.hp.frameLabel = !!this._isCurrentPlayer ? CURRENT_PLAYER : REGULAR_LABEL;
         }
         if(isInvalid(INV_OFFLINE))
         {
            this.hp.alpha = !!this._isOffline ? Number(ALPHA_AVAILABLE) : Number(ALPHA_DISABLE);
         }
      }
      
      override protected function onDispose() : void
      {
         this.fxMask = null;
         this.fx.dispose();
         this.fx = null;
         this.hpMask = null;
         this.hp.dispose();
         this.hp = null;
         this.bg = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      public function setHp(param1:int, param2:int) : void
      {
         this.updateHp(param1,param2,true);
      }
      
      public function updateHp(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(this._hpMax == param1 && this._hpCurrent == param2)
         {
            return;
         }
         this._hpMax = param1;
         this._hpCurrent = param2;
         if(param3)
         {
            this._skipAnimation = true;
         }
         invalidateData();
      }
      
      private function onAnimationCompleteCallback() : void
      {
         this._isAnimationInProgress = false;
      }
      
      private function playFx(param1:int, param2:int) : void
      {
         if(param1 > param2)
         {
            this.fxMask.x = param2;
            this.fxMask.width = param1 - param2;
         }
         else
         {
            this.fxMask.x = param1;
            this.fxMask.width = param2 - param1;
         }
         this._isAnimationInProgress = true;
         this.fx.playAnim();
      }
      
      public function set isBlindEnabled(param1:Boolean) : void
      {
         if(this._isBlindEnabled == param1)
         {
            return;
         }
         this._isBlindEnabled = param1;
         invalidate(INV_IS_BLIND);
      }
      
      public function set isCurrentPlayer(param1:Boolean) : void
      {
         if(this._isCurrentPlayer == param1)
         {
            return;
         }
         this._isCurrentPlayer = param1;
         invalidate(INV_IS_CURRENT);
      }
      
      public function set isEnemiesPanel(param1:Boolean) : void
      {
         this._isEnemiesPanel = param1;
      }
      
      public function set isOffline(param1:Boolean) : void
      {
         if(this._isOffline == param1)
         {
            return;
         }
         this._isOffline = param1;
         invalidate(INV_OFFLINE);
      }
   }
}
