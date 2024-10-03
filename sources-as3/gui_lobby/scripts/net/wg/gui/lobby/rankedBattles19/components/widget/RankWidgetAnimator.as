package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.rankedBattles19.components.StepsContainer;
   import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IFramesHelper;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class RankWidgetAnimator implements IDisposable
   {
      
      private static const INIT_ANIM_LABEL:String = "init";
      
      private static const IDLE_ANIM_LABEL:String = "idle";
      
      private static const SHOW_ANIM_LABEL:String = "show";
      
      private static const HIDE_ANIM_LABEL:String = "hide";
      
      private static const END_ANIM_LABEL:String = "end";
      
      private static const SHOW_QUAL_ANIM_LABEL:String = "showQual";
      
      private static const HIDE_TO_RIGHT_ANIM_LABEL:String = "hide_to_right";
      
      private static const SHINE_ANIM_LABEL:String = "shine";
      
      private static const ENABLE_ANIM_LABEL:String = "enable";
      
      private static const DISABLE_LABEL:String = "disable";
      
      private static const LOST_BLINK_LABEL:String = "lost_blink";
      
      private static const RECEIVE_BLINK_LABEL:String = "receive_blink";
      
      private static const DISABLED_LABEL:String = "disabled";
      
      private static const LEAGUE_POSITIVE_OLD_ANIM_LABEL:String = "positive_old";
      
      private static const LEAGUE_POSITIVE_NEW_ANIM_LABEL:String = "positive_new";
      
      private static const LEAGUE_POSITIVE_OLD_END_ANIM_LABEL:String = "positive_old_end";
      
      private static const LEAGUE_POSITIVE_NEW_END_ANIM_LABEL:String = "positive_new_end";
      
      private static const LEAGUE_NEGATIVE_OLD_ANIM_LABEL:String = "negative_old";
      
      private static const LEAGUE_NEGATIVE_NEW_ANIM_LABEL:String = "negative_new";
      
      private static const LEAGUE_NEGATIVE_OLD_END_ANIM_LABEL:String = "negative_old_end";
      
      private static const LEAGUE_NEGATIVE_NEW_END_ANIM_LABEL:String = "negative_new_end";
      
      private static const RANK_BOTTOM_Y:int = 63;
      
      private static const INFO_TEXT_OFFSET:int = 5;
      
      private static const DEFAULT_INFO_TEXT_Y:int = 22;
      
      private static const RANK_END_HIDE_ANIM_FRAME:int = 45;
      
      private static const RANK_START_STEPS_HIDE_FRAME:int = 39;
      
      private static const RANK_START_SECONDARY_TO_CENTER_ANIM_FRAME:int = 99;
      
      private static const RANK_END_ENABLE_ANIM_LABEL:String = "enable_end";
      
      private static const RANK_END_DISABLE_ANIM_LABEL:String = "disable_end";
      
      private static const RANK_END_LOST_BLINK_ANIM_LABEL:String = "lost_blink_end";
      
      private static const RANK_END_RECEIVE_BLINK_ANIM_LABEL:String = "receive_blink_end";
      
      private static const BACK_FLASH_START_FIRST_RECEIVE_FRAME:int = 24;
      
      private static const BACK_FLASH_START_RECEIVE_HIDE_TO_RIGHT_ANIM_FRAME:int = 27;
      
      private static const BACK_FLASH_START_LOST_HIDE_TO_RIGHT_ANIM_FRAME:int = 55;
      
      private static const TWEEN_TIME:int = 400;
      
      private static const TWEEN_TO_CENTER_TIME:int = 400;
      
      private static const LADDER_PNT_TWEEN_TO_CENTER_TIMER:int = 600;
      
      private static const SHOW_RANK_RECEIVE_TIME:int = 2000;
       
      
      private var _widget:RankedBattlesHangarWidget = null;
      
      private var _animState:String = "";
      
      private var _mainRank:MovieClip = null;
      
      private var _secondaryRank:MovieClip = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _rankFrameHelper:IFramesHelper = null;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _allStepsReadyCallback:Function = null;
      
      private var _frameScriptPool:Vector.<FrameScriptData>;
      
      private var _disposed:Boolean = false;
      
      public function RankWidgetAnimator(param1:RankedBattlesHangarWidget)
      {
         this._tweens = new Vector.<Tween>(0);
         this._frameScriptPool = new Vector.<FrameScriptData>(0);
         super();
         this._scheduler = App.utils.scheduler;
         this._widget = param1;
         this._widget.addEventListener(StepEvent.ALL_STEPS_READY,this.onWidgetAllStepsReadyHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.tryDisposeTweens();
         this._tweens = null;
         this._frameScriptPool = null;
         this._scheduler.cancelTask(this.completeAnimationStep);
         this._scheduler.cancelTask(this.runLadderPointAnimation);
         this._scheduler.cancelTask(this.hideFirstRankReceiveAnimation);
         this._scheduler.cancelTask(this.hideRankReceiveAnimation);
         this._scheduler = null;
         if(this._rankFrameHelper)
         {
            this._rankFrameHelper.dispose();
            this._rankFrameHelper = null;
         }
         this._mainRank = null;
         this._secondaryRank = null;
         this._widget.removeEventListener(StepEvent.ALL_STEPS_READY,this.onWidgetAllStepsReadyHandler);
         this._widget = null;
         this._allStepsReadyCallback = null;
         if(this._frameHelper)
         {
            this._frameHelper.dispose();
            this._frameHelper = null;
         }
      }
      
      public function runAnimation(param1:String) : void
      {
         this.tryDisposeTweens();
         this._animState = param1;
         this.initFrameHelpers(param1);
         switch(param1)
         {
            case RANKEDBATTLES_ALIASES.QUAL_DIVISION_FINISHED_STATE:
               this._mainRank = MovieClip(this._widget.rankRight);
               this.runQualDivisionFinished();
               break;
            case RANKEDBATTLES_ALIASES.RANK_INIT_STATE:
               this._allStepsReadyCallback = this.completeAnimationStep;
               break;
            case RANKEDBATTLES_ALIASES.FIRST_RANK_RECEIVE_STATE:
               this._mainRank = MovieClip(this._widget.rankRight);
               this._mainRank.gotoAndStop(DISABLED_LABEL);
               this._secondaryRank = MovieClip(this._widget.rankLeft);
               this._allStepsReadyCallback = this.runFirstRankReceiveAnimation;
               break;
            case RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE:
               this._mainRank = MovieClip(this._widget.rankRight);
               this._mainRank.gotoAndStop(DISABLED_LABEL);
               this._secondaryRank = MovieClip(this._widget.rankLeft);
               this._allStepsReadyCallback = this.runFirstRankReachiveAnimation;
               break;
            case RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this._allStepsReadyCallback = this.runRankReachive;
               break;
            case RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this._allStepsReadyCallback = this.runMainHideAnimation;
               break;
            case RANKEDBATTLES_ALIASES.RANK_LOST_STATE:
            case RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE:
               this._mainRank = MovieClip(this._widget.rankRight);
               this._secondaryRank = MovieClip(this._widget.rankLeft);
               this._allStepsReadyCallback = this.runLostAnimation;
               break;
            case RANKEDBATTLES_ALIASES.LEAGUE_INCREASE_STATE:
               this.runLeagueIncrease();
               break;
            case RANKEDBATTLES_ALIASES.LEAGUE_DECREASE_STATE:
               this.runLeagueDecrease();
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this.runShieldAnimation();
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this.runMainRankToCenter();
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this.runShieldAnimation();
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_RENEW:
               this._mainRank = MovieClip(this._widget.rankLeft);
               this._secondaryRank = MovieClip(this._widget.rankRight);
               this.runShieldAnimation();
               break;
            default:
               this.completeAnimationStep();
         }
      }
      
      public function tryDisposeTweens() : void
      {
         var _loc1_:Tween = null;
         var _loc2_:FrameScriptData = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.onComplete = null;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         for each(_loc2_ in this._frameScriptPool)
         {
            _loc2_.target.addFrameScript(_loc2_.frame,null);
            _loc2_.dispose();
         }
         this._frameScriptPool.splice(0,this._frameScriptPool.length);
      }
      
      private function initFrameHelpers(param1:String) : void
      {
         if(!this._rankFrameHelper)
         {
            this._rankFrameHelper = new FrameHelper(MovieClip(this._widget.rankLeft));
         }
         if(this._frameHelper)
         {
            this._frameHelper.dispose();
            this._frameHelper = null;
         }
         switch(param1)
         {
            case RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.QUAL_DIVISION_FINISHED_STATE:
               this._frameHelper = new FrameHelper(MovieClip(this._widget.division));
               break;
            default:
               this._frameHelper = new FrameHelper(MovieClip(this._widget.league));
         }
      }
      
      private function runLadderPointAnimation() : void
      {
         this.runStepsHideAnimation(this.runRightRankBlink);
      }
      
      private function runRightRankBlink() : void
      {
         this._widget.backFlash.visible = true;
         this._widget.backFlash.gotoAndPlay(SHINE_ANIM_LABEL);
         this.addFrameScript(this._widget.backFlash,BACK_FLASH_START_RECEIVE_HIDE_TO_RIGHT_ANIM_FRAME,this.moveLeftRankToCenter);
      }
      
      private function moveLeftRankToCenter() : void
      {
         this._tweens.push(new Tween(LADDER_PNT_TWEEN_TO_CENTER_TIMER,this._mainRank,{"x":-this._mainRank.width >> 1},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.moveRanksBack
         }));
         this._tweens.push(new Tween(LADDER_PNT_TWEEN_TO_CENTER_TIMER,this._secondaryRank,{
            "x":-this._secondaryRank.width >> 1,
            "alpha":0
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function moveRanksBack() : void
      {
         this._tweens.push(new Tween(LADDER_PNT_TWEEN_TO_CENTER_TIMER,this._mainRank,{"x":this._widget.leftRankX},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.onMoveRanksBackComplete
         }));
         this._tweens.push(new Tween(LADDER_PNT_TWEEN_TO_CENTER_TIMER,this._secondaryRank,{
            "x":this._widget.rightRankX,
            "alpha":1
         },{
            "ease":Cubic.easeOut,
            "paused":false
         }));
      }
      
      private function onMoveRanksBackComplete() : void
      {
         this._widget.tryToChangeStepsData();
         this._allStepsReadyCallback = this.onMoveRanksBackCompleteWaitForSteps;
         this._widget.runStepsShineAnimation();
      }
      
      private function onMoveRanksBackCompleteWaitForSteps() : void
      {
         this._widget.stepsContainer.runStepsShowAnimation(this.completeAnimationStep);
      }
      
      private function runMainRankToCenter() : void
      {
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.stepsContainer,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false
         }));
         var _loc1_:int = -this._secondaryRank.width >> 1;
         this._tweens.push(new Tween(TWEEN_TO_CENTER_TIME,this._mainRank,{"x":_loc1_},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runShieldAnimation
         }));
      }
      
      private function runShieldAnimation() : void
      {
         var _loc1_:Function = null;
         switch(this._animState)
         {
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP:
               _loc1_ = this.completeAnimationStep;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW:
               _loc1_ = this.runStepsShineAnimation;
               break;
            default:
               _loc1_ = this.runMainRankToLeftAndShowSteps;
         }
         RankedBattlesHangarWidget.runShieldAnimation(this._mainRank,_loc1_,this.actualizeRankPosition);
         this._widget.playStateSound(this._animState);
      }
      
      private function actualizeRankPosition() : void
      {
         if(this._animState == RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW || this._animState == RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL)
         {
            this._widget.recalculateLayout();
            this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"x":this._widget.leftRankX},{
               "ease":Cubic.easeOut,
               "paused":false,
               "onComplete":null
            }));
         }
      }
      
      private function runMainRankToLeftAndShowSteps() : void
      {
         this._widget.recalculateLayout();
         this._secondaryRank.x = this._widget.rightRankX;
         this._secondaryRank.alpha = this._widget.stepsContainer.alpha = 0;
         this._secondaryRank.visible = true;
         this._widget.stepsContainer.visible = true;
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"x":this._widget.leftRankX},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runStepsShineAnimation
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"alpha":1},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.stepsContainer,{"alpha":1},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function runFirstRankReceiveAnimation() : void
      {
         this.runStepsHideAnimation();
         this._widget.backFlash.visible = true;
         this._widget.backFlash.gotoAndPlay(SHINE_ANIM_LABEL);
         this.addFrameScript(this._widget.backFlash,BACK_FLASH_START_FIRST_RECEIVE_FRAME,this.runFirstRankReceiveEnableAnimation);
         this._widget.playStateSound(this._animState);
      }
      
      private function runFirstRankReachiveAnimation() : void
      {
         this.runStepsHideAnimation(this.runFirstRankReachiveEnableAnimation);
         this._widget.playStateSound(this._animState);
      }
      
      private function runFirstRankReachiveEnableAnimation() : void
      {
         this._mainRank.gotoAndPlay(ENABLE_ANIM_LABEL);
         this.addFrameScript(this._mainRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_ENABLE_ANIM_LABEL),this.runFirstReachiveSwitchRank);
      }
      
      private function runFirstReachiveSwitchRank() : void
      {
         this._mainRank.stop();
         var _loc1_:int = RankedBattlesHangarWidget.RANK_NORMAL_Y;
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"y":_loc1_},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runSwitchRanksAnimation
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.infoText,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
         var _loc2_:MovieClip = this._secondaryRank;
         this._secondaryRank = this._mainRank;
         this._mainRank = _loc2_;
      }
      
      private function runFirstRankReceiveEnableAnimation() : void
      {
         this.runHideInfoAnimation();
         this._mainRank.gotoAndPlay(ENABLE_ANIM_LABEL);
         this.addFrameScript(this._mainRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_ENABLE_ANIM_LABEL),this.runFirstRankReceiveHideInfoAnim);
         this._scheduler.scheduleTask(this.hideFirstRankReceiveAnimation,SHOW_RANK_RECEIVE_TIME);
      }
      
      private function runMainHideAnimation() : void
      {
         this._mainRank.gotoAndPlay(HIDE_ANIM_LABEL);
         this.addFrameScript(this._mainRank,RANK_START_STEPS_HIDE_FRAME,this.runStepsHideAnimation);
         this.addFrameScript(this._mainRank,RANK_END_HIDE_ANIM_FRAME,this.runRankEnableAnimation);
         RankedBattlesHangarWidget.runShieldAnimation(this._secondaryRank);
      }
      
      private function runStepsShineAnimation() : void
      {
         this._widget.runStepsShineAnimation();
         this.completeAnimationStep();
      }
      
      private function runFirstRankReceiveHideInfoAnim() : void
      {
         this._mainRank.stop();
         this._widget.bg.gotoAndPlay(SHOW_ANIM_LABEL);
         this.runShowInfoAnimation();
         this._widget.recalculateLayout(false,true,true);
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"y":this._widget.rightRankY},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function hideFirstRankReceiveAnimation() : void
      {
         this._widget.bg.gotoAndStop(INIT_ANIM_LABEL);
         this.runFirstRankReachiveEnableAnimation();
      }
      
      private function hideRankReceiveAnimation() : void
      {
         this._widget.bg.gotoAndStop(INIT_ANIM_LABEL);
         this.runSwitchRanksAnimation();
      }
      
      private function runLostAnimation() : void
      {
         this._widget.backFlash.visible = true;
         this._widget.backFlash.gotoAndPlay(SHINE_ANIM_LABEL);
         this.addFrameScript(this._widget.backFlash,BACK_FLASH_START_LOST_HIDE_TO_RIGHT_ANIM_FRAME,this.runHideToRightRankAnimation);
         this._widget.playStateSound(this._animState);
      }
      
      private function runHideToRightRankAnimation() : void
      {
         this._mainRank.gotoAndPlay(HIDE_TO_RIGHT_ANIM_LABEL);
         this.addFrameScript(this._mainRank,RANK_START_SECONDARY_TO_CENTER_ANIM_FRAME,this.runSecondaryRankToCenterAnimation);
         this.runStepsHideAnimation();
      }
      
      private function runRankEnableAnimation() : void
      {
         this._widget.backFlash.visible = true;
         this._widget.backFlash.gotoAndPlay(SHINE_ANIM_LABEL);
         this.addFrameScript(this._widget.backFlash,BACK_FLASH_START_RECEIVE_HIDE_TO_RIGHT_ANIM_FRAME,this.runSecondaryRankEnableAnimation);
         if(this._animState == RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE)
         {
            this._widget.playStateSound(this._animState);
         }
         else if(this._animState == RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE || this._animState == RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE)
         {
            this._widget.onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_RANK_LAST_RECEIVE);
         }
      }
      
      private function runSecondaryRankEnableAnimation() : void
      {
         this._secondaryRank.gotoAndPlay(ENABLE_ANIM_LABEL);
         this.addFrameScript(this._secondaryRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_ENABLE_ANIM_LABEL),this.runSecondaryRankToCenterAnimation);
      }
      
      private function runLostBlinkAnimation() : void
      {
         this._secondaryRank.gotoAndPlay(LOST_BLINK_LABEL);
         this.addFrameScript(this._secondaryRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_LOST_BLINK_ANIM_LABEL),this.runSwitchRanksAnimation);
      }
      
      private function runLostBlinkPrepareAnimation() : void
      {
         this._secondaryRank.gotoAndPlay(DISABLE_LABEL);
         this.addFrameScript(this._secondaryRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_DISABLE_ANIM_LABEL),this.runLostBlinkAnimation);
      }
      
      private function runSecondaryRankToCenterAnimation() : void
      {
         var _loc1_:int = -this._secondaryRank.width >> 1;
         var _loc2_:Function = null;
         this._secondaryRank.stop();
         switch(this._animState)
         {
            case RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE:
               _loc2_ = this.runSecondaryRankToBottomAnimation;
               break;
            case RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE:
            case RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE:
               _loc2_ = this.runSwitchRanksAnimation;
               break;
            case RANKEDBATTLES_ALIASES.RANK_LOST_STATE:
            case RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE:
               _loc2_ = this.runLostBlinkPrepareAnimation;
         }
         this._tweens.push(new Tween(TWEEN_TO_CENTER_TIME,this._secondaryRank,{"x":_loc1_},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":_loc2_
         }));
      }
      
      private function runSecondaryRankToBottomAnimation() : void
      {
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"y":RANK_BOTTOM_Y},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runShowInfoAnimation
         }));
      }
      
      private function runSwitchRanksAnimation() : void
      {
         this._widget.swapChildren(this._mainRank,this._secondaryRank);
         this._widget.stepsContainer.visible = false;
         this._widget.tryToChangeData();
         if(this._animState == RANKEDBATTLES_ALIASES.RANK_LOST_STATE || this._animState == RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE)
         {
            RankIcon(this._secondaryRank).isEnabled = false;
            RankIcon(this._mainRank).isEnabled = true;
         }
         else
         {
            RankIcon(this._mainRank).isEnabled = false;
         }
         if(this._animState == RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE || this._animState == RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE)
         {
            this._mainRank.visible = false;
            this.receivedRankBlink(this.doSwitch);
         }
         else if(this._animState == RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE)
         {
            this.runHideInfoAnimation();
            this.doSwitch();
         }
         else if(this._animState == RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE)
         {
            this.runShowInfoAnimation();
            this.showInit();
         }
         else if(this._animState == RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE)
         {
            this._mainRank.visible = false;
            this.receivedRankBlink(this.runDivisionReceive);
         }
         else if(this._animState == RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE)
         {
            this._mainRank.visible = false;
            this.receivedRankBlink(this.runLeagueReceive);
         }
         else
         {
            this.doSwitch();
         }
      }
      
      private function receivedRankBlink(param1:Function = null) : void
      {
         this._secondaryRank.gotoAndPlay(RECEIVE_BLINK_LABEL);
         this.addFrameScript(this._secondaryRank,this._rankFrameHelper.getFrameBeforeLabel(RANK_END_RECEIVE_BLINK_ANIM_LABEL),param1);
      }
      
      private function showInit() : void
      {
         this._widget.tryToChangeStepsData();
         this._widget.recalculateLayout(false,true,true);
         this._mainRank.visible = false;
         this._secondaryRank.visible = true;
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"y":this._widget.leftRankY},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.onSecondaryRanksPlaced
         }));
      }
      
      private function doSwitch() : void
      {
         this._widget.tryToChangeStepsData();
         this._widget.stepsContainer.runStepsShowAnimation();
         this._widget.isRightOnLeft = this._animState == RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE || this._animState == RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE || this._animState == RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE;
         this._widget.recalculateLayout();
         var _loc1_:int = this._animState == RANKEDBATTLES_ALIASES.RANK_LOST_STATE ? int(this._widget.rightRankX) : int(this._widget.leftRankX);
         var _loc2_:int = this._animState == RANKEDBATTLES_ALIASES.RANK_LOST_STATE ? int(this._widget.leftRankX) : int(this._widget.rightRankX);
         this._mainRank.visible = this._secondaryRank.visible = true;
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{
            "x":_loc1_,
            "y":this._widget.leftRankY
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.doSwitchRanksPlaced
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"x":_loc2_},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function doSwitchRanksPlaced() : void
      {
         this._allStepsReadyCallback = this.completeAnimationStep;
         this._widget.runStepsShineAnimation();
      }
      
      private function onSecondaryRanksPlaced() : void
      {
         this._widget.placeStepContainer(this._secondaryRank);
         this._widget.stepsContainer.runStepsShowAnimation(this.waitForStepsShowAndShine);
      }
      
      private function waitForStepsShowAndShine() : void
      {
         this._allStepsReadyCallback = this.completeAnimationStep;
         this._widget.runStepsShineAnimation();
      }
      
      private function onMainRanksPlaced() : void
      {
         this._widget.placeStepContainer(this._mainRank);
         this._widget.stepsContainer.runStepsShowAnimation(this.waitForStepsShowAndCompleteAnim);
      }
      
      private function waitForStepsShowAndCompleteAnim() : void
      {
         this._scheduler.scheduleTask(this.completeAnimationStep,StepsContainer.TWEEN_TIME + this._widget.stepsContainer.steps.length * StepsContainer.DELAY_TIME);
      }
      
      private function runStepsHideAnimation(param1:Function = null) : void
      {
         this._widget.stepsContainer.runStepsHideAnimation(param1);
      }
      
      private function runShowInfoAnimation() : void
      {
         this._widget.changeInfo();
         this._widget.infoText.y = DEFAULT_INFO_TEXT_Y;
         if(this._animState == RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE)
         {
            this._widget.bg.gotoAndPlay(SHOW_ANIM_LABEL);
            this._scheduler.scheduleTask(this.hideRankReceiveAnimation,SHOW_RANK_RECEIVE_TIME);
         }
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.infoText,{
            "y":this._widget.infoText.y - INFO_TEXT_OFFSET,
            "alpha":1
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function runHideInfoAnimation(param1:Function = null) : void
      {
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.infoText,{
            "y":this._widget.infoText.y + INFO_TEXT_OFFSET,
            "alpha":0
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":param1
         }));
      }
      
      private function completeAnimationStep() : void
      {
         this._widget.animationFinished();
      }
      
      private function runRankReachive() : void
      {
         this._mainRank.gotoAndPlay(HIDE_ANIM_LABEL);
         this.addFrameScript(this._mainRank,RANK_START_STEPS_HIDE_FRAME,this.runStepsHideAnimation);
         this.addFrameScript(this._mainRank,RANK_END_HIDE_ANIM_FRAME,this.runRankReachiveEnableAnim);
         RankedBattlesHangarWidget.runShieldAnimation(this._secondaryRank);
      }
      
      private function runRankReachiveEnableAnim() : void
      {
         this.runSecondaryRankEnableAnimation();
         this._widget.playStateSound(this._animState);
      }
      
      private function runQualDivisionFinished() : void
      {
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{"y":RankedBattlesHangarWidget.RANK_NORMAL_Y},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.onQualRankHide
         }));
         this._tweens.push(new Tween(TWEEN_TIME,this._widget.infoText,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":null
         }));
      }
      
      private function onQualRankHide() : void
      {
         this._mainRank.alpha = 0;
         this._widget.tryToChangeData();
         this._mainRank.visible = true;
         this._widget.division.visible = true;
         this.addFrameScript(this._widget.division,this._frameHelper.getFrameBeforeLabel(END_ANIM_LABEL),this.onQualDivisionAnimShow);
         this._widget.division.gotoAndPlay(SHOW_QUAL_ANIM_LABEL);
         this._widget.playStateSound(this._animState);
      }
      
      private function onQualDivisionAnimShow() : void
      {
         this._widget.division.visible = false;
         this._widget.division.gotoAndStop(IDLE_ANIM_LABEL);
         this.runShowInfoAnimation();
         this._widget.recalculateLayout(false,true,true);
         this._widget.tryToChangeStepsData();
         this._widget.runStepsShineAnimation();
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{
            "alpha":1,
            "y":this._widget.rightRankY
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.onMainRanksPlaced
         }));
      }
      
      private function runDivisionReceive() : void
      {
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runDivisionReceiveGotoShow
         }));
      }
      
      private function runDivisionReceiveGotoShow() : void
      {
         this._secondaryRank.visible = false;
         this._secondaryRank.alpha = 1;
         this._widget.division.visible = true;
         this.addFrameScript(this._widget.division,this._frameHelper.getFrameBeforeLabel(END_ANIM_LABEL),this.runDivisionReceiveEnd);
         this._widget.division.gotoAndPlay(SHOW_ANIM_LABEL);
         this._widget.playStateSound(this._animState);
      }
      
      private function runDivisionReceiveEnd() : void
      {
         this._widget.division.visible = false;
         this._widget.division.gotoAndStop(IDLE_ANIM_LABEL);
         this._mainRank.alpha = 0;
         this._mainRank.visible = true;
         this.runShowInfoAnimation();
         this._widget.recalculateLayout(false,true,true);
         this._widget.tryToChangeStepsData();
         this._widget.runStepsShineAnimation();
         this._tweens.push(new Tween(TWEEN_TIME,this._mainRank,{
            "alpha":1,
            "y":this._widget.rightRankY
         },{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.onMainRanksPlaced
         }));
      }
      
      private function runLeagueReceive() : void
      {
         this._widget.recalculateLayout(false,true,true);
         this._tweens.push(new Tween(TWEEN_TIME,this._secondaryRank,{"alpha":0},{
            "ease":Cubic.easeOut,
            "paused":false,
            "onComplete":this.runLeagueReceiveGotoShowNew
         }));
      }
      
      private function runLeagueReceiveGotoShowNew() : void
      {
         this._secondaryRank.visible = false;
         this._secondaryRank.alpha = 1;
         this._widget.league.visible = true;
         this.addFrameScript(this._widget.league,this._frameHelper.getFrameBeforeLabel(LEAGUE_POSITIVE_NEW_END_ANIM_LABEL),this.runLeagueReceiveGotoHide);
         this._widget.league.gotoAndPlay(LEAGUE_POSITIVE_NEW_ANIM_LABEL);
         this._widget.playStateSound(this._animState);
      }
      
      private function runLeagueReceiveGotoHide() : void
      {
         this._widget.league.gotoAndStop(IDLE_ANIM_LABEL);
         this.completeAnimationStep();
      }
      
      private function runLeagueIncrease() : void
      {
         this._widget.league.visible = true;
         this.addFrameScript(this._widget.league,this._frameHelper.getFrameBeforeLabel(LEAGUE_POSITIVE_OLD_END_ANIM_LABEL),this.runLeagueIncreaseGotoNew);
         this._widget.league.gotoAndPlay(LEAGUE_POSITIVE_OLD_ANIM_LABEL);
      }
      
      private function runLeagueIncreaseGotoNew() : void
      {
         this._widget.tryToChangeLeagueData();
         this.addFrameScript(this._widget.league,this._frameHelper.getFrameBeforeLabel(LEAGUE_POSITIVE_NEW_END_ANIM_LABEL),this.runLeagueIncreaseGotoEnd);
         this._widget.league.gotoAndPlay(LEAGUE_POSITIVE_NEW_ANIM_LABEL);
         this._widget.playStateSound(this._animState);
      }
      
      private function runLeagueIncreaseGotoEnd() : void
      {
         this._widget.league.gotoAndStop(IDLE_ANIM_LABEL);
         this.completeAnimationStep();
      }
      
      private function runLeagueDecrease() : void
      {
         this._widget.playStateSound(this._animState);
         this._widget.league.visible = true;
         this.addFrameScript(this._widget.league,this._frameHelper.getFrameBeforeLabel(LEAGUE_NEGATIVE_OLD_END_ANIM_LABEL),this.runLeagueDecreaseGotoNew);
         this._widget.league.gotoAndPlay(LEAGUE_NEGATIVE_OLD_ANIM_LABEL);
      }
      
      private function runLeagueDecreaseGotoNew() : void
      {
         this._widget.tryToChangeLeagueData();
         this.addFrameScript(this._widget.league,this._frameHelper.getFrameBeforeLabel(LEAGUE_NEGATIVE_NEW_END_ANIM_LABEL),this.runLeagueDecreaseGotoEnd);
         this._widget.league.gotoAndPlay(LEAGUE_NEGATIVE_NEW_ANIM_LABEL);
      }
      
      private function runLeagueDecreaseGotoEnd() : void
      {
         this._widget.league.gotoAndStop(IDLE_ANIM_LABEL);
         this.completeAnimationStep();
      }
      
      private function addFrameScript(param1:MovieClip, param2:int, param3:Function) : void
      {
         param1.addFrameScript(param2,param3);
         this._frameScriptPool.push(new FrameScriptData(param1,param2));
      }
      
      private function onWidgetAllStepsReadyHandler(param1:Event) : void
      {
         if(this._allStepsReadyCallback != null)
         {
            this._allStepsReadyCallback();
            this._allStepsReadyCallback = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

import flash.display.MovieClip;
import net.wg.infrastructure.interfaces.entity.IDisposable;

final class FrameScriptData implements IDisposable
{
    
   
   public var target:MovieClip = null;
   
   public var frame:int = -1;
   
   private var _disposed:Boolean = false;
   
   function FrameScriptData(param1:MovieClip, param2:int)
   {
      super();
      this.target = param1;
      this.frame = param2;
   }
   
   public function dispose() : void
   {
      this._disposed = true;
      if(this.target != null)
      {
         this.target.stop();
         this.target = null;
      }
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
