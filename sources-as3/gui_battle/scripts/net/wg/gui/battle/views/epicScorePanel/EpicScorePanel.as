package net.wg.gui.battle.views.epicScorePanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.views.epicScorePanel.components.HeadquarterEntryAnimated;
   import net.wg.gui.battle.views.epicScorePanel.components.SectorBaseEntryAnimated;
   import net.wg.gui.battle.views.epicScorePanel.events.EpicScorePanelEvent;
   import net.wg.infrastructure.base.meta.IEpicScorePanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicScorePanelMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   import net.wg.utils.IScheduler;
   
   public class EpicScorePanel extends EpicScorePanelMeta implements IEpicScorePanelMeta, IEpicBattleStatisticDataController
   {
      
      private static const SECTOR_TO_LANE_MAP:Vector.<int> = new <int>[1,2,3,1,2,3];
      
      private static const PREBATTLE_TIMER_OFFSET:int = 4;
      
      private static const SECOND_ROW_LAME_OFFSET:int = 3;
      
      private static const CAPTURED_VALUE:Number = 1;
      
      private static const MILISECONDS:int = 1000;
      
      private static const INTRO_COUNTDOWN_STATE:String = "intro-countdown";
      
      private static const INTRO_STAGE1_STATE:String = "intro-stage1";
      
      private static const STAGE1_STATE:String = "stage1";
      
      private static const STAGE2_STATE:String = "stage2";
      
      private static const STAGE3_STATE:String = "stage3";
      
      private static const STAGE1_3_STATE:String = "stage1+3";
      
      private static const STAGE2_3_STATE:String = "stage2+3";
      
      private static const LANE_1_BASE_1:int = 0;
      
      private static const LANE_1_BASE_2:int = 3;
      
      private static const LANE_2_BASE_1:int = 1;
      
      private static const LANE_2_BASE_2:int = 4;
      
      private static const LANE_3_BASE_1:int = 2;
      
      private static const LANE_3_BASE_2:int = 5;
      
      private static const FULL_CAPTURED_BASE_VALUE:Number = 1;
      
      private static const PREBATTLE_TRANSITION_TIMER_LENGTH:Number = 3000;
      
      private static const INTRO_STAGE_ANIMATION_START_FRAME:int = 53;
      
      private static const INTRO_STAGE1_ANIMATION_ENDFRAME_FRAME:int = 88;
       
      
      public var base_1:SectorBaseEntryAnimated = null;
      
      public var base_2:SectorBaseEntryAnimated = null;
      
      public var base_3:SectorBaseEntryAnimated = null;
      
      public var base_4:SectorBaseEntryAnimated = null;
      
      public var base_5:SectorBaseEntryAnimated = null;
      
      public var base_6:SectorBaseEntryAnimated = null;
      
      public var headquarters:MovieClip = null;
      
      public var shadowStretch:MovieClip = null;
      
      public var stageLabel:MovieClip = null;
      
      public var laneHighlight:MovieClip = null;
      
      private var _isAttacker:Boolean = false;
      
      private var _currentActiveTarget:MovieClip;
      
      private var _headquartersActive:Boolean = false;
      
      private var _basesProgress:Vector.<Number> = null;
      
      private var _basesMCList:Vector.<SectorBaseEntryAnimated> = null;
      
      private var _headquartersMCList:Vector.<HeadquarterEntryAnimated> = null;
      
      private var _headquartersStates:Vector.<Number> = null;
      
      private var _currentLane:int = -1;
      
      private var _state:String = "";
      
      private var _scheduler:IScheduler = null;
      
      private var _currentTargetType:int = -1;
      
      private var _currentTargetID:int = -1;
      
      private var _stateToTransition:String = "intro-countdown";
      
      private var _inPrebattleState:Boolean = true;
      
      public function EpicScorePanel()
      {
         super();
         this._scheduler = App.utils.scheduler;
         addFrameScript(INTRO_STAGE_ANIMATION_START_FRAME,this.delayedIntroStateTransitionEndTask);
         addFrameScript(INTRO_STAGE1_ANIMATION_ENDFRAME_FRAME,this.delayedUpdateTargetTask);
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         if(param1)
         {
            invalidateState();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:HeadquarterEntryAnimated = null;
         addFrameScript(INTRO_STAGE_ANIMATION_START_FRAME,null);
         addFrameScript(INTRO_STAGE1_ANIMATION_ENDFRAME_FRAME,null);
         stop();
         this._basesMCList.splice(0,this._basesMCList.length);
         this._basesMCList = null;
         for each(_loc1_ in this._headquartersMCList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._headquartersMCList.splice(0,this._headquartersMCList.length);
         this._headquartersMCList = null;
         this._basesProgress.splice(0,this._basesProgress.length);
         this._basesProgress = null;
         this._headquartersStates.splice(0,this._headquartersStates.length);
         this._headquartersStates = null;
         this._scheduler.cancelTask(this.preBattleTransitionTask);
         this._scheduler.cancelTask(this.afterPreBattleTransitionTask);
         this._scheduler = null;
         this.base_1.dispose();
         this.base_1 = null;
         this.base_2.dispose();
         this.base_2 = null;
         this.base_3.dispose();
         this.base_3 = null;
         this.base_4.dispose();
         this.base_4 = null;
         this.base_5.dispose();
         this.base_5 = null;
         this.base_6.dispose();
         this.base_6 = null;
         this.headquarters = null;
         this.shadowStretch = null;
         this.stageLabel = null;
         this.laneHighlight = null;
         this._currentActiveTarget = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._basesMCList = new <SectorBaseEntryAnimated>[this.base_1,this.base_2,this.base_3,this.base_4,this.base_5,this.base_6];
         this._headquartersMCList = new <HeadquarterEntryAnimated>[this.headquarters.headquarters_0,this.headquarters.headquarters_1,this.headquarters.headquarters_2,this.headquarters.headquarters_3,this.headquarters.headquarters_4];
         this._basesProgress = new <Number>[0,0,0,0,0,0];
         this._headquartersStates = new <Number>[0,0,0,0,0];
         this.updateScorePanelElementsStates();
         this.checkState();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && !this._inPrebattleState)
         {
            this.setCurrentTarget();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.checkState();
         }
      }
      
      public function as_headquarterDestroyed(param1:int) : void
      {
         this._headquartersStates[param1 - 1] = 0;
         var _loc2_:HeadquarterEntryAnimated = this._headquartersMCList[param1 - 1];
         _loc2_.setDestructionState(true);
         _loc2_.setAsPrimaryTarget(false);
         _loc2_.setHealth(0);
      }
      
      public function as_setPrebattleTimer(param1:int) : void
      {
         if(param1 - PREBATTLE_TIMER_OFFSET > 0)
         {
            this._stateToTransition = INTRO_COUNTDOWN_STATE;
            this._scheduler.scheduleTask(this.preBattleTransitionTask,(param1 - PREBATTLE_TIMER_OFFSET) * MILISECONDS);
            this._inPrebattleState = true;
         }
         else if(param1 > 0)
         {
            this._stateToTransition = INTRO_STAGE1_STATE;
            this._inPrebattleState = true;
         }
         else
         {
            this._stateToTransition = this.reevaluatePanelState();
            this._inPrebattleState = false;
         }
         this.evaluateLockedState();
         invalidateState();
      }
      
      private function setCurrentTarget() : void
      {
         if(this._currentTargetType == EPIC_CONSTS.TARGET_HQ)
         {
            this._headquartersMCList[this._currentTargetID - 1].setAsPrimaryTarget(true);
            this._currentActiveTarget = this._headquartersMCList[this._currentTargetID - 1];
         }
         else if(this._currentTargetType == EPIC_CONSTS.TARGET_BASE)
         {
            this._basesMCList[this._currentTargetID - 1].setAsPrimaryTarget(true);
            this._currentActiveTarget = this._basesMCList[this._currentTargetID - 1];
         }
         else if(this._currentTargetType == EPIC_CONSTS.TARGET_NONE && this._currentActiveTarget)
         {
            this._currentActiveTarget.setAsPrimaryTarget(false);
         }
      }
      
      public function as_setTarget(param1:int, param2:int) : void
      {
         if(param2 <= 0 && param1 != EPIC_CONSTS.TARGET_NONE)
         {
            return;
         }
         if(this._currentActiveTarget)
         {
            this._currentActiveTarget.setAsPrimaryTarget(false);
         }
         this._currentTargetType = param1;
         this._currentTargetID = param2;
         invalidateData();
      }
      
      public function as_updateBases(param1:int, param2:int, param3:int) : void
      {
         if(param1 > 0)
         {
            this._basesProgress[LANE_1_BASE_1] = FULL_CAPTURED_BASE_VALUE;
            if(param1 > 1)
            {
               this._headquartersActive = true;
               this._basesProgress[LANE_1_BASE_2] = FULL_CAPTURED_BASE_VALUE;
            }
         }
         if(param2 > 0)
         {
            this._basesProgress[LANE_2_BASE_1] = FULL_CAPTURED_BASE_VALUE;
            if(param2 > 1)
            {
               this._headquartersActive = true;
               this._basesProgress[LANE_2_BASE_2] = FULL_CAPTURED_BASE_VALUE;
            }
         }
         if(param3 > 0)
         {
            this._basesProgress[LANE_3_BASE_1] = FULL_CAPTURED_BASE_VALUE;
            if(param3 > 1)
            {
               this._headquartersActive = true;
               this._basesProgress[LANE_3_BASE_2] = FULL_CAPTURED_BASE_VALUE;
            }
         }
         this.updateBases();
         this._stateToTransition = this.reevaluatePanelState();
         this.evaluateLockedState();
         this.updateHeadquarterState();
      }
      
      public function as_updateHeadquarterHealth(param1:int, param2:Number) : void
      {
         this._headquartersStates[param1 - 1] = param2;
         this._headquartersMCList[param1 - 1].setHealth(param2);
      }
      
      public function as_updatePointsForBase(param1:int, param2:Number) : void
      {
         this._basesProgress[param1 - 1] = param2;
         this._basesMCList[param1 - 1].setBaseCaptureProgress(param2,SECTOR_TO_LANE_MAP[param1 - 1] != this._currentLane);
      }
      
      public function checkState() : void
      {
         if(this._stateToTransition == this._state)
         {
            return;
         }
         this.state = this._stateToTransition;
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
         this.laneHighlight.gotoAndStop(!!this._isAttacker ? param1.lane : param1.lane + SECOND_ROW_LAME_OFFSET);
         var _loc2_:Boolean = false;
         if(param1.isAttacker != this._isAttacker)
         {
            this._isAttacker = param1.isAttacker;
            this.updateScorePanelElementsStates(false);
            _loc2_ = true;
         }
         if(param1.lane != this._currentLane)
         {
            this._currentLane = param1.lane;
            _loc2_ = true;
         }
         if(_loc2_)
         {
            this.updateBases();
            this._stateToTransition = this.reevaluatePanelState();
            this.evaluateLockedState();
            invalidateState();
         }
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         x = param1 >> 1;
         y = 0;
         this.shadowStretch.width = param1;
         this.shadowStretch.x = 0;
      }
      
      private function updateScorePanelElementsStates(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = this._basesMCList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this._basesMCList[_loc2_].init(_loc2_ + 1,!this._isAttacker);
            this._basesMCList[_loc2_].setBaseState(this._isAttacker,this._basesProgress[_loc2_] >= 1);
            _loc2_++;
         }
         _loc3_ = this._headquartersMCList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1)
            {
               this._headquartersMCList[_loc2_].init(_loc2_ + 1,this._isAttacker);
               this._headquartersMCList[_loc2_].setHealth(this._headquartersStates[_loc2_]);
            }
            else
            {
               this._headquartersMCList[_loc2_].isAttacker(this._isAttacker);
            }
            _loc2_++;
         }
      }
      
      private function evaluateLockedState() : void
      {
         this._basesMCList[3].locked = this._basesProgress[0] < 1 && !this._inPrebattleState;
         this._basesMCList[4].locked = this._basesProgress[1] < 1 && !this._inPrebattleState;
         this._basesMCList[5].locked = this._basesProgress[2] < 1 && !this._inPrebattleState;
      }
      
      private function preBattleTransitionTask() : void
      {
         this._stateToTransition = INTRO_STAGE1_STATE;
         this.checkState();
         this._scheduler.scheduleTask(this.afterPreBattleTransitionTask,PREBATTLE_TRANSITION_TIMER_LENGTH);
      }
      
      private function afterPreBattleTransitionTask() : void
      {
         this._basesMCList[3].locked = true;
         this._basesMCList[4].locked = true;
         this._basesMCList[5].locked = true;
      }
      
      private function reevaluatePanelState() : String
      {
         var _loc1_:int = this._currentLane - 1;
         var _loc2_:String = Values.EMPTY_STR;
         if(this._basesProgress[_loc1_ + SECOND_ROW_LAME_OFFSET] == CAPTURED_VALUE)
         {
            _loc2_ = STAGE3_STATE;
         }
         else if(this._basesProgress[_loc1_] == CAPTURED_VALUE)
         {
            _loc2_ = !!this._headquartersActive ? STAGE2_3_STATE : STAGE2_STATE;
         }
         else
         {
            _loc2_ = !!this._headquartersActive ? STAGE1_3_STATE : STAGE1_STATE;
         }
         return _loc2_;
      }
      
      private function updateHeadquarterState() : void
      {
         var _loc1_:int = this._headquartersMCList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._headquartersMCList[_loc2_].isActive(this._state == STAGE3_STATE);
            _loc2_++;
         }
      }
      
      private function updateBases() : void
      {
         var _loc1_:int = this._basesProgress.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._basesMCList[_loc2_].setBaseCaptureProgress(this._basesProgress[_loc2_],SECTOR_TO_LANE_MAP[_loc2_] != this._currentLane);
            this._basesMCList[_loc2_].setBaseState(this._isAttacker,this._basesProgress[_loc2_] >= 1);
            _loc2_++;
         }
      }
      
      private function setStageText(param1:String) : void
      {
         switch(param1)
         {
            case STAGE1_3_STATE:
            case STAGE1_STATE:
            case INTRO_STAGE1_STATE:
            case INTRO_COUNTDOWN_STATE:
               this.stageLabel.stageTF.text = EPIC_BATTLE.SCOREPANEL_STAGE1;
               break;
            case STAGE2_3_STATE:
            case STAGE2_STATE:
               this.stageLabel.stageTF.text = EPIC_BATTLE.SCOREPANEL_STAGE2;
               break;
            case STAGE3_STATE:
               this.stageLabel.stageTF.text = EPIC_BATTLE.SCOREPANEL_STAGE3;
         }
      }
      
      private function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         this.setStageText(param1);
         gotoAndPlay(param1);
         dispatchEvent(new EpicScorePanelEvent(EpicScorePanelEvent.STATE_CHANGED,param1 == STAGE1_3_STATE || param1 == STAGE2_3_STATE ? EpicScorePanelEvent.DOUBLE_ROW_STATE : EpicScorePanelEvent.SINGLE_ROW_STATE));
      }
      
      private function delayedIntroStateTransitionEndTask() : void
      {
         dispatchEvent(new EpicScorePanelEvent(EpicScorePanelEvent.STATE_CHANGED,EpicScorePanelEvent.PRE_BATTLE_TRANSITION_START));
      }
      
      private function delayedUpdateTargetTask() : void
      {
         if(this._inPrebattleState)
         {
            this._inPrebattleState = false;
         }
         invalidateData();
      }
   }
}
