package net.wg.gui.battle.views.epicInGameRank
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.epicInGameRank.data.EpicInGameRankVO;
   import net.wg.gui.battle.views.epicInGameRank.events.EpicInGameRankEvent;
   import net.wg.infrastructure.base.meta.IEpicInGameRankMeta;
   import net.wg.infrastructure.base.meta.impl.EpicInGameRankMeta;
   
   public class EpicInGameRankPanel extends EpicInGameRankMeta implements IEpicInGameRankMeta
   {
      
      private static const FINAL_RANK_BACKGROUND_FRAME:int = 2;
      
      private static const FINAL_RANK_TITLE_OFFSET:int = 11;
      
      private static const ANIMATE_STATE_FILL_PROGRESS:Number = 1;
       
      
      public var rankSymbol:EpicInGameRankIcon = null;
      
      public var rankTitleTF:TextField = null;
      
      public var animatedRankProgress:EpicInGameRankAnimatedProgress = null;
      
      public var background:MovieClip = null;
      
      private var _isActive:Boolean = false;
      
      private var _data:EpicInGameRankVO = null;
      
      public function EpicInGameRankPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.rankSymbol.dispose();
         this.rankSymbol = null;
         this.animatedRankProgress.removeEventListener(EpicInGameRankEvent.LEVEL_UP_ANIMATION_COMPLETE,this.onRankProgressLevelUpAnimationCompleteHandler);
         this.animatedRankProgress.dispose();
         this.animatedRankProgress = null;
         this.rankTitleTF = null;
         this.background = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.STATE))
            {
               this.animatedRankProgress.updateProgressAnimation(this._data.previousProgress,ANIMATE_STATE_FILL_PROGRESS);
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.rankTitleTF.text = this._data.rankText;
               this.rankSymbol.setRankProgressData(this._data.rank + 1);
               if(this._data.isMaxRank)
               {
                  this.background.gotoAndStop(FINAL_RANK_BACKGROUND_FRAME);
                  this.rankTitleTF.y = FINAL_RANK_TITLE_OFFSET;
                  this.animatedRankProgress.updateProgressCircleVisibility(false);
               }
               else
               {
                  this.animatedRankProgress.updateProgressAnimation(this._data.previousProgress,this._data.newProgress);
               }
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.animatedRankProgress.addEventListener(EpicInGameRankEvent.LEVEL_UP_ANIMATION_COMPLETE,this.onRankProgressLevelUpAnimationCompleteHandler);
      }
      
      override protected function setRank(param1:EpicInGameRankVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function as_triggerLevelUp(param1:Number) : void
      {
         if(!this._isActive)
         {
            levelUpAnimationCompleteS();
         }
         else if(this._data)
         {
            this._data.previousProgress = param1;
            invalidateState();
         }
      }
      
      public function as_updateProgress(param1:Number, param2:Number) : void
      {
         if(this._data)
         {
            this._data.previousProgress = param1;
            this._data.newProgress = param2;
            invalidateData();
         }
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
      
      private function onRankProgressLevelUpAnimationCompleteHandler(param1:EpicInGameRankEvent) : void
      {
         levelUpAnimationCompleteS();
      }
   }
}
