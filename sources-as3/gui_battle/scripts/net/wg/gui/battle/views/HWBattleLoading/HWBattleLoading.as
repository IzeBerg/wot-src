package net.wg.gui.battle.views.HWBattleLoading
{
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.views.HWBattleLoading.components.LoadingProgress;
   import net.wg.gui.battle.views.HWBattleLoading.components.TextContainer;
   import net.wg.gui.battle.views.HWBattleLoading.data.BattleLoadingHintVO;
   import net.wg.gui.battle.views.HWBattleLoading.data.LoadingDataVO;
   import net.wg.gui.bootcamp.introVideoPage.containers.StepperContainer;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IHWBattleLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.HWBattleLoadingMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.IScheduler;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ButtonEvent;
   
   public class HWBattleLoading extends HWBattleLoadingMeta implements IHWBattleLoadingMeta
   {
      
      private static const LOADING_WIDTH_SMALL:int = 393;
      
      private static const LOADING_WIDTH:int = 704;
      
      private static const LOADING_MARGIN_Y_SMALL:int = 53;
      
      private static const LOADING_MARGIN_Y:int = 64;
      
      private static const FULL_PROGRESS:int = 100;
      
      private static const BACKGROUND_WIDTH:Number = 2560;
      
      private static const BACKGROUND_HEIGHT:Number = 1440;
      
      private static const BACKGROUND_ASPECT_RATIO:Number = BACKGROUND_WIDTH / BACKGROUND_HEIGHT;
      
      private static const NEXT_DELAY:int = 7000;
      
      private static const BTN_PADDING:Number = 60;
      
      private static const BTN_PADDING_SMALL:Number = 42;
      
      private static const BTN_PADDING_XSMALL:Number = 32;
      
      private static const TEXT_BOTTOM_PADDING:int = 174;
      
      private static const TEXT_BOTTOM_PADDING_SMALL:int = 96;
      
      private static const BTN_WIDTH_SMALL:int = 60;
      
      private static const BTN_HEIGHT_SMALL:int = 118;
      
      private static const BTN_WIDTH:int = 73;
      
      private static const BTN_HEIGHT:int = 145;
      
      private static const TEXT_CONTAINER_X:int = 167;
      
      private static const TEXT_CONTAINER_X_SMALL:int = 117;
      
      private static const TEXT_CONTAINER_X_XSMALL:int = 97;
      
      private static const STEPPER_BAR_Y_XSMALL:int = 45;
      
      private static const STEPPER_BAR_Y_SMALL:int = 65;
      
      private static const STEPPER_BAR_Y:int = 85;
       
      
      public var loadingProgress:LoadingProgress = null;
      
      public var backgroundVignette:MovieClip = null;
      
      public var bottomGradient:MovieClip = null;
      
      public var hintBgLoader:UILoaderAlt = null;
      
      public var blackBG:MovieClip = null;
      
      public var btnLeft:SoundButtonEx = null;
      
      public var btnRight:SoundButtonEx = null;
      
      public var stepperBar:StepperContainer = null;
      
      public var textContainer:TextContainer = null;
      
      public var textShadow:MovieClip = null;
      
      private var _data:LoadingDataVO = null;
      
      private var _hintData:BattleLoadingHintVO = null;
      
      private var _scheduler:IScheduler;
      
      private var _stageWidth:int = -1;
      
      private var _stageHeight:int = -1;
      
      private var _currentPage:int = -1;
      
      public function HWBattleLoading()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override public function as_setProgress(param1:Number) : void
      {
      }
      
      override public function as_setTip(param1:String) : void
      {
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
      }
      
      override public function hasAmmunitionPanel(param1:Boolean) : void
      {
      }
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         if(!param1)
         {
            App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
            this._scheduler.cancelTask(this.showNextPage);
         }
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setPersonalStatus(param1:uint) : void
      {
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      override public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidateSize();
      }
      
      override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.stepperBar.addEventListener(MouseEvent.CLICK,this.onStepperMouseClickHandler);
         this._scheduler.scheduleRepeatableTask(this.showNextPage,NEXT_DELAY,int.MAX_VALUE);
         this.stepperBar.setButtonMode();
         App.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._hintData != null && isInvalid(InvalidationType.DATA))
         {
            this.hintBgLoader.source = this._hintData.background;
            this.stepperBar.selectItem(this._currentPage);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.stepperBar.x = this._stageWidth - this.stepperBar.width >> 1;
            this.validateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnLeft.dispose();
         this.btnRight.dispose();
         this.btnLeft = null;
         this.btnRight = null;
         this.stepperBar.removeEventListener(MouseEvent.CLICK,this.onStepperMouseClickHandler);
         this.stepperBar.dispose();
         this.stepperBar = null;
         this.hintBgLoader.dispose();
         this.hintBgLoader = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this.textContainer.dispose();
         this.textContainer = null;
         this.backgroundVignette = null;
         this.bottomGradient = null;
         this.blackBG = null;
         this.textShadow = null;
         this._hintData = null;
         this._data = null;
         this._scheduler.cancelTask(this.showNextPage);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function setData(param1:LoadingDataVO) : void
      {
         this._data = param1;
         this._currentPage = this._data.currentPageIndex;
         this._hintData = this._data.pages[this._currentPage];
         this.stepperBar.setCount(this._data.pages.length);
         this.textContainer.setPages(this._data.pages);
         this.textContainer.setActiveTitle(this._currentPage);
         invalidateSize();
         invalidateData();
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * FULL_PROGRESS;
         if(_loc2_ < FULL_PROGRESS)
         {
            this.loadingProgress.gotoAndStop(_loc2_ + 1);
         }
         else if(_loc2_ >= FULL_PROGRESS)
         {
            this.loadingProgress.gotoAndStop(FULL_PROGRESS);
            this._scheduler.cancelTask(this.showNextPage);
         }
      }
      
      private function validateSize() : void
      {
         var _loc1_:Boolean = this._stageWidth / this._stageHeight > BACKGROUND_ASPECT_RATIO;
         var _loc2_:int = !!_loc1_ ? int(this._stageWidth) : int(this._stageHeight * BACKGROUND_ASPECT_RATIO);
         var _loc3_:int = !!_loc1_ ? int(this._stageWidth / BACKGROUND_ASPECT_RATIO) : int(this._stageHeight);
         this.hintBgLoader.x = this._stageWidth - _loc2_ >> 1;
         this.hintBgLoader.setOriginalWidth(_loc2_);
         this.hintBgLoader.setOriginalHeight(_loc3_);
         this.hintBgLoader.updateLoaderSize();
         this.bottomGradient.width = this.backgroundVignette.width = this.blackBG.width = this._stageWidth;
         this.backgroundVignette.height = this.blackBG.height = this._stageHeight;
         this.textContainer.updateTextLayout(this._stageWidth);
         this.textContainer.validateNow();
         if(this._stageWidth < StageSizeBoundaries.WIDTH_1366)
         {
            this.btnLeft.width = this.btnRight.width = BTN_WIDTH_SMALL;
            this.btnLeft.height = this.btnRight.height = BTN_HEIGHT_SMALL;
            this.btnLeft.x = BTN_PADDING_XSMALL;
            this.btnRight.x = this._stageWidth - BTN_PADDING_XSMALL;
            this.loadingProgress.setActualSize(LOADING_WIDTH_SMALL,this.loadingProgress.height);
            this.loadingProgress.y = this._stageHeight - LOADING_MARGIN_Y_SMALL;
            this.textContainer.y = this._stageHeight - this.textContainer.getComponentHeight() - TEXT_BOTTOM_PADDING_SMALL;
            this.stepperBar.y = STEPPER_BAR_Y_XSMALL;
            this.textContainer.x = TEXT_CONTAINER_X_XSMALL;
         }
         else if(this._stageWidth < StageSizeBoundaries.WIDTH_1600)
         {
            this.btnLeft.width = this.btnRight.width = BTN_WIDTH_SMALL;
            this.btnLeft.height = this.btnRight.height = BTN_HEIGHT_SMALL;
            this.btnLeft.x = BTN_PADDING_SMALL;
            this.btnRight.x = this._stageWidth - BTN_PADDING_SMALL;
            this.loadingProgress.setActualSize(LOADING_WIDTH_SMALL,this.loadingProgress.height);
            this.loadingProgress.y = this._stageHeight - LOADING_MARGIN_Y_SMALL;
            this.textContainer.y = this._stageHeight - this.textContainer.getComponentHeight() - TEXT_BOTTOM_PADDING_SMALL;
            this.stepperBar.y = STEPPER_BAR_Y_SMALL;
            this.textContainer.x = TEXT_CONTAINER_X_SMALL;
         }
         else
         {
            this.btnLeft.width = this.btnRight.width = BTN_WIDTH;
            this.btnLeft.height = this.btnRight.height = BTN_HEIGHT;
            this.btnLeft.x = BTN_PADDING;
            this.btnRight.x = this._stageWidth - BTN_PADDING;
            this.loadingProgress.setActualSize(LOADING_WIDTH,this.loadingProgress.height);
            this.loadingProgress.y = this._stageHeight - LOADING_MARGIN_Y;
            this.textContainer.y = this._stageHeight - this.textContainer.getComponentHeight() - TEXT_BOTTOM_PADDING;
            this.stepperBar.y = STEPPER_BAR_Y;
            this.textContainer.x = TEXT_CONTAINER_X;
         }
         this.btnLeft.y = this.btnRight.y = (App.appHeight >> 1) - (this.btnLeft.height >> 1);
         this.loadingProgress.x = this._stageWidth - this.loadingProgress.width >> 1;
         this.bottomGradient.y = this._stageHeight - this.bottomGradient.height >> 0;
         this.textShadow.y = this._stageHeight - this.textShadow.height >> 0;
      }
      
      private function updatePageIndex(param1:int) : void
      {
         this._currentPage = param1;
         this._hintData = this._data.pages[this._currentPage];
         this.textContainer.setActiveTitle(this._currentPage);
         invalidateData();
      }
      
      private function updatePage(param1:Boolean) : void
      {
         var _loc2_:int = Values.DEFAULT_INT;
         if(param1)
         {
            _loc2_ = this._currentPage < this._data.pages.length - 1 ? int(this._currentPage + 1) : int(0);
         }
         else
         {
            _loc2_ = this._currentPage > 0 ? int(this._currentPage - 1) : int(this._data.pages.length - 1);
         }
         this.updatePageIndex(_loc2_);
      }
      
      private function showNextPage() : void
      {
         this.updatePage(true);
      }
      
      private function scheduleNextPage() : void
      {
         this._scheduler.cancelTask(this.showNextPage);
         this._scheduler.scheduleRepeatableTask(this.showNextPage,NEXT_DELAY,int.MAX_VALUE);
      }
      
      private function onKeyUpHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB || param1.keyCode == Keyboard.RIGHT)
         {
            this.scheduleNextPage();
            this.showNextPage();
         }
         else if(param1.keyCode == Keyboard.LEFT)
         {
            this.scheduleNextPage();
            this.updatePage(false);
         }
      }
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         this.scheduleNextPage();
         this.updatePage(param1.currentTarget == this.btnRight);
      }
      
      private function onStepperMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = this.stepperBar.getStepperIndex(_loc2_);
         this.scheduleNextPage();
         this.updatePageIndex(_loc3_);
      }
   }
}
