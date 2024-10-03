package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IRankIcon;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesHangarWidgetVO;
   import net.wg.gui.lobby.rankedBattles19.events.RankWidgetEvent;
   import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
   import net.wg.infrastructure.base.meta.IRankedBattlesHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesHangarWidgetMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class RankedBattlesHangarWidget extends RankedBattlesHangarWidgetMeta implements IRankedBattlesHangarWidgetMeta, ISoundable
   {
      
      public static const RANK_NORMAL_Y:int = 29;
      
      private static const SIZES:Object = {};
      
      private static const MARGIN:Object = {};
      
      private static const RANKS_OFFSETS_MAP:Object = {};
      
      private static const STEPS_CONTAINER_X_OFFSETS_MAP:Object = {};
      
      private static const POST_BATTLE_SOUNDS:Object = {};
      
      private static const HANGAR_SOUNDS:Object = {};
      
      private static const CENTER_RANK_Y:int = 64;
      
      private static const SMALL_SCREEN:Point = new Point(1600,900);
      
      private static const SMALL_LEFT_RANK_OFFSET:int = 18;
      
      private static const SMALL_RIGHT_RANK_OFFSET:int = -16;
      
      private static const MEDIUM_LEFT_OFFSET:int = 27;
      
      private static const MEDIUM_RIGHT_OFFSET:int = -30;
      
      private static const HUGE_LEFT_RANK_OFFSET:int = 46;
      
      private static const HUGE_RIGHT_RANK_OFFSET:int = -48;
      
      private static const SMALL_STEPS_CONTAINER_X_OFFSET:int = 16;
      
      private static const MEDIUM_STEPS_CONTAINER_X_OFFSET:int = 24;
      
      private static const HUGE_STEPS_CONTAINER_X_OFFSET:int = 37;
      
      private static const HUGE_LADDER_POINT_OFFSET_X:int = -118;
      
      private static const MEDIUM_LADDER_POINT_OFFSET_X:int = -42;
      
      private static const SMALL_LADDER_POINT_OFFSET_X:int = -37;
      
      private static const HIT_OFFSET:int = 6;
      
      private static const SHOW_RED_LABEL:String = "over-red";
      
      private static const OUT_RED_LABEL:String = "out-red";
      
      private static const IDX_RANK_LEFT:int = 0;
      
      private static const IDX_RANK_RIGHT:int = 1;
      
      private static const INV_NEXT_ANIM:String = "invNextAnim";
      
      private static const INV_FINAL_STATE:String = "invFinalState";
      
      private static const BONUS_BATTLES_Y:int = 152;
      
      private static const BONUS_BATTLES_Y_SMALL:int = 132;
      
      private static const BONUS_BATTLES_SHIELD_GAP:int = 10;
      
      private static const REPLECTION_LOOP_DELAY:int = 3000;
      
      private static const HUGE_STEPS_ANIM_TIMER:int = 300;
      
      private static const LEFT_MARGIN_INDEX:int = 0;
      
      private static const RIGHT_MARGIN_INDEX:int = 1;
      
      {
         SIZES[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = RANKEDBATTLES_CONSTS.WIDGET_MEDIUM_WIDTH;
         SIZES[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = RANKEDBATTLES_CONSTS.WIDGET_SMALL_WIDTH;
         MARGIN[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = [25,25];
         MARGIN[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = [-20,-25];
         RANKS_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = [HUGE_LEFT_RANK_OFFSET,HUGE_RIGHT_RANK_OFFSET,HUGE_LADDER_POINT_OFFSET_X];
         RANKS_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = [MEDIUM_LEFT_OFFSET,MEDIUM_RIGHT_OFFSET,MEDIUM_LADDER_POINT_OFFSET_X];
         RANKS_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = [SMALL_LEFT_RANK_OFFSET,SMALL_RIGHT_RANK_OFFSET,SMALL_LADDER_POINT_OFFSET_X];
         STEPS_CONTAINER_X_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = HUGE_STEPS_CONTAINER_X_OFFSET;
         STEPS_CONTAINER_X_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = MEDIUM_STEPS_CONTAINER_X_OFFSET;
         STEPS_CONTAINER_X_OFFSETS_MAP[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = SMALL_STEPS_CONTAINER_X_OFFSET;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE_SHORT;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE_SHORT;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_LOST_SHORT_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST_SHORT;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.STEP_LOST_BLINK_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST_SHORT;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.RANK_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_LOST;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_LOST;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.FIRST_RANK_RECEIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_FIRST_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_REACHIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_REACHIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.QUAL_DIVISION_FINISHED_STATE] = RANKEDBATTLES_ALIASES.SOUND_DIVISION_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_DIVISION_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_LEAGUE_RECEIVE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.LEAGUE_INCREASE_STATE] = RANKEDBATTLES_ALIASES.SOUND_LEAGUE_INCREASE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.LEAGUE_DECREASE_STATE] = RANKEDBATTLES_ALIASES.SOUND_LEAGUE_DECREASE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_STEP;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_STEP;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_FULL_RENEW;
         HANGAR_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_RENEW] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_RENEW;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_RECEIVE_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_BONUS_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_BONUS_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_BONUS_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_BONUS_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_BONUS_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_BONUS_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_JUST_LOST_SHORT_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.STEP_LOST_BLINK_STATE] = RANKEDBATTLES_ALIASES.SOUND_STEP_LOST_SHORT_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_REACHIVE_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_REACHIVE_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.RANK_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_LOST_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE] = RANKEDBATTLES_ALIASES.SOUND_RANK_LOST_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_STEP_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_STEP_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_LOSE_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_FULL_RENEW_POST_BATTLE;
         POST_BATTLE_SOUNDS[RANKEDBATTLES_ALIASES.ANIM_SHIELD_RENEW] = RANKEDBATTLES_ALIASES.SOUND_SHIELD_RENEW_POST_BATTLE;
      }
      
      public var infoText:MovieClip = null;
      
      public var hit:Sprite = null;
      
      public var rankLeft:IRankIcon = null;
      
      public var rankRight:IRankIcon = null;
      
      public var backFlash:MovieClip = null;
      
      public var stepsContainer:WidgetStepsContainer = null;
      
      public var bonusBattles:WidgetBonusBattles = null;
      
      public var league:WidgetLeague = null;
      
      public var division:WidgetDivision = null;
      
      public var bg:MovieClip = null;
      
      private var _isSmall:Boolean = false;
      
      private var _infoTF:TextField = null;
      
      private var _animationSteps:Vector.<RankedBattlesHangarWidgetVO> = null;
      
      private var _currentAnimationStep:int = 0;
      
      private var _model:RankedBattlesHangarWidgetVO = null;
      
      private var _leftRankX:int = -1;
      
      private var _leftRankY:int = -1;
      
      private var _rightRankX:int = -1;
      
      private var _rightRankY:int = -1;
      
      private var _scheduler:IScheduler;
      
      private var _hitArea:Sprite = null;
      
      private var _widgetSize:String = "medium";
      
      private var _isRightOnLeft:Boolean = false;
      
      private var _showRedBackground:Boolean = false;
      
      private var _animator:RankWidgetAnimator = null;
      
      private var _animationEnabled:Boolean = true;
      
      public function RankedBattlesHangarWidget()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._animator = new RankWidgetAnimator(this);
         hitArea = this.hit;
         this._infoTF = this.infoText.infoTF;
         this._hitArea = new Sprite();
         addChild(this._hitArea);
         this.backFlash.gotoAndStop(1);
         this.bg.gotoAndStop(1);
      }
      
      public static function runShieldAnimation(param1:MovieClip, param2:Function = null, param3:Function = null) : void
      {
         if(param1)
         {
            RankIcon(param1).shield.animateState(param2,param3);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.hitArea = this._hitArea;
         this.bg.mouseEnabled = this.bg.mouseChildren = false;
         this.infoText.mouseEnabled = this.infoText.mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         App.soundMgr.addSoundsHdlrs(this);
         this.division.visible = false;
         this.useButtonMode();
         this.league.buttonMode = this.league.useHandCursor = true;
         this.bonusBattles.buttonMode = this.bonusBattles.useHandCursor = true;
         this.stepsContainer.addEventListener(StepEvent.STEP_ANIM_IN_PROGRESS,this.onStepsContStepAnimInProgressHandler);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.backFlash.stop();
         this.bg.stop();
         this.rankLeft.stop();
         this.rankRight.stop();
         App.soundMgr.removeSoundHdlrs(this);
         this._scheduler.cancelTask(this.runAnimation);
         this._scheduler.cancelTask(this.runStepsAnimation);
         this._scheduler.cancelTask(this.showReflectionCallback);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.removeHoverListeners();
         this.stepsContainer.removeEventListener(StepEvent.STEP_ANIM_IN_PROGRESS,this.onStepsContStepAnimInProgressHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         this.rankLeft.dispose();
         this.rankLeft = null;
         this.rankRight.dispose();
         this.rankRight = null;
         this.stepsContainer.dispose();
         this.stepsContainer = null;
         this.bonusBattles.dispose();
         this.bonusBattles = null;
         this.division.dispose();
         this.division = null;
         this.league.dispose();
         this.league = null;
         this._animator.dispose();
         this._animator = null;
         this.infoText = null;
         this.hit = null;
         this.backFlash = null;
         this.bg = null;
         this._infoTF = null;
         this._model = null;
         this._scheduler = null;
         removeChild(this._hitArea);
         this._hitArea = null;
         this.clearAnimationSteps();
         this._animationSteps = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Vector.<RankedBattlesHangarWidgetVO>) : void
      {
         var _loc2_:RankedBattlesHangarWidgetVO = null;
         if(this._animationSteps == null || this._currentAnimationStep >= this._animationSteps.length)
         {
            this._isRightOnLeft = false;
            this.clearAnimationSteps();
            this._animationSteps = param1;
            this._currentAnimationStep = 0;
            this._model = this._animationSteps[this._currentAnimationStep];
            invalidateData();
         }
         else
         {
            for each(_loc2_ in param1)
            {
               this._animationSteps.push(_loc2_);
            }
            param1.splice(0,param1.length);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(this._model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.tryClear();
               this._animationEnabled = this._model.animationEnabled;
               if(this._animationEnabled)
               {
                  this.stepsContainer.isOneByOneAnimType = this._model.isHuge;
                  this.stepsContainer.setData(this._model.stepsContainerVO);
                  this.rankLeft.update(this._model.rankLeftVO);
                  this.rankRight.update(this._model.rankRightVO);
               }
               else
               {
                  this.setFinalStateData(false);
               }
               this._infoTF.htmlText = this._model.infoText;
               if(this._model.divisionVO)
               {
                  this.division.update(this._model.divisionVO);
               }
               if(this._model.leagueVO)
               {
                  this.league.update(this._model.leagueVO);
               }
               _loc1_ = this._model.state;
               if(!this._model.isHuge && RANKEDBATTLES_ALIASES.RANK_ANIMATED_STATES.indexOf(_loc1_) == Values.DEFAULT_INT)
               {
                  this.playStateSound(_loc1_);
                  this.animationFinished();
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this._isSmall = App.appWidth < SMALL_SCREEN.x || App.appHeight < SMALL_SCREEN.y;
               this.changeWidgetSize();
               this.rankLeft.componentSize = this._widgetSize;
               this.rankRight.componentSize = this._widgetSize;
               this.stepsContainer.componentSize = this._widgetSize;
               this.league.componentSize = this._widgetSize;
               this.rankLeft.validateNow();
               this.rankRight.validateNow();
               this.stepsContainer.validateNow();
               this.league.validateNow();
               if(!this._animationEnabled)
               {
                  this.setFinalStateLayout();
               }
               else
               {
                  this.rebuildLayout();
               }
            }
            if(isInvalid(INV_NEXT_ANIM))
            {
               this._scheduler.cancelTask(this.runAnimation);
               this._scheduler.cancelTask(this.showReflectionCallback);
               this._animator.tryDisposeTweens();
               this.bg.gotoAndStop(1);
               this.rankLeft.showReflection(false);
               this.rankRight.showReflection(false);
               this.backFlash.visible = false;
               this.backFlash.gotoAndStop(1);
               if(this._model.divisionVO)
               {
                  this.division.update(this._model.divisionVO);
               }
               if(this._model.leagueVO)
               {
                  this.league.update(this._model.leagueVO);
               }
               this.stepsContainer.isOneByOneAnimType = this._model.isHuge;
               this.stepsContainer.setData(this._model.stepsContainerVO);
               this.stepsContainer.validateNow();
               this._infoTF.htmlText = this._model.infoText;
               this.rankLeft.update(this._model.rankLeftVO);
               this.rankRight.update(this._model.rankRightVO);
               this.rankLeft.validateNow();
               this.rankRight.validateNow();
               _loc1_ = this._model.state;
               if(!this._model.isHuge && RANKEDBATTLES_ALIASES.RANK_ANIMATED_STATES.indexOf(_loc1_) == Values.DEFAULT_INT)
               {
                  this.playStateSound(_loc1_);
                  this.animationFinished();
               }
               this.rebuildLayout();
            }
            else if(this._currentAnimationStep < this._animationSteps.length && isInvalid(INV_FINAL_STATE))
            {
               if(this._animationEnabled)
               {
                  this.setFinalStateData();
                  this.setFinalStateLayout();
               }
               this.animationFinished();
            }
         }
      }
      
      public function animationFinished() : void
      {
         ++this._currentAnimationStep;
         if(this._currentAnimationStep < this._animationSteps.length)
         {
            this._isRightOnLeft = false;
            this._model = this._animationSteps[this._currentAnimationStep];
            invalidate(INV_NEXT_ANIM);
         }
         else
         {
            this.showReflection();
            this.bonusBattles.show();
            if(_baseDisposed)
            {
               return;
            }
            onAnimationFinishedS();
            dispatchEvent(new RankWidgetEvent(RankWidgetEvent.READY));
         }
         this.resizeHit();
      }
      
      public function as_setBonusBattlesLabel(param1:String) : void
      {
         this.bonusBattles.visible = StringUtils.isNotEmpty(param1);
         if(this.bonusBattles.visible)
         {
            this.bonusBattles.setText(param1);
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return param1 == MouseEvent.MOUSE_DOWN;
      }
      
      public function changeInfo() : void
      {
         if(!this._model.isHuge)
         {
            this._infoTF.htmlText = this._model.nextInfoText;
         }
      }
      
      public function enableRanksReflections(param1:Boolean) : void
      {
         if(this.rankLeft != null)
         {
            this.rankLeft.enableReflection(param1);
         }
         if(this.rankRight != null)
         {
            this.rankRight.enableReflection(param1);
         }
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.OK_BTN;
      }
      
      public function placeStepContainer(param1:DisplayObject) : void
      {
         this.stepsContainer.x = param1.x - this.stepsContainer.width + STEPS_CONTAINER_X_OFFSETS_MAP[this._widgetSize] ^ 0;
         this.stepsContainer.y = param1.y + (param1.height - this.stepsContainer.height >> 1);
      }
      
      public function playStateSound(param1:String) : void
      {
         var _loc2_:Object = !!this._model.isHuge ? POST_BATTLE_SOUNDS : HANGAR_SOUNDS;
         var _loc3_:String = _loc2_[param1];
         if(StringUtils.isNotEmpty(_loc3_))
         {
            onSoundTriggerS(_loc3_);
         }
      }
      
      public function recalculateLayout(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:IRankIcon = null;
         var _loc5_:IRankIcon = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = !!this._isRightOnLeft ? this.rankRight : this.rankLeft;
         _loc5_ = !!this._isRightOnLeft ? this.rankLeft : this.rankRight;
         this._leftRankY = this._rightRankY = RANK_NORMAL_Y;
         this.stepsContainer.x = -this.stepsContainer.width >> 1;
         this.stepsContainer.y = this._leftRankY + (this.rankLeft.height - this.stepsContainer.height >> 1);
         if(!param2)
         {
            _loc6_ = this.stepsContainer.x - _loc4_.width - (this.getShieldOffset(_loc4_) >> 1) + RANKS_OFFSETS_MAP[this._widgetSize][IDX_RANK_LEFT];
            _loc7_ = this.stepsContainer.x + this.stepsContainer.width + (this.getShieldOffset(_loc5_) >> 1) + RANKS_OFFSETS_MAP[this._widgetSize][IDX_RANK_RIGHT];
            if(param1)
            {
               this._rightRankX = _loc6_;
               this._leftRankX = _loc7_;
            }
            else
            {
               this._leftRankX = _loc6_;
               this._rightRankX = _loc7_;
            }
         }
         else
         {
            this._leftRankX = -_loc4_.width >> 1;
            this._rightRankX = -_loc5_.width >> 1;
            if(param3 && StringUtils.isNotEmpty(this._infoTF.htmlText))
            {
               this._leftRankY = this._rightRankY = CENTER_RANK_Y;
            }
         }
      }
      
      public function runStepsShineAnimation() : void
      {
         this.stepsContainer.runStepsShineAnimation();
      }
      
      public function showFinalState() : void
      {
         this._isRightOnLeft = false;
         this._currentAnimationStep = this._animationSteps.length - 1;
         invalidate(INV_FINAL_STATE);
      }
      
      public function tryToChangeData() : void
      {
         if(this._model.newRankVO != null)
         {
            if(this._model.state == RANKEDBATTLES_ALIASES.RANK_LOST_STATE || this._model.state == RANKEDBATTLES_ALIASES.QUAL_DIVISION_FINISHED_STATE)
            {
               this.rankRight.update(this._model.newRankVO);
               this.rankRight.validateNow();
               this.rankRight.x = -this.rankRight.width >> 1;
               this.rankRight.y = RANK_NORMAL_Y;
            }
            else
            {
               this.rankLeft.update(this._model.newRankVO);
               this.rankLeft.validateNow();
               this.rankLeft.x = -this.rankLeft.width >> 1;
               this.rankLeft.y = RANK_NORMAL_Y;
            }
         }
      }
      
      public function tryToChangeLeagueData() : void
      {
         if(this._model.newLeagueVO != null)
         {
            this.league.update(this._model.newLeagueVO);
         }
      }
      
      public function tryToChangeStepsData() : void
      {
         if(this._model.newStepsContainerVO != null)
         {
            this.stepsContainer.setData(this._model.newStepsContainerVO);
            this.stepsContainer.validateNow();
         }
      }
      
      public function useButtonMode() : void
      {
         useHandCursor = buttonMode = true;
         this.rankLeft.useButtonMode(true);
         this.rankRight.useButtonMode(true);
         this.stepsContainer.useButtonMode(true);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      private function showReflection() : void
      {
         switch(this._model.state)
         {
            case RANKEDBATTLES_ALIASES.FIRST_RANK_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE:
            case RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE:
            case RANKEDBATTLES_ALIASES.RANK_LOST_STATE:
               this.rankRight.showReflection(true,true);
               break;
            case RANKEDBATTLES_ALIASES.RANK_IDLE_STATE:
               this._scheduler.scheduleTask(this.showReflectionCallback,REPLECTION_LOOP_DELAY);
         }
      }
      
      private function showReflectionCallback() : void
      {
         this.rankLeft.showReflection(true,true);
      }
      
      private function clearAnimationSteps() : void
      {
         var _loc1_:IDisposable = null;
         if(this._animationSteps)
         {
            for each(_loc1_ in this._animationSteps)
            {
               _loc1_.dispose();
            }
            this._animationSteps.splice(0,this._animationSteps.length);
         }
      }
      
      private function runAnimation() : void
      {
         this.bonusBattles.hide();
         this._animator.runAnimation(this._model.state);
         this.runStepsShineAnimation();
      }
      
      private function setFinalStateData(param1:Boolean = true) : void
      {
         var _loc2_:RankedBattlesHangarWidgetVO = null;
         var _loc3_:Vector.<String> = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         _loc2_ = this._animationSteps[this._currentAnimationStep].finalState;
         if(_loc2_)
         {
            _loc3_ = _loc2_.stepsContainerVO.steps;
            _loc4_ = _loc3_ && _loc3_.length;
            this.stepsContainer.visible = _loc4_;
            if(_loc4_)
            {
               this.stepsContainer.setData(_loc2_.stepsContainerVO);
               if(param1)
               {
                  this.stepsContainer.validateNow();
               }
            }
            _loc5_ = _loc2_.rankRightVO != null;
            if(_loc5_)
            {
               this.rankRight.update(_loc2_.rankRightVO);
               if(param1)
               {
                  this.rankRight.validateNow();
               }
            }
            this.rankLeft.update(_loc2_.rankLeftVO);
            if(param1)
            {
               this.rankLeft.validateNow();
            }
         }
      }
      
      private function setFinalStateLayout() : void
      {
         var _loc1_:RankedBattlesHangarWidgetVO = this._animationSteps[this._currentAnimationStep].finalState;
         var _loc2_:Boolean = _loc1_.rankRightVO != null;
         if(_loc2_)
         {
            this.standardLayout();
            this.rankRight.visible = true;
         }
         else
         {
            this.leftRankToCenter();
            this.rankRight.visible = false;
         }
         this.rankLeft.visible = true;
      }
      
      private function getShieldOffset(param1:IRankIcon) : int
      {
         var _loc2_:Number = param1.getShieldOffset(this._widgetSize);
         if(isNaN(_loc2_))
         {
            _loc2_ = !!param1.hasVisibleShield() ? Number(RankShield.SHIELD_OFFSETS[this._widgetSize]) : Number(0);
         }
         return _loc2_;
      }
      
      private function removeHoverListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      private function tryClear() : void
      {
         this._scheduler.cancelTask(this.runAnimation);
         this._scheduler.cancelTask(this.showReflectionCallback);
         this._animator.tryDisposeTweens();
         this.bg.gotoAndStop(1);
         this.rankLeft.showReflection(false);
         this.rankRight.showReflection(false);
         this.infoText.alpha = 1;
         this.rankLeft.update(null);
         this.rankRight.update(null);
         this.backFlash.visible = false;
         this.backFlash.gotoAndStop(1);
      }
      
      private function layoutBackFlash() : void
      {
         var _loc1_:IRankIcon = RANKEDBATTLES_ALIASES.RANK_LEFT_BACK_FLASH_STATES.indexOf(this._model.state) != Values.DEFAULT_INT ? this.rankLeft : this.rankRight;
         this.backFlash.x = _loc1_.x + (_loc1_.width >> 1);
         this.backFlash.y = _loc1_.y + (_loc1_.height >> 1);
      }
      
      private function rebuildLayout() : void
      {
         this._showRedBackground = false;
         this.league.visible = false;
         this.rankLeft.alpha = 1;
         this.rankRight.alpha = 1;
         this.stepsContainer.alpha = 1;
         switch(this._model.state)
         {
            case RANKEDBATTLES_ALIASES.QUAL_IDLE_STATE:
            case RANKEDBATTLES_ALIASES.QUAL_DIVISION_FINISHED_STATE:
               this.rightRankToCenter();
               this.rankRight.visible = true;
               this.rankLeft.visible = false;
               this.stepsContainer.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.RANK_INIT_STATE:
               this.rightRankToCenter();
               this.rankRight.visible = true;
               this.rankLeft.visible = false;
               this.stepsContainer.visible = true;
               this.placeStepContainer(DisplayObject(this.rankRight));
               break;
            case RANKEDBATTLES_ALIASES.RANK_IDLE_STATE:
               this.standardLayout();
               this.rankLeft.visible = true;
               this.rankRight.visible = true;
               this.stepsContainer.visible = true;
               this.infoText.alpha = 0;
               break;
            case RANKEDBATTLES_ALIASES.FIRST_RANK_RECEIVE_STATE:
               this.rankLeft.visible = false;
               this.rankRight.visible = true;
               this.rightRankToCenter();
               this._showRedBackground = true;
               this.stepsContainer.visible = true;
               this.placeStepContainer(DisplayObject(this.rankRight));
               break;
            case RANKEDBATTLES_ALIASES.FIRST_RANK_REACHIVE_STATE:
               this.rightRankToCenter();
               this.rankRight.visible = true;
               this.rankLeft.visible = false;
               this.stepsContainer.visible = true;
               this.placeStepContainer(DisplayObject(this.rankRight));
               break;
            case RANKEDBATTLES_ALIASES.RANK_RECEIVE_STATE:
               this.standardLayout();
               this.rankLeft.visible = true;
               this.rankRight.visible = true;
               this.infoText.alpha = 0;
               this.stepsContainer.visible = true;
               break;
            case RANKEDBATTLES_ALIASES.LEAGUE_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.DIVISION_RECEIVE_STATE:
            case RANKEDBATTLES_ALIASES.RANK_REACHIVE_STATE:
            case RANKEDBATTLES_ALIASES.RANK_LOST_STATE:
            case RANKEDBATTLES_ALIASES.FIRST_RANK_LOST_STATE:
               this.standardLayout();
               this.infoText.alpha = 0;
               this.rankLeft.visible = true;
               this.rankRight.visible = true;
               this.stepsContainer.visible = true;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_FULL_RENEW:
               this.standardLayout();
               this.rankLeft.visible = true;
               this.rankRight.visible = true;
               this.stepsContainer.visible = true;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_FROM_FULL:
               this.standardLayout();
               this.rankLeft.visible = true;
               this.rankRight.visible = true;
               this.stepsContainer.visible = true;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_NOT_FULL:
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP:
               this.leftRankToCenter();
               this.rankLeft.visible = true;
               this.rankRight.visible = false;
               this.stepsContainer.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_RENEW:
               this.leftRankToCenter();
               this.rankLeft.visible = true;
               this.rankRight.visible = false;
               this.stepsContainer.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE:
               this.leftRankToCenter();
               this.rankLeft.visible = true;
               this.rankRight.visible = false;
               this.stepsContainer.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.LEAGUE_IDLE_STATE:
            case RANKEDBATTLES_ALIASES.LEAGUE_INCREASE_STATE:
            case RANKEDBATTLES_ALIASES.LEAGUE_DECREASE_STATE:
               this.rankLeft.visible = false;
               this.rankRight.visible = false;
               this.stepsContainer.visible = false;
               this.league.visible = true;
         }
         this.layoutBackFlash();
         if(RANKEDBATTLES_ALIASES.RANK_ANIMATED_STATES.indexOf(this._model.state) != Values.DEFAULT_INT)
         {
            this._scheduler.scheduleOnNextFrame(this.runAnimation);
         }
         else if(this._model.isHuge)
         {
            this._scheduler.scheduleTask(this.runStepsAnimation,HUGE_STEPS_ANIM_TIMER);
         }
         else
         {
            this.runStepsAnimation();
         }
         this.resizeHit();
      }
      
      private function runStepsAnimation() : void
      {
         this.runStepsShineAnimation();
         this.animationFinished();
         if(this._model.isHuge && StringUtils.isEmpty(this.stepsContainer.getStepsState()))
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_RANK_NOTHING_POST_BATTLE);
         }
      }
      
      private function resizeHit() : void
      {
         var _loc1_:IRankIcon = null;
         var _loc2_:IRankIcon = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.bonusBattles.y = this._widgetSize == RANKEDBATTLES_ALIASES.WIDGET_SMALL ? Number(BONUS_BATTLES_Y_SMALL) : Number(BONUS_BATTLES_Y);
         if(this._model == null || this._model.leagueVO == null)
         {
            _loc1_ = null;
            _loc2_ = null;
            if(!this.rankLeft.visible || this.rankLeft.alpha != 1)
            {
               _loc1_ = _loc2_ = this.rankRight;
            }
            else if(!this.rankRight.visible || this.rankRight.alpha != 1)
            {
               _loc1_ = _loc2_ = this.rankLeft;
            }
            else
            {
               _loc1_ = this.rankLeft;
               _loc2_ = this.rankRight;
            }
            if(_loc1_ == _loc2_)
            {
               _loc3_ = _loc1_.x;
               _loc4_ = _loc1_.y;
               _loc5_ = _loc1_.width;
               _loc6_ = _loc1_.height;
            }
            else
            {
               _loc3_ = Math.min(_loc1_.x,_loc2_.x);
               _loc4_ = Math.min(_loc1_.y,_loc2_.y);
               _loc5_ = Math.max(_loc1_.x + _loc1_.width,_loc2_.x + _loc2_.width) - _loc3_;
               _loc6_ = Math.max(_loc1_.y + _loc1_.height,_loc2_.y + _loc2_.height) - _loc4_;
            }
            this.hit.x = _loc3_;
            this.hit.y = _loc4_ - HIT_OFFSET;
            this.hit.width = _loc5_;
            this.hit.height = _loc6_ + (HIT_OFFSET << 1);
            if(this._model.state == RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP_FROM_FULL || this._model.state == RANKEDBATTLES_ALIASES.ANIM_SHIELD_NOT_FULL || this._model.state == RANKEDBATTLES_ALIASES.ANIM_SHIELD_LOSE_STEP)
            {
               this.bonusBattles.y += BONUS_BATTLES_SHIELD_GAP;
            }
         }
         else
         {
            this.hit.width = this.league.width;
            this.hit.height = this.league.height;
            this.hit.x = -(this.hit.width >> 1);
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function leftRankToCenter(param1:Boolean = false) : void
      {
         this.recalculateLayout(false,true,param1);
         this.rankLeft.x = this._leftRankX;
         this.rankLeft.y = this._leftRankY;
      }
      
      private function standardLayout() : void
      {
         this.recalculateLayout();
         this.positionRanks();
      }
      
      private function changeWidgetSize() : void
      {
         if(this._model.isHuge)
         {
            this._widgetSize = RANKEDBATTLES_ALIASES.WIDGET_HUGE;
         }
         else if(this._isSmall)
         {
            this._widgetSize = RANKEDBATTLES_ALIASES.WIDGET_SMALL;
         }
         else
         {
            this._widgetSize = RANKEDBATTLES_ALIASES.WIDGET_MEDIUM;
         }
      }
      
      private function positionRanks() : void
      {
         this.rankLeft.x = this._leftRankX;
         this.rankRight.x = this._rightRankX;
         this.rankLeft.y = this._leftRankY;
         this.rankRight.y = this._rightRankY;
      }
      
      private function rightRankToCenter() : void
      {
         this.recalculateLayout(false,true,!this._model.isHuge);
         this.rankRight.x = this._rightRankX;
         this.rankRight.y = this._rightRankY;
      }
      
      override public function get width() : Number
      {
         return this._widgetSize == RANKEDBATTLES_ALIASES.WIDGET_HUGE ? Number(_width) : Number(SIZES[this._widgetSize]);
      }
      
      override public function get marginRight() : int
      {
         return MARGIN[this._widgetSize][RIGHT_MARGIN_INDEX];
      }
      
      override public function get marginLeft() : int
      {
         return MARGIN[this._widgetSize][LEFT_MARGIN_INDEX];
      }
      
      public function get leftRankX() : int
      {
         return this._leftRankX;
      }
      
      public function get leftRankY() : int
      {
         return this._leftRankY;
      }
      
      public function get rightRankX() : int
      {
         return this._rightRankX;
      }
      
      public function get rightRankY() : int
      {
         return this._rightRankY;
      }
      
      public function set isRightOnLeft(param1:Boolean) : void
      {
         this._isRightOnLeft = param1;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ != 0)
         {
            return;
         }
         onWidgetClickS();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.bg.gotoAndPlay(!!this._showRedBackground ? SHOW_RED_LABEL : ComponentState.OVER);
         if(this._model && !this._model.isHuge)
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_WIDGET_OVER);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.bg.gotoAndPlay(!!this._showRedBackground ? OUT_RED_LABEL : ComponentState.OUT);
      }
      
      private function onStepsContStepAnimInProgressHandler(param1:StepEvent) : void
      {
         this.playStateSound(param1.state);
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
