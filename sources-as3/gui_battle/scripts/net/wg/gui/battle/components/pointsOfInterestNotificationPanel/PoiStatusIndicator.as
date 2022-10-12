package net.wg.gui.battle.components.pointsOfInterestNotificationPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.gui.battle.components.poi.components.PoiProgressCircleWrapper;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.data.PointsOfInterestNotificationVO;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.clik.motion.Tween;
   
   public class PoiStatusIndicator extends MovieClip implements IDisposable
   {
      
      private static const TWEEN_TO_X_DURATION:uint = 200;
      
      private static const ICON_PREFIX_ARTILLERY:String = "artillery";
      
      private static const ICON_PREFIX_RECON:String = "recon";
      
      private static const HIGHLIGHT_PREFIX_PROGRESS:String = "progress";
      
      private static const HIGHLIGHT_PREFIX_COMPLETE:String = "complete";
      
      private static const POSTFIX_ALLY:String = "_ally";
      
      private static const POSTFIX_ENEMY:String = "_enemy";
      
      private static const POSTFIX_ENEMY_CB:String = "_enemy_cb";
       
      
      private var _interestPointProgressCircleWrapper:PoiProgressCircleWrapper = null;
      
      private var _data:PointsOfInterestNotificationVO = null;
      
      private var _tweenToX:Tween = null;
      
      private var _onFadeInComplete:Function = null;
      
      private var _onFadeOutComplete:Function = null;
      
      private var _replaySpeed:Number = 1;
      
      private var _isColorBlindMode:Boolean = false;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _isDisposed:Boolean = false;
      
      private var _isFadedOut:Boolean = true;
      
      public function PoiStatusIndicator()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         this._interestPointProgressCircleWrapper = new PoiProgressCircle();
         addChild(this._interestPointProgressCircleWrapper);
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.setColorBlindMode(this._colorSchemeMgr.getIsColorBlindS());
      }
      
      public function clearFadeTween() : void
      {
         this._interestPointProgressCircleWrapper.clearContentTween();
      }
      
      public final function dispose() : void
      {
         this._isDisposed = true;
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this.clearMoveHorTween();
         if(this._interestPointProgressCircleWrapper)
         {
            this._interestPointProgressCircleWrapper.dispose();
            this._interestPointProgressCircleWrapper = null;
         }
         this._data = null;
         this._onFadeInComplete = null;
         this._onFadeOutComplete = null;
      }
      
      public function fadeInTween() : void
      {
         if(!this._isFadedOut)
         {
            return;
         }
         this._isFadedOut = false;
         this._interestPointProgressCircleWrapper.progressCircle.alpha = 1;
         this.progressCircleAlpha = 0;
         this._interestPointProgressCircleWrapper.show(this.onPointProgressCircleShowComplete);
      }
      
      public function fadeOutTween(param1:Boolean = true) : Boolean
      {
         if(this._isFadedOut)
         {
            if(this.progressCircleAlpha > 0 && !this._interestPointProgressCircleWrapper.isTweenInProgress())
            {
               this.progressCircleAlpha = 0;
            }
            return false;
         }
         this._isFadedOut = true;
         this.progressCircleAlpha = 1;
         this._interestPointProgressCircleWrapper.progressCircle.alpha = int(param1);
         this._interestPointProgressCircleWrapper.hide(this.onPointProgressCircleHideComplete);
         return true;
      }
      
      public function getData() : PointsOfInterestNotificationVO
      {
         return this._data;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function setData(param1:PointsOfInterestNotificationVO) : void
      {
         this._data = param1;
         this._interestPointProgressCircleWrapper.iconType = param1.type;
         this.updateData(this._data.status,param1.isAlly);
         this.updateProgress(this._data.progress);
      }
      
      public function setReplaySpeed(param1:Number) : void
      {
         this._replaySpeed = param1;
      }
      
      public function tweenToX(param1:int) : void
      {
         this.clearMoveHorTween();
         this._tweenToX = new Tween(TWEEN_TO_X_DURATION * this._replaySpeed,this,{"x":param1});
      }
      
      public function updateData(param1:uint, param2:Boolean) : void
      {
         if(param1 == POI_CONSTS.POI_STATUS_CAPTURING)
         {
            this._interestPointProgressCircleWrapper.setOwner(param2);
         }
         if(this._data)
         {
            this._data.status = param1;
            if(param1 == POI_CONSTS.POI_STATUS_CAPTURING)
            {
               this._data.isAlly = param2;
            }
         }
         this.updateIconHighlight();
      }
      
      public function updateProgress(param1:uint) : void
      {
         this._interestPointProgressCircleWrapper.updateProgress((param1 + 1) * 0.01);
         if(this._data)
         {
            this._data.progress = param1;
         }
      }
      
      public function forceUpdateIconHighlight(param1:Boolean) : void
      {
         if(this._data)
         {
            this._data.isAlly = param1;
            this.updateIconHighlight();
         }
      }
      
      private function setColorBlindMode(param1:Boolean) : void
      {
         this._isColorBlindMode = param1;
         this.updateIconHighlight();
      }
      
      private function updateIconHighlight() : void
      {
         if(!this._data)
         {
            return;
         }
         var _loc1_:String = this._data.type == POI_CONSTS.POI_TYPE_ARTILLERY ? ICON_PREFIX_ARTILLERY : ICON_PREFIX_RECON;
         var _loc2_:String = HIGHLIGHT_PREFIX_PROGRESS;
         var _loc3_:uint = this._data.status;
         if(_loc3_ == POI_CONSTS.POI_STATUS_COOLDOWN)
         {
            this._interestPointProgressCircleWrapper.updateProgress(1);
            if(this._data.isAlly)
            {
               _loc1_ += POSTFIX_ALLY;
            }
            else if(!this._isColorBlindMode)
            {
               _loc1_ += POSTFIX_ENEMY;
            }
            else
            {
               _loc1_ += POSTFIX_ENEMY_CB;
            }
            _loc2_ = HIGHLIGHT_PREFIX_COMPLETE;
            if(this._data.isAlly)
            {
               _loc2_ += POSTFIX_ALLY;
            }
            else if(!this._isColorBlindMode)
            {
               _loc2_ += POSTFIX_ENEMY;
            }
            else
            {
               _loc2_ += POSTFIX_ENEMY_CB;
            }
            this._interestPointProgressCircleWrapper.progressCircle.alpha = 0;
         }
         this._interestPointProgressCircleWrapper.icon.gotoAndStop(_loc1_);
         this._interestPointProgressCircleWrapper.highlight.gotoAndStop(_loc2_);
      }
      
      private function onPointProgressCircleShowComplete(param1:uint) : void
      {
         if(this._onFadeInComplete != null)
         {
            this._onFadeInComplete();
            this._onFadeInComplete = null;
         }
      }
      
      private function onPointProgressCircleHideComplete(param1:uint) : void
      {
         if(this._onFadeOutComplete != null)
         {
            this._onFadeOutComplete();
            this._onFadeOutComplete = null;
         }
      }
      
      private function clearMoveHorTween() : void
      {
         if(this._tweenToX)
         {
            this._tweenToX.dispose();
            this._tweenToX = null;
         }
      }
      
      public function set progressCircleAlpha(param1:Number) : void
      {
         this._interestPointProgressCircleWrapper.clearContentTween();
         this._interestPointProgressCircleWrapper.alpha = param1;
      }
      
      public function get progressCircleAlpha() : Number
      {
         return this._interestPointProgressCircleWrapper.alpha;
      }
      
      public function set onFadeInComplete(param1:Function) : void
      {
         this._onFadeInComplete = param1;
      }
      
      public function set onFadeOutComplete(param1:Function) : void
      {
         this._onFadeOutComplete = param1;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.setColorBlindMode(this._colorSchemeMgr.getIsColorBlindS());
      }
   }
}
