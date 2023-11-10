package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesCurrentAwardVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesAwardView;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.utils.IFramesHelper;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class RankAwardAnimation extends EventDispatcher
   {
      
      public static const RANK_ICON_X:int = 350;
      
      public static const AWARDS_X_SHIFT:int = 115;
      
      private static const AWARD_WIDTH:int = 80;
      
      private static const AWARD_HGAP:int = 24;
      
      private static const SHOW_STATE:String = "show";
      
      private static const INTRO_STATE:String = "intro";
      
      private static const END_STATE:String = "end";
      
      private static const IDLE_AWARDS_STATE:String = "idleAwards";
      
      private static const SHOW_AWARDS_STATE:String = "showAward";
      
      private static const SHOW_AWARDS_END_STATE:String = "showAwardEnd";
      
      private static const SHOW_NEXT_DIVISION_STATE:String = "showNext";
      
      private static const AWARD_NAME:String = "award";
      
      private static const NEXT_BLOCK_ANIMATION_DURATION:int = 400;
      
      private static const NEXT_BLOCK_ANIMATION_BUTTON_DELAY:int = 1150;
      
      private static const ANIMATION_CONTAINER_DURATION:int = 1000;
      
      private static const SHAW_AWARDS_TIME:int = 1000;
      
      private static const MAX_AWARD_INDEX:int = 6;
      
      private static const LEAGUE_END_FRAME:int = 109;
      
      private static const NEXT_BTN_DIVISION_ANIM_DELAY:int = 500;
       
      
      private var _view:RankedBattlesAwardView = null;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _data:RankedBattlesCurrentAwardVO = null;
      
      private var _rankMc:GlowRankAnimation = null;
      
      private var _qualMc:IUpdatableComponent = null;
      
      private var _awardsMc:MovieClip = null;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _awardFrameHelper:IFramesHelper = null;
      
      private var _awardsCount:int = -1;
      
      private var _state:String = null;
      
      public function RankAwardAnimation(param1:RankedBattlesAwardView)
      {
         super();
         this._view = param1;
         this._rankMc = this._view.rankIcon;
         this._qualMc = this._view.qual;
         this._awardsMc = this._view.awards;
         this._scheduler = App.utils.scheduler;
         this._tweens = new Vector.<Tween>(0);
      }
      
      public final function dispose() : void
      {
         this.disposeTweens();
         this._tweens = null;
         this.clearFrameHelper();
         this._scheduler.cancelTask(this.showAwards);
         this._scheduler = null;
         if(this._view.league)
         {
            this._view.league.addFrameScript(LEAGUE_END_FRAME,null);
         }
         this._view = null;
         this._rankMc = null;
         this._qualMc = null;
         this._awardsMc = null;
         this._data = null;
      }
      
      public function finish() : void
      {
         this.disposeTweens();
         this._view.ribbon.visible = true;
         this._view.ribbon.gotoAndStop(END_STATE);
         this._view.title.gotoAndStop(END_STATE);
         if(this._view.autoPlayNextAnim)
         {
            this._view.nextButton.visible = false;
            this._view.bonusBattleMc.visible = false;
         }
         else
         {
            this._view.nextButton.y = this._view.nextButtonY;
            this._view.nextButton.alpha = 1;
            this._view.nextButton.visible = true;
            if(StringUtils.isNotEmpty(this._data.bonusBattleText))
            {
               this._view.bonusBattleMc.y = this._view.bonusBattleMcY;
               this._view.bonusBattleMc.alpha = 1;
               this._view.bonusBattleMc.visible = true;
            }
         }
         if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_RANK_STATE)
         {
            this._rankMc.showReflectionEffect(false);
            this._rankMc.hideEffects();
            this._rankMc.gotoAndStop(END_STATE);
            this._scheduler.cancelTask(this.showAwards);
            this._rankMc.x = (this._view.width - RANK_ICON_X >> 1) - this._view.smallHeightXShift;
            this._awardsMc.x = this._rankMc.x + AWARDS_X_SHIFT;
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE + this._awardsCount);
            this.updateAwardData();
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_BATTLES_STATE)
         {
            this._scheduler.cancelTask(this.showAwards);
            this._awardsMc.x = this._view.width - this.getAwardsWidth() >> 1;
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE + this._awardsCount);
            this.updateAwardData();
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE)
         {
            this._qualMc.gotoAndStop(END_STATE);
            this._qualMc.update(this._data.qualVO);
            this._scheduler.cancelTask(this.showAwards);
            this._qualMc.x = (this._view.width - RANK_ICON_X >> 1) - this._view.smallHeightXShift;
            this._awardsMc.x = this._qualMc.x + AWARDS_X_SHIFT;
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE + this._awardsCount);
            this.updateAwardData();
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE)
         {
            this._view.division.gotoAndStop(END_STATE);
            this._view.division.update(this._data.divisionVO);
         }
         else
         {
            this._view.league.gotoAndStop(LEAGUE_END_FRAME);
         }
         this.animationFinish(true);
      }
      
      public function setData(param1:RankedBattlesCurrentAwardVO, param2:String) : void
      {
         this._data = param1;
         this._state = this._data.state;
         this._view.title.setTexts(param2,this._data.subTitle);
         this.clearFrameHelper();
         if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_RANK_STATE)
         {
            this._rankMc.showReflectionEffect(false);
            this._rankMc.source = this._data.rankVO.imageSrc;
            this._awardFrameHelper = new FrameHelper(MovieClip(this._awardsMc));
            this._awardsCount = Math.min(this._data.awards.length,MAX_AWARD_INDEX);
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE);
            this._rankMc.x = this._view.width >> 1;
            this._awardsMc.x = this._rankMc.x + AWARDS_X_SHIFT;
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_BATTLES_STATE)
         {
            this._awardFrameHelper = new FrameHelper(MovieClip(this._awardsMc));
            this._awardsCount = Math.min(this._data.awards.length,MAX_AWARD_INDEX);
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE);
            this._awardsMc.x = (this._view.width - this.getAwardsWidth() >> 1) - AWARDS_X_SHIFT;
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE)
         {
            this._frameHelper = new FrameHelper(MovieClip(this._qualMc));
            this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(END_STATE),this.onDivisionEndAnimHandler);
            this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(SHOW_NEXT_DIVISION_STATE),this.onDivisionShowNextAnimHandler);
            this._qualMc.update(this._data.qualVO);
            this._awardFrameHelper = new FrameHelper(MovieClip(this._awardsMc));
            this._awardsCount = Math.min(this._data.awards.length,MAX_AWARD_INDEX);
            this._awardsMc.gotoAndStop(IDLE_AWARDS_STATE);
            this._qualMc.x = this._view.width >> 1;
            this._awardsMc.x = this._qualMc.x + AWARDS_X_SHIFT;
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE)
         {
            this._frameHelper = new FrameHelper(MovieClip(this._view.division));
            this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(END_STATE),this.onDivisionEndAnimHandler);
            this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(SHOW_NEXT_DIVISION_STATE),this.onDivisionShowNextAnimHandler);
            this._view.division.x = this._view.width >> 1;
            this._view.division.update(this._data.divisionVO);
         }
         else
         {
            this._view.league.addFrameScript(LEAGUE_END_FRAME,this.onLeagueEndAnimHandler);
            this._view.league.x = this._view.width >> 1;
         }
         this._rankMc.visible = this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_RANK_STATE;
         this._qualMc.visible = this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE;
         this._awardsMc.visible = this._rankMc.visible || this._qualMc.visible || this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_BATTLES_STATE;
         this._view.division.visible = this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE;
         this._view.league.visible = this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_LEAGUE_STATE;
      }
      
      public function showRibbon() : void
      {
         this._view.ribbon.visible = true;
         this._view.ribbon.gotoAndPlay(INTRO_STATE);
      }
      
      public function showTitle() : void
      {
         this._view.title.gotoAndPlay(SHOW_STATE);
      }
      
      public function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._view.autoPlayNextAnim || this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE || this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE)
         {
            this.hideNextButton();
         }
         else
         {
            this.showNextButton();
         }
         if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_RANK_STATE)
         {
            this._rankMc.gotoAndPlay(INTRO_STATE);
            this._rankMc.showReflectionEffect(true);
            _loc1_ = (this._view.width - RANK_ICON_X >> 1) - this._view.smallHeightXShift;
            this._tweens.push(new Tween(ANIMATION_CONTAINER_DURATION,this._rankMc,{"x":_loc1_},{
               "paused":false,
               "ease":Strong.easeInOut
            }));
            this._tweens.push(new Tween(ANIMATION_CONTAINER_DURATION,this._awardsMc,{"x":_loc1_ + AWARDS_X_SHIFT},{
               "paused":false,
               "ease":Strong.easeInOut
            }));
            this._scheduler.scheduleTask(this.showAwards,SHAW_AWARDS_TIME);
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_BATTLES_STATE)
         {
            this._tweens.push(new Tween(ANIMATION_CONTAINER_DURATION,this._awardsMc,{"x":this._view.width - this.getAwardsWidth() >> 1},{
               "paused":false,
               "ease":Strong.easeInOut
            }));
            this._scheduler.scheduleTask(this.showAwards,SHAW_AWARDS_TIME);
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE)
         {
            this._qualMc.gotoAndPlay(SHOW_STATE);
            _loc2_ = (this._view.width - RANK_ICON_X >> 1) - this._view.smallHeightXShift;
            this._tweens.push(new Tween(ANIMATION_CONTAINER_DURATION,this._qualMc,{"x":_loc2_},{
               "paused":false,
               "ease":Strong.easeInOut
            }));
            this._tweens.push(new Tween(ANIMATION_CONTAINER_DURATION,this._awardsMc,{"x":_loc2_ + AWARDS_X_SHIFT},{
               "paused":false,
               "ease":Strong.easeInOut
            }));
            this._scheduler.scheduleTask(this.showAwards,SHAW_AWARDS_TIME);
         }
         else if(this._state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE)
         {
            this._view.division.gotoAndPlay(SHOW_STATE);
         }
         else
         {
            this._view.league.gotoAndPlay(SHOW_STATE);
         }
      }
      
      private function updateAwardData() : void
      {
         var _loc1_:AwardItemRendererEx = null;
         var _loc2_:int = 1;
         while(_loc2_ <= this._awardsCount)
         {
            _loc1_ = AwardItemRendererEx(this._awardsMc[AWARD_NAME + _loc2_].renderer);
            _loc1_.setData(this._data.awards[_loc2_ - 1]);
            _loc2_++;
         }
      }
      
      private function clearFrameHelper() : void
      {
         if(this._frameHelper)
         {
            this._frameHelper.dispose();
            this._frameHelper = null;
         }
         if(this._awardFrameHelper)
         {
            this._awardFrameHelper.dispose();
            this._awardFrameHelper = null;
         }
      }
      
      private function showNextButton(param1:int = 400, param2:int = 1150) : void
      {
         this._view.nextButton.y = this._view.nextButtonY - RankedBattlesAwardView.NEXT_UI_OFFSET;
         this._view.nextButton.alpha = 0;
         this._view.nextButton.visible = true;
         this._tweens.push(new Tween(param1,this._view.nextButton,{
            "alpha":1,
            "y":this._view.nextButtonY
         },{
            "paused":false,
            "delay":param2,
            "ease":Strong.easeOut
         }));
         if(StringUtils.isNotEmpty(this._data.bonusBattleText))
         {
            this._view.bonusBattleMc.y = this._view.bonusBattleMcY - RankedBattlesAwardView.NEXT_UI_OFFSET;
            this._view.bonusBattleMc.alpha = 0;
            this._view.bonusBattleMc.visible = true;
            this._tweens.push(new Tween(param1,this._view.bonusBattleMc,{
               "alpha":1,
               "y":this._view.bonusBattleMcY
            },{
               "paused":false,
               "delay":param2,
               "ease":Strong.easeOut
            }));
         }
      }
      
      private function hideNextButton() : void
      {
         this._tweens.push(new Tween(NEXT_BLOCK_ANIMATION_DURATION,this._view.nextButton,{
            "alpha":0,
            "y":this._view.nextButtonY - RankedBattlesAwardView.NEXT_UI_OFFSET
         },{
            "paused":false,
            "ease":Strong.easeOut
         }));
         if(StringUtils.isNotEmpty(this._data.bonusBattleText))
         {
            this._tweens.push(new Tween(NEXT_BLOCK_ANIMATION_DURATION,this._view.bonusBattleMc,{
               "alpha":0,
               "y":this._view.bonusBattleMcY - RankedBattlesAwardView.NEXT_UI_OFFSET
            },{
               "paused":false,
               "ease":Strong.easeOut
            }));
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.onComplete = null;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function showAwards() : void
      {
         this._awardFrameHelper.addScriptToFrame(this._awardFrameHelper.getFrameBeforeLabel(SHOW_AWARDS_END_STATE + this._awardsCount),this.onShowAwardsAnimHandler);
         this._awardsMc.gotoAndPlay(SHOW_AWARDS_STATE + this._awardsCount);
         this.updateAwardData();
      }
      
      private function animationFinish(param1:Boolean = false) : void
      {
         this._view.animationFinish(param1);
      }
      
      private function getAwardsWidth() : uint
      {
         return this._awardsCount * AWARD_WIDTH + (this._awardsCount - 1) * AWARD_HGAP;
      }
      
      private function onShowAwardsAnimHandler() : void
      {
         this._awardFrameHelper.addScriptToFrame(this._awardFrameHelper.getFrameBeforeLabel(SHOW_AWARDS_END_STATE + this._awardsCount),null);
         this.animationFinish();
      }
      
      private function onDivisionEndAnimHandler() : void
      {
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(END_STATE),null);
         this.animationFinish();
      }
      
      private function onDivisionShowNextAnimHandler() : void
      {
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(SHOW_NEXT_DIVISION_STATE),null);
         this.showNextButton(NEXT_BLOCK_ANIMATION_DURATION,NEXT_BTN_DIVISION_ANIM_DELAY);
      }
      
      private function onLeagueEndAnimHandler() : void
      {
         this._view.league.addFrameScript(LEAGUE_END_FRAME,null);
         this.animationFinish();
      }
   }
}
