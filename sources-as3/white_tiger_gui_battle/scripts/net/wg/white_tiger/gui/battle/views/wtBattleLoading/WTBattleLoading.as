package net.wg.white_tiger.gui.battle.views.wtBattleLoading
{
   import flash.display.MovieClip;
   import flash.ui.Keyboard;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.bootcamp.introVideoPage.containers.LoadingContainer;
   import net.wg.gui.bootcamp.introVideoPage.containers.StepperContainer;
   import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
   import net.wg.infrastructure.base.meta.IBCIntroVideoPageMeta;
   import net.wg.infrastructure.base.meta.impl.BCIntroVideoPageMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class WTBattleLoading extends BCIntroVideoPageMeta implements IBCIntroVideoPageMeta
   {
      
      private static const BTN_PADDING:Number = 50;
      
      private static const INTRO_INFO_CHANGED:String = "infoChanged";
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const SMALL_SCREEN_WIDTH:int = 1920;
      
      private static const SMALL_SCREEN_HEIGHT:int = 1080;
      
      private static const FULL_PROGRESS:int = 100;
      
      private static const BACK_WIDTH_BIG:int = 3440;
      
      private static const BACK_WIDTH_SMALL:int = 1920;
      
      private static const BACK_HEIGHT_BIG:int = 1930;
      
      private static const BACK_HEIGHT_SMALL:int = 1080;
      
      private static const TEXT_GROUP_OFFSET_LEFT:int = 168;
      
      private static const TEXT_GROUP_OFFSET_LEFT_SMALL:int = 126;
      
      private static const TEXT_GROUP_OFFSET_BOTTOM:int = 100;
      
      private static const TEXT_Y_OFFSET:int = 18;
      
      private static const TEXT_Y_OFFSET_SMALL:int = 8;
      
      private static const LOADING_PROGRESS_OFFSET_BOTTOM:int = 40;
       
      
      public var backgroundContainer:MovieClip = null;
      
      public var backgroundVignette:MovieClip = null;
      
      public var blackBG:MovieClip = null;
      
      public var loadingProgress:LoadingContainer = null;
      
      public var btnLeft:MovieClip = null;
      
      public var btnRight:MovieClip = null;
      
      public var stepperBar:StepperContainer = null;
      
      private var _inited:Boolean = false;
      
      private var _imageGoRight:Boolean;
      
      private var _tutorialPageList:Vector.<TutorialPageContainer>;
      
      private var _picIndex:int = 0;
      
      private var _introData:BCIntroVideoVO = null;
      
      private var _useBigPictures:Boolean = false;
      
      public function WTBattleLoading()
      {
         this._tutorialPageList = new Vector.<TutorialPageContainer>();
         super();
         focusable = true;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.blackBG.width = param1;
         this.blackBG.height = param2;
         invalidate(STAGE_RESIZED);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.backgroundVignette.mouseChildren = this.backgroundVignette.mouseEnabled = false;
         this.loadingProgress.mouseChildren = this.loadingProgress.mouseEnabled = false;
         this.btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._introData)
         {
            if(isInvalid(INTRO_INFO_CHANGED))
            {
               this.btnLeft.visible = this.btnRight.visible = this._introData.navigationButtonsVisible;
               this.loadingProgress.visible = !this._introData.videoPlayerVisible;
               invalidate(STAGE_RESIZED);
            }
            if(isInvalid(STAGE_RESIZED))
            {
               this.updateUIPosition();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.disposeBackgroundRenderers();
         this.stepperBar.dispose();
         this.stepperBar = null;
         this._tutorialPageList = null;
         this.backgroundContainer = null;
         this.backgroundVignette = null;
         this.blackBG = null;
         this.btnLeft = null;
         this.btnRight = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this._introData = null;
         super.onDispose();
      }
      
      override protected function setData(param1:BCIntroVideoVO) : void
      {
         this._introData = param1;
         invalidate(INTRO_INFO_CHANGED);
      }
      
      public function as_loaded() : void
      {
         this.loadingProgress.gotoAndStop(this.loadingProgress.totalFrames);
      }
      
      public function as_pausePlayback() : void
      {
      }
      
      public function as_resumePlayback() : void
      {
      }
      
      public function as_showIntroPage(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * FULL_PROGRESS;
         if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
         {
            this.loadingProgress.gotoAndStop(_loc2_ + 1);
         }
      }
      
      protected function continueToBattle() : void
      {
         goToBattleS();
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
      
      private function createImagesList() : void
      {
         var _loc4_:BCTutorialPageVO = null;
         var _loc5_:TutorialPageContainer = null;
         this._inited = true;
         if(this._tutorialPageList.length)
         {
            this.disposeBackgroundRenderers();
         }
         var _loc1_:Vector.<BCTutorialPageVO> = !!this._useBigPictures ? this._introData.lessonPagesBigData : this._introData.lessonPagesSmallData;
         var _loc2_:int = _loc1_.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = App.utils.classFactory.getComponent(_loc4_.rendererLinkage,TutorialPageContainer);
            _loc5_.isAdaptable = true;
            _loc5_.setData(_loc4_);
            this._tutorialPageList.push(_loc5_);
            _loc3_++;
         }
         if(_loc2_ > 1)
         {
            this.stepperBar.setCount(_loc2_);
         }
      }
      
      private function updateUIPosition() : void
      {
         var _loc1_:int = App.appWidth;
         var _loc2_:int = App.appHeight;
         var _loc3_:Boolean = _loc1_ > SMALL_SCREEN_WIDTH && _loc2_ > SMALL_SCREEN_HEIGHT;
         if(this._introData && this._introData.showTutorialPages)
         {
            if(this._useBigPictures != _loc3_ || !this._inited)
            {
               this._useBigPictures = _loc3_;
               this.createImagesList();
               this.updateBackgroundRenderer();
            }
            this.backgroundContainer.x = -((!!this._useBigPictures ? BACK_WIDTH_BIG : BACK_WIDTH_SMALL) - _loc1_ >> 1);
            this.backgroundContainer.y = -((!!this._useBigPictures ? BACK_HEIGHT_BIG : BACK_HEIGHT_SMALL) - _loc2_ >> 1);
            this.updateTutorialPageLayout();
         }
         this.backgroundVignette.width = _loc1_;
         this.backgroundVignette.height = _loc2_;
         this.backgroundVignette.x = 0;
         this.backgroundVignette.y = 0;
         this.btnLeft.x = BTN_PADDING;
         this.btnRight.x = App.appWidth - BTN_PADDING;
         this.btnLeft.y = this.btnRight.y = (App.appHeight >> 1) - (this.btnLeft.height >> 1);
         this.stepperBar.x = _loc1_ - this.stepperBar.width >> 1;
         this.loadingProgress.x = _loc1_ >> 1;
         this.loadingProgress.y = _loc2_ + LOADING_PROGRESS_OFFSET_BOTTOM;
         this.loadingProgress.setWidth(_loc1_);
      }
      
      private function updateTutorialPageLayout() : void
      {
         this._tutorialPageList[this._picIndex].updateTextPosition(App.appWidth,!!this._useBigPictures ? int(BACK_HEIGHT_BIG) : int(BACK_HEIGHT_SMALL),-this.backgroundContainer.x,-this.backgroundContainer.y,!!this._useBigPictures ? int(TEXT_GROUP_OFFSET_LEFT) : int(TEXT_GROUP_OFFSET_LEFT_SMALL),TEXT_GROUP_OFFSET_BOTTOM,!!this._useBigPictures ? int(TEXT_Y_OFFSET) : int(TEXT_Y_OFFSET_SMALL));
      }
      
      private function updateBackgroundRenderer() : void
      {
         if(this.backgroundContainer.numChildren > 0)
         {
            this.backgroundContainer.removeChildAt(0);
         }
         this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
         this.updateTutorialPageLayout();
         this.stepperBar.selectItem(this._picIndex);
      }
      
      private function changePage() : void
      {
         if(this._imageGoRight)
         {
            this._picIndex = this._picIndex < this._tutorialPageList.length - 1 ? int(this._picIndex + 1) : int(0);
         }
         else
         {
            this._picIndex = this._picIndex > 0 ? int(this._picIndex - 1) : int(this._tutorialPageList.length - 1);
         }
         this.updateBackgroundRenderer();
      }
      
      private function onKeyPress() : void
      {
         if(this._introData.navigationButtonsVisible)
         {
            if(!this._introData.showTutorialPages)
            {
               this.continueToBattle();
            }
            else
            {
               if(stage.mouseX > App.appWidth >> 1)
               {
                  this._imageGoRight = true;
               }
               else if(stage.mouseX < App.appWidth >> 1)
               {
                  this._imageGoRight = false;
               }
               this.changePage();
            }
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc3_:Number = NaN;
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN)
         {
            _loc3_ = _loc2_.code;
            if(_loc3_ == Keyboard.ENTER || _loc3_ == Keyboard.SPACE)
            {
               this.onKeyPress();
            }
         }
      }
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         this._imageGoRight = param1.currentTarget == this.btnRight;
         this.changePage();
      }
   }
}
