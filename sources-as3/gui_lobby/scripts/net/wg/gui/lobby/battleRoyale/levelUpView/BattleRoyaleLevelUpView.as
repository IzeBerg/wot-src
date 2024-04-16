package net.wg.gui.lobby.battleRoyale.levelUpView
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.battleRoyale.levelUpView.data.BattleRoyaleLevelUpViewVO;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
   import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesAnimatedTitleTextfield;
   import net.wg.gui.lobby.epicBattles.components.prestigeView.RewardRibbon;
   import net.wg.infrastructure.base.meta.IBattleRoyaleLevelUpViewMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleLevelUpViewMeta;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.ITextManager;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   
   public class BattleRoyaleLevelUpView extends BattleRoyaleLevelUpViewMeta implements IBattleRoyaleLevelUpViewMeta, IStageSizeDependComponent
   {
      
      private static const OFFSET_CLOSE_BUTTON:int = 22;
      
      private static const FADE_IN_LENGTH:int = 300;
      
      private static const STANDARD_TOP_RIBBON_RATIO:Number = 0.64;
      
      private static const MAX_LEVEL_INFO_DELAY:int = 1400;
      
      private static const NEXT_BUTTON_DELAY:int = 1500;
      
      private static const STAGE_SIZE_SMALL:String = "small";
      
      private static const STAGE_SIZE_MEDIUM:String = "medium";
      
      private static const STAGE_SIZE_LARGE:String = "large";
      
      private static const NEXT_BTN_PADDING_BOTTOM_BIG:int = 80;
      
      private static const NEXT_BTN_PADDING_BOTTOM_SMALL:int = 50;
      
      private static const MAX_LVL_INFO_OFFSET_Y_BIG:int = 30;
      
      private static const MAX_LVL_INFO_OFFSET_Y_SMALL:int = 25;
      
      private static const TITLE_PADDTING_TOP_BIG:int = 145;
      
      private static const TITLE_PADDTING_TOP_MEDIUM:int = 95;
      
      private static const TITLE_PADDTING_TOP_SMALL:int = 80;
       
      
      public var closeButton:CloseButtonText = null;
      
      public var titleTextWrapper:EpicBattlesAnimatedTitleTextfield = null;
      
      public var rewardRibbon:RewardRibbon = null;
      
      public var nextButton:SoundButtonEx = null;
      
      public var background:BackgroundComponent = null;
      
      public var maxLevelInfo:BattleRoyaleMaxLevelInfo = null;
      
      private var _completedBattleData:BattleRoyaleLevelUpViewVO = null;
      
      private var _nextButtonFadeInTween:Tween = null;
      
      private var _maxLevelInfoFadeInTween:Tween = null;
      
      private var _stageSize:String = null;
      
      private var _stageSizeMgr:IStageSizeManager;
      
      private var _textMgr:ITextManager;
      
      private var _isBigAwards:Boolean = true;
      
      public function BattleRoyaleLevelUpView()
      {
         this._stageSizeMgr = App.stageSizeMgr;
         this._textMgr = App.textMgr;
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         invalidateSize();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.titleTextWrapper.stop();
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._nextButtonFadeInTween != null)
         {
            this._nextButtonFadeInTween.paused = true;
            this._nextButtonFadeInTween.dispose();
            this._nextButtonFadeInTween = null;
         }
         if(this._maxLevelInfoFadeInTween != null)
         {
            this._maxLevelInfoFadeInTween.paused = true;
            this._maxLevelInfoFadeInTween.dispose();
            this._maxLevelInfoFadeInTween = null;
         }
         this.nextButton.dispose();
         this.nextButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.titleTextWrapper.dispose();
         this.titleTextWrapper = null;
         this.rewardRibbon.dispose();
         this.rewardRibbon = null;
         this.background.dispose();
         this.background = null;
         this.maxLevelInfo.dispose();
         this.maxLevelInfo = null;
         this._stageSizeMgr = null;
         this._textMgr = null;
         this._completedBattleData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
         this.closeButton.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeButton.tooltip = RANKED_BATTLES.TOOLTIP_CLOSEBUTTON;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.validateNow();
         this.rewardRibbon.visible = false;
         this.titleTextWrapper.visible = false;
         this.maxLevelInfo.alpha = 0;
         this.maxLevelInfo.visible = false;
         this.nextButton.alpha = 0;
         this.nextButton.visible = false;
         this.nextButton.label = DIALOGS.COMMON_SUBMIT;
         this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this._stageSizeMgr.register(this);
      }
      
      override protected function setData(param1:BattleRoyaleLevelUpViewVO) : void
      {
         this._completedBattleData = param1;
         this.setAwardsDataForSize(this._isBigAwards,true);
         this.rewardRibbon.setLevel(param1.metaLevelVO,Linkages.BATTLE_ROYALE_META_LEVEL_UI,param1.maxLvlReached);
         this.background.setBackground(param1.backgroundImageSrc);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         super.draw();
         if(this._completedBattleData)
         {
            _loc1_ = isInvalid(InvalidationType.SIZE);
            if(isInvalid(InvalidationType.DATA))
            {
               this.startAnimation();
               _loc1_ = true;
            }
            if(_loc1_)
            {
               _loc2_ = App.appWidth;
               _loc3_ = App.appHeight;
               _loc4_ = _loc2_ >> 1;
               this.background.updateStage(_loc2_,_loc3_);
               this.closeButton.x = _loc2_ - this.closeButton.width - OFFSET_CLOSE_BUTTON | 0;
               this.closeButton.y = OFFSET_CLOSE_BUTTON;
               _loc5_ = this._textMgr.getTextStyleById(this._stageSize == STAGE_SIZE_SMALL ? TEXT_MANAGER_STYLES.HERO_TITLE : TEXT_MANAGER_STYLES.EPIC_TITLE,this._completedBattleData.levelUpText);
               this.titleTextWrapper.setText(_loc5_);
               this.rewardRibbon.y = _loc3_ * STANDARD_TOP_RIBBON_RATIO ^ 0;
               if(this._stageSize == STAGE_SIZE_LARGE)
               {
                  this.titleTextWrapper.y = TITLE_PADDTING_TOP_BIG;
                  this.nextButton.y = _loc3_ - this.nextButton.height - NEXT_BTN_PADDING_BOTTOM_BIG | 0;
                  this.maxLevelInfo.y = this.nextButton.y - this.maxLevelInfo.height - MAX_LVL_INFO_OFFSET_Y_BIG | 0;
               }
               else if(this._stageSize == STAGE_SIZE_MEDIUM)
               {
                  this.titleTextWrapper.y = TITLE_PADDTING_TOP_MEDIUM;
                  this.nextButton.y = _loc3_ - this.nextButton.height - NEXT_BTN_PADDING_BOTTOM_SMALL | 0;
                  this.maxLevelInfo.y = this.nextButton.y - this.maxLevelInfo.height - MAX_LVL_INFO_OFFSET_Y_SMALL | 0;
               }
               else
               {
                  this.titleTextWrapper.y = TITLE_PADDTING_TOP_SMALL;
                  this.nextButton.y = _loc3_ - this.nextButton.height - NEXT_BTN_PADDING_BOTTOM_SMALL | 0;
                  this.maxLevelInfo.y = this.nextButton.y - this.maxLevelInfo.height - MAX_LVL_INFO_OFFSET_Y_SMALL | 0;
               }
               this.nextButton.x = _loc4_ - (this.nextButton.width >> 1);
               this.titleTextWrapper.x = _loc2_ - this.titleTextWrapper.getWidth() >> 1;
               this.maxLevelInfo.x = this.rewardRibbon.x = _loc4_;
            }
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 >= StageSizeBoundaries.WIDTH_1920 && param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc3_ = STAGE_SIZE_LARGE;
            _loc4_ = RewardRibbon.SIZE_BIG;
            this.setAwardsDataForSize(true);
         }
         else if(param1 > StageSizeBoundaries.WIDTH_1366 && param2 > StageSizeBoundaries.HEIGHT_768)
         {
            _loc3_ = STAGE_SIZE_MEDIUM;
            _loc4_ = RewardRibbon.SIZE_MEDIUM;
            this.setAwardsDataForSize(true);
         }
         else
         {
            _loc3_ = STAGE_SIZE_SMALL;
            _loc4_ = RewardRibbon.SIZE_SMALL;
            this.setAwardsDataForSize(false);
         }
         if(this._stageSize != _loc3_)
         {
            this._stageSize = _loc3_;
            this.rewardRibbon.ribbonSize = _loc4_;
            this.maxLevelInfo.isSmall = _loc3_ == STAGE_SIZE_SMALL;
            invalidateSize();
         }
      }
      
      private function setAwardsDataForSize(param1:Boolean, param2:Boolean = false) : void
      {
         if(param2 || this._isBigAwards != param1 && this._completedBattleData)
         {
            this._isBigAwards = param1;
            this.rewardRibbon.setAwards(!!param1 ? this._completedBattleData.awards : this._completedBattleData.awardsSmall);
         }
      }
      
      private function startAnimation() : void
      {
         this.titleTextWrapper.visible = true;
         this.titleTextWrapper.gotoAndPlay(EpicBattlesAnimatedTitleTextfield.LEVEL_UP_ANIM_FRAME_LBL);
         this.rewardRibbon.visible = true;
         this.rewardRibbon.show();
         onRibbonStartsPlayingS();
         this.nextButton.visible = true;
         this._nextButtonFadeInTween = new Tween(FADE_IN_LENGTH,this.nextButton,{"alpha":1},{"delay":NEXT_BUTTON_DELAY});
         if(this._completedBattleData.maxLvlReached)
         {
            this.maxLevelInfo.visible = true;
            this._maxLevelInfoFadeInTween = new Tween(FADE_IN_LENGTH,this.maxLevelInfo,{"alpha":1},{"delay":MAX_LEVEL_INFO_DELAY});
         }
      }
      
      private function onNextButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         onEscapePressS();
      }
   }
}
