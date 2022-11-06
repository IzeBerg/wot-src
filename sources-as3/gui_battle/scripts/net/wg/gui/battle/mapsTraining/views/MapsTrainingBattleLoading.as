package net.wg.gui.battle.mapsTraining.views
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.mapsTraining.views.data.MapsTrainingBattleLoadingVO;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.bootcamp.introVideoPage.containers.LoadingContainer;
   import net.wg.gui.bootcamp.introVideoPage.containers.StepperContainer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.IMapsTrainingBattleLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.MapsTrainingBattleLoadingMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.events.ButtonEvent;
   
   public class MapsTrainingBattleLoading extends MapsTrainingBattleLoadingMeta implements IMapsTrainingBattleLoadingMeta
   {
      
      private static const BACKGROUND_WIDTH:Number = 2560;
      
      private static const BACKGROUND_HEIGHT:Number = 1440;
      
      private static const BACKGROUND_ASPECT_RATIO:Number = BACKGROUND_WIDTH / BACKGROUND_HEIGHT;
      
      private static const STEPPER_OFFSET:int = 84;
      
      private static const STEPPER_OFFSET_MIN:int = 44;
      
      private static const FULL_PROGRESS:int = 100;
      
      private static const BTN_OFFSET:int = 50;
      
      private static const BTN_OFFSET_MIN:int = 10;
      
      private static const LOADING_PROGRESS_OFFSET:int = 37;
      
      private static const LOADING_PROGRESS_OFFSET_MIN:int = 58;
      
      private static const CONTAINER_WIDTH:int = 1920;
      
      private static const CONTAINER_HEIGHT:int = 1080;
      
      private static const SCREEN_WIDTH_MIN:int = 1024;
      
      private static const SCREEN_HEIGHT_MIN:int = 768;
      
      private static const HEADER_OFFSET:int = 203;
      
      private static const HEADER_OFFSET_MIN:int = 161;
      
      private static const DESCRIPTION_OFFSET:int = 145;
      
      private static const DESCRIPTION_OFFSET_MIN:int = 103;
       
      
      public var btnLeft:MovieClip = null;
      
      public var btnRight:MovieClip = null;
      
      public var backgroundContainer:MovieClip = null;
      
      public var stepperBar:StepperContainer = null;
      
      public var loadingProgress:LoadingContainer = null;
      
      public var background:UILoaderAlt = null;
      
      private var _data:MapsTrainingBattleLoadingVO = null;
      
      private var _dataPage:Vector.<BCTutorialPageVO> = null;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _isMinResolution:Boolean = false;
      
      private var _tutorialPageList:Vector.<TutorialPageContainer>;
      
      private var _picIndex:int = 0;
      
      public function MapsTrainingBattleLoading()
      {
         this._tutorialPageList = new Vector.<TutorialPageContainer>();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnLeft.enabled = false;
         this.background.addEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler,false,0,true);
      }
      
      private function setBackgroundPosition() : void
      {
         this.backgroundContainer.x = this._stageWidth - CONTAINER_WIDTH >> 1;
         this.backgroundContainer.y = this._stageHeight - CONTAINER_HEIGHT >> 1;
      }
      
      private function setStepperPosition() : void
      {
         this.stepperBar.x = this._stageWidth - this.stepperBar.width >> 1;
         this.stepperBar.y = !!this._isMinResolution ? Number(STEPPER_OFFSET_MIN) : Number(STEPPER_OFFSET);
      }
      
      private function setTextsPosition() : void
      {
         var _loc1_:TutorialPageContainer = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._tutorialPageList.length)
         {
            _loc1_ = this._tutorialPageList[this._picIndex];
            _loc2_ = !!this._isMinResolution ? int(HEADER_OFFSET_MIN) : int(HEADER_OFFSET);
            _loc3_ = !!this._isMinResolution ? int(DESCRIPTION_OFFSET_MIN) : int(DESCRIPTION_OFFSET);
            _loc1_.setTextsY(this._stageHeight - this.backgroundContainer.y,_loc2_,_loc3_);
         }
      }
      
      private function setBackgroundSize() : void
      {
         this.background.width = this._stageHeight * BACKGROUND_ASPECT_RATIO;
         this.background.height = this._stageHeight;
         if(this.background.width < this._stageWidth)
         {
            this.background.width = this._stageWidth;
         }
         this.background.x = this._stageWidth - this.background.width >> 1;
      }
      
      private function updatePosition() : void
      {
         var _loc1_:int = 0;
         this.setBackgroundPosition();
         this.setStepperPosition();
         this.setTextsPosition();
         this.setBackgroundSize();
         _loc1_ = !!this._isMinResolution ? int(BTN_OFFSET_MIN) : int(BTN_OFFSET);
         this.btnLeft.x = _loc1_;
         this.btnLeft.y = this._stageHeight - this.btnLeft.height >> 1;
         this.btnRight.x = this._stageWidth - _loc1_;
         this.btnRight.y = this._stageHeight - this.btnRight.height >> 1;
         this.loadingProgress.x = this._stageWidth >> 1;
         this.loadingProgress.y = this._stageHeight + (!!this._isMinResolution ? LOADING_PROGRESS_OFFSET_MIN : LOADING_PROGRESS_OFFSET);
         this.loadingProgress.setWidth(this._stageWidth);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._stageWidth = param1;
         this._stageHeight = param2;
         this._isMinResolution = this._stageWidth <= SCREEN_WIDTH_MIN || this._stageHeight <= SCREEN_HEIGHT_MIN;
         this.updatePosition();
      }
      
      private function createImagesList() : void
      {
         var _loc3_:BCTutorialPageVO = null;
         var _loc4_:TutorialPageContainer = null;
         if(this._tutorialPageList.length)
         {
            this.disposeBackgroundRenderers();
         }
         var _loc1_:int = this._dataPage.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._dataPage[_loc2_];
            _loc4_ = App.utils.classFactory.getComponent(_loc3_.rendererLinkage,TutorialPageContainer);
            _loc4_.setData(_loc3_);
            this._tutorialPageList.push(_loc4_);
            _loc2_++;
         }
         if(_loc1_)
         {
            this.stepperBar.setCount(_loc1_);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.updateBackground();
         }
         if(this._dataPage && isInvalid(InvalidationType.DATA))
         {
            this.createImagesList();
            this.updateBackgroundRenderer();
            this.updatePosition();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.background.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler);
         super.onBeforeDispose();
      }
      
      private function disposeBackgroundRenderers() : void
      {
         var _loc3_:TutorialPageContainer = null;
         var _loc1_:int = this._tutorialPageList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._tutorialPageList[_loc2_];
            _loc3_.dispose();
            _loc2_++;
         }
         this._tutorialPageList.splice(0,this._tutorialPageList.length);
      }
      
      override protected function onDispose() : void
      {
         this.btnLeft = null;
         this.btnRight = null;
         if(this.backgroundContainer.numChildren > 0)
         {
            this.backgroundContainer.removeChildAt(0);
         }
         this.backgroundContainer = null;
         this.stepperBar.dispose();
         this.stepperBar = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this.background.dispose();
         this.background = null;
         this._data = null;
         this._dataPage = null;
         this.disposeBackgroundRenderers();
         this._tutorialPageList = null;
         super.onDispose();
      }
      
      private function updateArrows() : void
      {
         this.btnLeft.enabled = true;
         this.btnRight.enabled = true;
         if(this._picIndex == 0)
         {
            this.btnLeft.enabled = false;
         }
         else if(this._picIndex == this._tutorialPageList.length - 1)
         {
            this.btnRight.enabled = false;
         }
      }
      
      private function updateBackground() : void
      {
         this.background.source = this._data.backgrounds[this._picIndex];
      }
      
      private function updateBackgroundRenderer() : void
      {
         if(this._tutorialPageList.length)
         {
            if(this.backgroundContainer.numChildren > 0)
            {
               this.backgroundContainer.removeChildAt(0);
            }
            this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
            this.stepperBar.selectItem(this._picIndex);
            this.setTextsPosition();
         }
      }
      
      private function setPage(param1:Boolean) : void
      {
         if(param1)
         {
            this._picIndex = this._picIndex < this._tutorialPageList.length - 1 ? int(this._picIndex + 1) : int(0);
         }
         else
         {
            this._picIndex = this._picIndex > 0 ? int(this._picIndex - 1) : int(this._tutorialPageList.length - 1);
         }
         this.updateArrows();
         this.updateBackground();
         this.updateBackgroundRenderer();
      }
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         this.setPage(param1.currentTarget == this.btnRight);
      }
      
      private function onBackgroundCompleteHandler(param1:UILoaderEvent) : void
      {
         this.setBackgroundSize();
      }
      
      override protected function setData(param1:MapsTrainingBattleLoadingVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setDataPage(param1:Vector.<BCTutorialPageVO>) : void
      {
         this._dataPage = param1;
         invalidateData();
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * FULL_PROGRESS + 1;
         if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
         {
            this.loadingProgress.gotoAndStop(_loc2_ < FULL_PROGRESS ? _loc2_ : FULL_PROGRESS);
         }
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
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
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
      
      override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
      }
   }
}
