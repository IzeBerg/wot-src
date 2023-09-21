package net.wg.gui.bootcamp.introVideoPage
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.bootcamp.introVideoPage.containers.IntroPageContainer;
   import net.wg.gui.bootcamp.introVideoPage.containers.LoadingContainer;
   import net.wg.gui.bootcamp.introVideoPage.containers.StepperContainer;
   import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
   import net.wg.gui.components.common.video.PlayerStatus;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IBCIntroVideoPageMeta;
   import net.wg.infrastructure.base.meta.impl.BCIntroVideoPageMeta;
   import net.wg.infrastructure.uilogging.deprecated.bootcamp.LoadingPageLogger;
   import net.wg.utils.IScheduler;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.FocusManager;
   import scaleform.gfx.MouseEventEx;
   
   public class BCIntroVideoPage extends BCIntroVideoPageMeta implements IBCIntroVideoPageMeta
   {
      
      private static const BTN_PADDING:Number = 50;
      
      private static const INTRO_INFO_CHANGED:String = "infoChanged";
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const SMALL_SCREEN_WIDTH:int = 1920;
      
      private static const SMALL_SCREEN_HEIGHT:int = 1080;
      
      private static const FULL_PROGRESS:int = 100;
      
      private static const BLACK_FADE_DURATION:int = 2000;
      
      private static const OVERLAY_TWEEN_DURATION:int = 300;
      
      private static const BACK_WIDTH_BIG:int = 3440;
      
      private static const BACK_WIDTH_SMALL:int = 2365;
      
      private static const BACK_HEIGHT_BIG:int = 1930;
      
      private static const BACK_HEIGHT_SMALL:int = 1380;
      
      private static const CLOSE_BTN_PADDING_RIGHT:int = 80;
      
      private static const BTN_SELECT_OFFSET_Y:int = -121;
      
      private static const BTN_START_OFFSET_Y:int = -90;
      
      private static const BTN_SKIP_OFFSET_X:int = 50;
      
      private static const BTN_SKIP_OFFSET_Y:int = -88;
      
      private static const BUTTON_SPACING:int = 30;
      
      private static const WAIT_MC_X:int = -40;
      
      private static const WAIT_MC_Y:int = -35;
      
      private static const WAIT_TF_X:int = -30;
      
      private static const WAIT_TF_Y:int = -46;
      
      private static const GLOW_SELECT_X_OFFSET:int = 190;
      
      private static const GLOW_SELECT_Y_OFFSET:int = 188;
      
      private static const GLOW_START_X_OFFSET:int = 268;
      
      private static const GLOW_START_Y_OFFSET:int = 220;
      
      private static const SELECT_SMALL_OFFSET:int = -26;
      
      private static const SELECT_OFFSET:int = 53;
      
      private static const TWEEN_DURATION:int = 1000;
      
      private static const TWEEN_DELAY:int = 2000;
       
      
      public var videoPlayer:SimpleVideoPlayer = null;
      
      public var introPage:IntroPageContainer = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public var backgroundContainer:MovieClip = null;
      
      public var backgroundVignette:MovieClip = null;
      
      public var blackBG:MovieClip = null;
      
      public var loadingProgress:LoadingContainer = null;
      
      public var btnSelect:SoundButton = null;
      
      public var btnStart:SoundButton = null;
      
      public var btnSkip:SoundButtonEx = null;
      
      public var btnSkipVideo:SoundButtonEx = null;
      
      public var waitingMC:MovieClip = null;
      
      public var waitingTF:TextField = null;
      
      public var blackOverlay:MovieClip = null;
      
      public var btnLeft:MovieClip = null;
      
      public var btnRight:MovieClip = null;
      
      public var stepperBar:StepperContainer = null;
      
      public var selectGlow:MovieClip = null;
      
      protected var eventModeEnabled:Boolean = false;
      
      protected var customTextPaddingLeft:int = 0;
      
      protected var customTextPaddingBottom:int = 0;
      
      protected var customLoadingProgressBottom:int = 0;
      
      private var _inited:Boolean = false;
      
      private var _imageGoRight:Boolean;
      
      private var _tutorialPageList:Vector.<TutorialPageContainer>;
      
      private var _picIndex:int = 0;
      
      private var _introData:BCIntroVideoVO = null;
      
      private var _playerOriginalWidth:Number;
      
      private var _playerOriginalHeight:Number;
      
      private var _playerOriginalScaleX:Number;
      
      private var _playerOriginalScaleY:Number;
      
      private var _useBigPictures:Boolean = false;
      
      private var _tweens:Vector.<Tween>;
      
      private var _loaded:Boolean = false;
      
      private var _videoCompleted:Boolean = false;
      
      private var _skipPrepared:Boolean = false;
      
      private var _skipShown:Boolean = false;
      
      private var _logger:LoadingPageLogger = null;
      
      private var _scheduler:IScheduler;
      
      public function BCIntroVideoPage()
      {
         this._tutorialPageList = new Vector.<TutorialPageContainer>();
         this._tweens = new Vector.<Tween>();
         this._scheduler = App.utils.scheduler;
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
         App.stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         this.closeBtn.label = BOOTCAMP.BTN_TUTORIAL_CLOSE;
         this.closeBtn.visible = false;
         if(this.videoPlayer != null)
         {
            this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler,false,0,true);
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler,false,0,true);
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler,false,0,true);
            this._playerOriginalWidth = this.videoPlayer.width;
            this._playerOriginalHeight = this.videoPlayer.height;
            this._playerOriginalScaleX = this.videoPlayer.scaleX;
            this._playerOriginalScaleY = this.videoPlayer.scaleY;
         }
         this.introPage.logoDescription = BOOTCAMP.WELLCOME_BOOTCAMP_DESCRIPTION;
         this.introPage.setReferralVisibility(false);
         this.btnSkip.label = BOOTCAMP.BTN_TUTORIAL_SKIP;
         this.btnSkipVideo.label = BOOTCAMP.BTN_SKIPVIDEO;
         this.btnSkipVideo.addEventListener(ButtonEvent.CLICK,this.onSkipVideoButtonClickHandler);
         this.blackOverlay.alpha = 0;
         this.backgroundVignette.mouseChildren = this.backgroundVignette.mouseEnabled = false;
         this.blackOverlay.mouseChildren = this.blackOverlay.mouseEnabled = false;
         this.loadingProgress.mouseChildren = this.loadingProgress.mouseEnabled = false;
         this.waitingTF.text = BOOTCAMP.WELLCOME_BOOTCAMP_WAIT;
         this.selectGlow.visible = this.btnSelect.visible = this.btnStart.visible = this.btnSkip.visible = this.btnSkipVideo.visible = false;
         if(getQualifiedSuperclassName(this) == getQualifiedClassName(BCIntroVideoPage))
         {
            this._logger = new LoadingPageLogger(this);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._introData)
         {
            if(isInvalid(INTRO_INFO_CHANGED))
            {
               this.btnLeft.visible = this.btnRight.visible = this._introData.navigationButtonsVisible;
               this.btnSelect.label = this._introData.selectButtonLabel;
               this.btnStart.label = this._introData.selectButtonLabel;
               this.videoPlayer.visible = this._introData.videoPlayerVisible;
               if(this._introData.videoPlayerVisible)
               {
                  this.videoPlayer.bufferTime = this._introData.bufferTime;
                  this.videoPlayer.source = this._introData.source;
               }
               else
               {
                  this.waitingTF.visible = this.waitingMC.visible = false;
                  this.disposePlayer();
                  videoFinishedS();
               }
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
         var _loc1_:Tween = null;
         App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onSkipButtonClickHandler);
         App.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this.disposePlayer();
         this.disposeBackgroundRenderers();
         this.stepperBar.dispose();
         this.stepperBar = null;
         this.closeBtn.dispose();
         this.closeBtn = null;
         this._tutorialPageList = null;
         this.introPage.dispose();
         this.introPage = null;
         this.backgroundContainer = null;
         this.backgroundVignette = null;
         this.blackBG = null;
         this.blackOverlay = null;
         this.btnLeft = null;
         this.btnRight = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         this.btnSelect.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.btnStart.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.btnSkip.removeEventListener(ButtonEvent.CLICK,this.onSkipButtonClickHandler);
         this.btnSkipVideo.removeEventListener(ButtonEvent.CLICK,this.onSkipVideoButtonClickHandler);
         this.btnSelect.dispose();
         this.btnSelect = null;
         this.btnStart.dispose();
         this.btnStart = null;
         this.selectGlow = null;
         this.btnSkip.dispose();
         this.btnSkip = null;
         this.btnSkipVideo.dispose();
         this.btnSkipVideo = null;
         this.waitingMC = null;
         this.waitingTF = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this._introData = null;
         if(this._logger)
         {
            this._logger.stopPageLog();
            this._logger.dispose();
            this._logger = null;
         }
         this._scheduler.cancelTask(this.onSelectGlowAppearStart);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function setData(param1:BCIntroVideoVO) : void
      {
         this._introData = param1;
         invalidate(INTRO_INFO_CHANGED);
      }
      
      public function as_loaded() : void
      {
         this._loaded = true;
         if(this._introData.videoPlayerVisible)
         {
            if(this._videoCompleted)
            {
               this.onVideoCompleteOrSkip();
            }
            else
            {
               this.prepareSkip();
            }
         }
         else
         {
            this.loadingProgress.gotoAndStop(this.loadingProgress.totalFrames);
            this.applyCompleteData();
         }
      }
      
      public function as_pausePlayback() : void
      {
         this.videoPlayer.pausePlayback();
      }
      
      public function as_resumePlayback() : void
      {
         this.videoPlayer.resumePlayback();
      }
      
      public function as_showIntroPage(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Tween = null;
         this.introPage.visible = param1;
         if(param1)
         {
            this.selectGlow.alpha = 0;
            _loc3_ = new Tween(TWEEN_DURATION,this.selectGlow,{"alpha":1},{
               "delay":TWEEN_DELAY,
               "ease":Strong.easeIn
            });
            this._scheduler.scheduleTask(this.onSelectGlowAppearStart,TWEEN_DELAY);
            this._tweens.push(_loc3_);
            this.introPage.animate(param2);
         }
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * FULL_PROGRESS;
         if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
         {
            this.loadingProgress.gotoAndStop(_loc2_ + 1);
         }
      }
      
      protected function disposePlayer() : void
      {
         if(this.videoPlayer)
         {
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
            this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
            this.videoPlayer.dispose();
            this.videoPlayer = null;
         }
      }
      
      protected function tweenFadeOut() : void
      {
         var _loc1_:Tween = new Tween(OVERLAY_TWEEN_DURATION,this.blackOverlay,{"alpha":0},{
            "ease":Strong.easeIn,
            "onComplete":this.onFadeOutTweenComplete
         });
         this._tweens.push(_loc1_);
      }
      
      protected function continueToBattle() : void
      {
         App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         goToBattleS();
      }
      
      private function prepareSkip() : void
      {
         this.waitingMC.visible = false;
         this.waitingTF.visible = false;
         this._skipPrepared = true;
         App.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
      }
      
      private function showSkip() : void
      {
         App.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this.btnSkipVideo.visible = true;
         FocusManager.setFocus(this.btnSkipVideo);
         this._skipShown = true;
      }
      
      private function onVideoCompleteOrSkip() : void
      {
         this.waitingMC.visible = false;
         this.waitingTF.visible = false;
         this.btnSkipVideo.visible = false;
         this._skipPrepared = false;
         App.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         videoFinishedS();
         this.applyCompleteData();
      }
      
      private function applyCompleteData() : void
      {
         if(this._introData)
         {
            this.selectGlow.visible = this.btnSelect.visible = !this._introData.autoStart;
            this.btnSkip.visible = this._introData.allowSkipButton;
            if(this.btnSkip.visible)
            {
               this.btnSelect.visible = false;
               this.btnStart.visible = true;
            }
            if(this.btnSelect.visible)
            {
               FocusManager.setFocus(this.btnSelect);
            }
            else if(this.btnStart.visible)
            {
               FocusManager.setFocus(this.btnStart);
            }
            this.btnSelect.addEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
            this.btnStart.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
            this.btnSkip.addEventListener(ButtonEvent.CLICK,this.onSkipButtonClickHandler);
            this.closeBtn.visible = this._introData.isReferralEnabled && this._introData.isBootcampCloseEnabled;
            this.introPage.referralDescription = this._introData.referralDescription;
            if(this.closeBtn.visible)
            {
               this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onSkipButtonClickHandler);
            }
            this.introPage.setReferralVisibility(this._introData.isReferralEnabled);
            this.introPage.setData(this._introData);
            if(this._introData.autoStart)
            {
               this.continueToBattle();
            }
         }
      }
      
      private function onSkip() : void
      {
         this.btnSkipVideo.visible = false;
         this.completeVideo();
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
            _loc5_.isAdaptable = this.eventModeEnabled;
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
         var _loc5_:Number = NaN;
         var _loc1_:int = App.appWidth;
         var _loc2_:int = App.appHeight;
         if(this.videoPlayer != null)
         {
            if(_loc1_ / _loc2_ > this._playerOriginalWidth / this._playerOriginalHeight)
            {
               _loc5_ = _loc1_ / this._playerOriginalWidth;
               this.videoPlayer.scaleX = this._playerOriginalScaleX * _loc5_;
               this.videoPlayer.scaleY = this._playerOriginalScaleY * _loc5_;
            }
            else
            {
               _loc5_ = _loc2_ / this._playerOriginalHeight;
               this.videoPlayer.scaleX = this._playerOriginalScaleX * _loc5_;
               this.videoPlayer.scaleY = this._playerOriginalScaleY * _loc5_;
            }
            this.videoPlayer.x = _loc1_ - this.videoPlayer.width >> 1;
            this.videoPlayer.y = _loc2_ - this.videoPlayer.height >> 1;
         }
         var _loc3_:Boolean = _loc2_ < StageSizeBoundaries.HEIGHT_900;
         if(this._introData && this._introData.allowSkipButton)
         {
            this.btnSkip.y = _loc2_ + BTN_SKIP_OFFSET_Y;
            this.btnSkip.x = (_loc1_ - this.btnStart.width - this.btnSkip.width - BUTTON_SPACING >> 1) + BTN_SKIP_OFFSET_X;
            this.btnStart.x = this.btnSkip.x + this.btnSkip.width + BUTTON_SPACING;
            this.btnStart.y = _loc2_ + BTN_START_OFFSET_Y;
            this.selectGlow.x = this.btnStart.x - GLOW_START_X_OFFSET;
            this.selectGlow.y = this.btnStart.y - GLOW_START_Y_OFFSET;
         }
         else
         {
            this.btnSelect.x = _loc1_ - this.btnSelect.width >> 1;
            this.btnSelect.y = _loc2_ + BTN_SELECT_OFFSET_Y;
            this.selectGlow.x = this.btnSelect.x - GLOW_SELECT_X_OFFSET;
            this.selectGlow.y = this.btnSelect.y - GLOW_SELECT_Y_OFFSET;
         }
         this.btnSkipVideo.x = _loc1_ - this.btnSkipVideo.width >> 1;
         this.btnSkipVideo.y = _loc2_ + BTN_SKIP_OFFSET_Y;
         var _loc4_:Boolean = _loc1_ >= SMALL_SCREEN_WIDTH && _loc2_ >= SMALL_SCREEN_HEIGHT;
         if(this._introData && this._introData.showTutorialPages)
         {
            if(this._useBigPictures != _loc4_ || !this._inited)
            {
               this._useBigPictures = _loc4_;
               this.createImagesList();
               this.updateBackgroundRenderer();
            }
            this.backgroundContainer.x = -((!!this._useBigPictures ? BACK_WIDTH_BIG : BACK_WIDTH_SMALL) - _loc1_ >> 1);
            this.backgroundContainer.y = -((!!this._useBigPictures ? BACK_HEIGHT_BIG : BACK_HEIGHT_SMALL) - _loc2_ >> 1);
            this.updateTutorialPageLayout();
         }
         else
         {
            this.introPage.setSize(_loc1_,_loc2_,_loc3_);
            if(!this._introData.allowSkipButton)
            {
               this.btnSelect.y = this.introPage.y + this.introPage.getBottomY() + (!!_loc3_ ? SELECT_SMALL_OFFSET : SELECT_OFFSET);
               this.selectGlow.y = this.btnSelect.y - GLOW_SELECT_Y_OFFSET;
            }
         }
         this.backgroundVignette.width = _loc1_;
         this.backgroundVignette.height = _loc2_;
         this.backgroundVignette.x = 0;
         this.backgroundVignette.y = 0;
         this.blackOverlay.width = _loc1_;
         this.blackOverlay.height = _loc2_;
         this.btnLeft.x = BTN_PADDING;
         this.btnRight.x = App.appWidth - BTN_PADDING;
         this.btnLeft.y = this.btnRight.y = (App.appHeight >> 1) - (this.btnLeft.height >> 1);
         this.stepperBar.x = _loc1_ - this.stepperBar.width >> 1;
         this.closeBtn.validateNow();
         this.closeBtn.x = _loc1_ - this.closeBtn.width - CLOSE_BTN_PADDING_RIGHT;
         this.loadingProgress.x = _loc1_ >> 1;
         this.loadingProgress.y = _loc2_ + this.customLoadingProgressBottom;
         this.loadingProgress.setWidth(_loc1_);
         if(this.waitingMC.visible)
         {
            this.waitingMC.x = _loc1_ + WAIT_MC_X;
            this.waitingMC.y = _loc2_ + WAIT_MC_Y;
            this.waitingTF.x = _loc1_ - this.waitingTF.width + WAIT_TF_X + WAIT_MC_X;
            this.waitingTF.y = _loc2_ + WAIT_TF_Y;
         }
      }
      
      private function updateTutorialPageLayout() : void
      {
         this._tutorialPageList[this._picIndex].updateTextPosition(App.appWidth,!!this._useBigPictures ? int(BACK_HEIGHT_BIG) : int(BACK_HEIGHT_SMALL),-this.backgroundContainer.x,-this.backgroundContainer.y,this.customTextPaddingLeft,this.customTextPaddingBottom);
      }
      
      private function updateBackgroundRenderer() : void
      {
         if(this._logger)
         {
            this._logger.startPageLog(this._picIndex);
         }
         if(this.backgroundContainer.numChildren > 0)
         {
            this.backgroundContainer.removeChildAt(0);
         }
         this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
         this.updateTutorialPageLayout();
         this.stepperBar.selectItem(this._picIndex);
      }
      
      private function hideVideoPlayer() : void
      {
         if(this.videoPlayer)
         {
            this.videoPlayer.visible = false;
            this.blackOverlay.alpha = 0;
         }
      }
      
      private function tweenFadeIn() : void
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
         var _loc1_:Tween = new Tween(OVERLAY_TWEEN_DURATION,this.blackOverlay,{"alpha":0},{"ease":Strong.easeOut});
         this._tweens.push(_loc1_);
      }
      
      private function onSelectGlowAppearStart() : void
      {
         onHighlightShowS();
      }
      
      private function onFadeOutTweenComplete() : void
      {
         this.tweenFadeIn();
      }
      
      private function completeVideo() : void
      {
         if(this.videoPlayer.source == this._introData.source)
         {
            this._videoCompleted = true;
            if(!StringUtils.isNotEmpty(this._introData.backgroundVideo))
            {
               this.hideVideoPlayer();
            }
            if(this._loaded)
            {
               this.onVideoCompleteOrSkip();
            }
         }
         this.handleBackgroundVideo();
      }
      
      private function handleBackgroundVideo() : void
      {
         if(StringUtils.isNotEmpty(this._introData.backgroundVideo))
         {
            if(this.videoPlayer.source != this._introData.backgroundVideo)
            {
               setChildIndex(this.videoPlayer,getChildIndex(this.selectGlow));
               this.videoPlayer.visible = true;
               this.videoPlayer.source = this._introData.backgroundVideo;
               this.videoPlayer.isLoop = true;
            }
         }
      }
      
      protected function set imageGoRight(param1:Boolean) : void
      {
         this._imageGoRight = param1;
      }
      
      protected function get introData() : BCIntroVideoVO
      {
         return this._introData;
      }
      
      private function changePage() : void
      {
         if(this._skipPrepared && !this._skipShown)
         {
            this.showSkip();
         }
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
               if(this._logger)
               {
                  this._logger.stopPageLog();
               }
               this.tweenFadeOut();
            }
         }
      }
      
      protected function onStageClickHandler(param1:MouseEvent) : void
      {
         if(!this._introData || param1 is MouseEventEx && MouseEventEx(param1).buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         this.changePage();
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
               this.changePage();
            }
         }
      }
      
      private function onKeyDownHandler(param1:Event) : void
      {
         this.showSkip();
      }
      
      private function onSelectButtonClickHandler(param1:ButtonEvent) : void
      {
         this.btnSelect.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.continueToBattle();
      }
      
      private function onStartButtonClickHandler(param1:ButtonEvent) : void
      {
         this.btnStart.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.continueToBattle();
      }
      
      private function onSkipButtonClickHandler(param1:ButtonEvent) : void
      {
         this.btnSkip.removeEventListener(ButtonEvent.CLICK,this.onSkipButtonClickHandler);
         skipBootcampS();
      }
      
      private function onSkipVideoButtonClickHandler(param1:ButtonEvent) : void
      {
         this.onSkip();
      }
      
      private function onVideoPlayerPlaybackStoppedHandler(param1:VideoPlayerEvent) : void
      {
         this.completeVideo();
      }
      
      private function onVideoPlayerStatusChangedHandler(param1:VideoPlayerStatusEvent) : void
      {
         if(this.videoPlayer.status == PlayerStatus.PLAYING)
         {
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
            videoStartedS();
            this.videoPlayer.seek(0);
         }
      }
      
      private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
      {
         handleErrorS(param1.errorCode);
         this.hideVideoPlayer();
      }
   }
}
