package net.wg.gui.lobby.rankedBattles19.view
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardDivision;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardDivisionBase;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardLeague;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardTitle;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.GlowRankAnimation;
   import net.wg.gui.lobby.rankedBattles19.components.rankAward.RankAwardAnimation;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattleAwardViewVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesCurrentAwardVO;
   import net.wg.infrastructure.base.meta.IRankedBattlesAwardsViewMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesAwardsViewMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class RankedBattlesAwardView extends RankedBattlesAwardsViewMeta implements IRankedBattlesAwardsViewMeta
   {
      
      public static const NEXT_UI_OFFSET:int = 30;
      
      private static const NEXT_AWARD_TIME:int = 1000;
      
      private static const TITLE_Y:int = 147;
      
      private static const TITLE_Y_SHIFT:int = 105;
      
      private static const SMALL_HEIGHT_X_SHIFT:int = 50;
      
      private static const CLOSE_BUTTON_OFFSET:int = 40;
      
      private static const AWARD_STATIC_HEIGHT:int = 1200;
      
      private static const AWARD_STATIC_WIDTH:int = 1920;
       
      
      public var closeButton:CloseButtonText = null;
      
      public var awards:MovieClip = null;
      
      public var title:AwardTitle = null;
      
      public var rankIcon:GlowRankAnimation = null;
      
      public var qual:AwardDivisionBase = null;
      
      public var division:AwardDivision = null;
      
      public var league:AwardLeague = null;
      
      public var ribbon:MovieClip = null;
      
      public var nextButton:UniversalBtn = null;
      
      public var background:Sprite = null;
      
      public var bonusBattleMc:MovieClip = null;
      
      public var nextButtonY:int = 0;
      
      public var bonusBattleMcY:int = 0;
      
      public var smallHeightXShift:int = 0;
      
      private var _awardAnimation:RankAwardAnimation = null;
      
      private var _data:RankedBattleAwardViewVO = null;
      
      private var _topOffset:int = 0;
      
      private var _currentAnimationStep:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      private var _isAnimationStepRun:Boolean = false;
      
      private var _autoPlayNextAnim:Boolean = true;
      
      private var _lastAnimStep:int = -1;
      
      private var _lastStoppedAnimStep:int = -1;
      
      private var _bonusBattleTf:TextField = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _currentAwardData:RankedBattlesCurrentAwardVO = null;
      
      public function RankedBattlesAwardView()
      {
         super();
         this._scheduler = App.utils.scheduler;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         x = param1 - this.width >> 1;
         y = param2 - this.height >> 1;
         var _loc3_:int = this.background.width / this.background.scaleX;
         var _loc4_:int = this.background.height / this.background.scaleY;
         if(param2 < _loc4_ * param1 / _loc3_)
         {
            this.background.width = param1;
            this.background.scaleY = this.background.scaleX;
         }
         else
         {
            this.background.height = param2;
            this.background.scaleX = this.background.scaleY;
         }
         this.background.x = Math.ceil((this.width - this.background.width) / 2);
         this.background.y = -y + this._topOffset;
         this.closeButton.x = (this.width + param1 >> 1) - this.closeButton.width - CLOSE_BUTTON_OFFSET;
         this.closeButton.y = (this.height - param2 >> 1) + CLOSE_BUTTON_OFFSET;
         this.ribbon.width = param1;
         var _loc5_:int = this.ribbon.y + (this.ribbon.height >> 1);
         var _loc6_:int = this.height + param2 >> 1;
         this.nextButtonY = _loc5_ + (_loc6_ - _loc5_ - this.nextButton.height >> 1);
         this.nextButton.y = this.nextButtonY;
         this.bonusBattleMcY = this.nextButtonY - NEXT_UI_OFFSET;
         this.bonusBattleMc.y = this.bonusBattleMcY;
         this.title.y = TITLE_Y;
         this.smallHeightXShift = 0;
         if(param2 < StageSizeBoundaries.HEIGHT_900 || param1 < StageSizeBoundaries.WIDTH_1600)
         {
            this.title.y += TITLE_Y_SHIFT;
            this.smallHeightXShift = SMALL_HEIGHT_X_SHIFT;
            this.title.isMaximized = false;
         }
         else
         {
            this.title.isMaximized = true;
         }
         if(this.rankIcon.visible)
         {
            this.rankIcon.x = (this.width - RankAwardAnimation.RANK_ICON_X >> 1) - this.smallHeightXShift;
            this.awards.x = this.rankIcon.x + RankAwardAnimation.AWARDS_X_SHIFT;
         }
         if(this.qual.visible)
         {
            this.qual.x = (this.width - RankAwardAnimation.RANK_ICON_X >> 1) - this.smallHeightXShift;
            this.awards.x = this.qual.x + RankAwardAnimation.AWARDS_X_SHIFT;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.bonusBattleMc.removeEventListener(MouseEvent.ROLL_OVER,this.onBonusBattleMcRollOverHandler);
         this.bonusBattleMc.removeEventListener(MouseEvent.ROLL_OUT,this.onBonusBattleMcRollOutHandler);
         this.bonusBattleMc = null;
         this.rankIcon.dispose();
         this.rankIcon = null;
         this.qual.dispose();
         this.qual = null;
         this.division.dispose();
         this.division = null;
         this.league.dispose();
         this.league = null;
         this.nextButton.dispose();
         this.nextButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.title.dispose();
         this.title = null;
         this._awardAnimation.dispose();
         this._awardAnimation = null;
         this._scheduler.cancelTask(this.runAnimationStep);
         this._scheduler = null;
         this.awards = null;
         this.ribbon = null;
         this.background = null;
         this._data = null;
         this._currentAwardData = null;
         this._bonusBattleTf = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._topOffset = App.utils.viewRestrictions.topOffset;
         this._awardAnimation = new RankAwardAnimation(this);
         this.closeButton.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeButton.tooltip = RANKED_BATTLES.TOOLTIP_CLOSEBUTTON;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.title.mouseChildren = this.title.mouseEnabled = false;
         this.rankIcon.mouseChildren = this.rankIcon.mouseEnabled = false;
         App.utils.universalBtnStyles.setStyle(this.nextButton,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.nextButton.visible = false;
         this.bonusBattleMc.addEventListener(MouseEvent.ROLL_OVER,this.onBonusBattleMcRollOverHandler);
         this.bonusBattleMc.addEventListener(MouseEvent.ROLL_OUT,this.onBonusBattleMcRollOutHandler);
         this.bonusBattleMc.visible = false;
         this._bonusBattleTf = this.bonusBattleMc.text;
      }
      
      override protected function setData(param1:RankedBattleAwardViewVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.nextButton.label = this._data.nextButtonLabel;
            this._lastAnimStep = this._data.vosSequence.length - 1;
            this._lastStoppedAnimStep = -1;
            this._currentAnimationStep = 0;
            this.runAnimationStep();
         }
      }
      
      public function animationFinish(param1:Boolean = false) : void
      {
         if(this._autoPlayNextAnim || param1 && this._lastStoppedAnimStep == this._currentAnimationStep)
         {
            ++this._currentAnimationStep;
            if(this._currentAnimationStep <= this._lastAnimStep)
            {
               this._isAnimationStepRun = false;
               if(this._autoPlayNextAnim)
               {
                  this._scheduler.scheduleTask(this.runAnimationStep,NEXT_AWARD_TIME);
               }
               else
               {
                  this.runAnimationStep();
               }
            }
         }
         else
         {
            this._lastStoppedAnimStep = this._currentAnimationStep;
         }
      }
      
      private function runAnimationStep() : void
      {
         this._isAnimationStepRun = true;
         this._currentAwardData = this._data.vosSequence[this._currentAnimationStep];
         this._autoPlayNextAnim = this.getAutoPlayNextAnim();
         this._bonusBattleTf.htmlText = this._currentAwardData.bonusBattleText;
         this._awardAnimation.setData(this._currentAwardData,this._data.title);
         this._awardAnimation.start();
         if(this._currentAnimationStep == 0)
         {
            this._awardAnimation.showTitle();
            this._awardAnimation.showRibbon();
         }
         var _loc1_:String = this._currentAwardData.state;
         if(_loc1_ == RANKEDBATTLES_ALIASES.AWARD_VIEW_RANK_STATE)
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_AWARD_RANK);
         }
         else if(_loc1_ == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE || _loc1_ == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_STATE)
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_AWARD_DIVISION);
         }
         else if(_loc1_ == RANKEDBATTLES_ALIASES.AWARD_VIEW_QUAL_BATTLES_STATE)
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_AWARD_QUALIFICATION);
         }
         else
         {
            onSoundTriggerS(RANKEDBATTLES_ALIASES.SOUND_AWARD_LEAGUE);
         }
      }
      
      private function getAutoPlayNextAnim() : Boolean
      {
         if(this._currentAnimationStep == this._lastAnimStep)
         {
            return false;
         }
         var _loc1_:RankedBattlesCurrentAwardVO = this._data.vosSequence[this._currentAnimationStep];
         if(_loc1_.state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE || _loc1_.state == RANKEDBATTLES_ALIASES.AWARD_VIEW_LEAGUE_STATE)
         {
            return false;
         }
         var _loc2_:RankedBattlesCurrentAwardVO = this._data.vosSequence[this._currentAnimationStep + 1];
         if(_loc2_.state == RANKEDBATTLES_ALIASES.AWARD_VIEW_DIVISION_STATE || _loc2_.state == RANKEDBATTLES_ALIASES.AWARD_VIEW_LEAGUE_STATE)
         {
            return false;
         }
         return true;
      }
      
      private function tryToCloseView() : void
      {
         if(!this._isAnimationStepRun)
         {
            return;
         }
         if(this._currentAnimationStep > this._lastAnimStep || this._currentAnimationStep == this._lastAnimStep && this._lastStoppedAnimStep == this._currentAnimationStep)
         {
            closeViewS();
         }
         else
         {
            this._scheduler.cancelTask(this.runAnimationStep);
            this._awardAnimation.finish();
         }
      }
      
      override public function get width() : Number
      {
         return AWARD_STATIC_WIDTH;
      }
      
      override public function get height() : Number
      {
         return AWARD_STATIC_HEIGHT;
      }
      
      public function get autoPlayNextAnim() : Boolean
      {
         return this._autoPlayNextAnim;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN)
         {
            if(_loc2_.navEquivalent == NavigationCode.ESCAPE)
            {
               this.tryToCloseView();
               param1.handled = true;
            }
         }
      }
      
      private function onNextButtonClickHandler(param1:ButtonEvent) : void
      {
         this.tryToCloseView();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onBonusBattleMcRollOverHandler(param1:MouseEvent) : void
      {
         if(this._currentAwardData != null && StringUtils.isNotEmpty(this._currentAwardData.bonusBattleTooltip))
         {
            this._tooltipMgr.showComplex(this._currentAwardData.bonusBattleTooltip);
         }
      }
      
      private function onBonusBattleMcRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
