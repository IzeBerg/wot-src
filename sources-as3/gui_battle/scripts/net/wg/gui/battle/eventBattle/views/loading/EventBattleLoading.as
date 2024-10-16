package net.wg.gui.battle.eventBattle.views.loading
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.loading.containers.EventLogoContainer;
   import net.wg.gui.battle.eventBattle.views.loading.containers.LoadingContainer;
   import net.wg.gui.battle.eventBattle.views.loading.containers.LoadingPageContainer;
   import net.wg.gui.battle.eventBattle.views.loading.containers.StepperContainer;
   import net.wg.gui.battle.eventBattle.views.loading.data.EventLoadingPageVO;
   import net.wg.gui.battle.eventBattle.views.loading.data.EventLoadingVO;
   import net.wg.infrastructure.base.meta.IEventLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.EventLoadingMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class EventBattleLoading extends EventLoadingMeta implements IEventLoadingMeta
   {
      
      private static const INTRO_INFO_CHANGED:String = "infoChanged";
      
      private static const STAGE_RESIZED:String = "stageResized";
      
      private static const BTN_PADDING:Number = 50;
      
      private static const OVERLAY_TWEEN_DURATION:int = 300;
      
      private static const SMALL_SCREEN_WIDTH:int = StageSizeBoundaries.WIDTH_1920;
      
      private static const SMALL_SCREEN_HEIGHT:int = StageSizeBoundaries.HEIGHT_1080;
      
      private static const FULL_PROGRESS:int = 100;
      
      private static const BACK_WIDTH_BIG:int = 3440;
      
      private static const BACK_WIDTH_SMALL:int = 2365;
      
      private static const BACK_HEIGHT_SMALL:int = 1930;
      
      private static const BACK_HEIGHT_BIG:int = 1380;
       
      
      public var btnLeft:MovieClip = null;
      
      public var btnRight:MovieClip = null;
      
      public var backgroundContainer:MovieClip = null;
      
      public var backgroundVignette:MovieClip = null;
      
      public var blackBG:MovieClip = null;
      
      public var loadingProgress:LoadingContainer = null;
      
      public var blackOverlay:MovieClip = null;
      
      public var stepperBar:StepperContainer = null;
      
      public var logoContainer:EventLogoContainer;
      
      private var _inited:Boolean = false;
      
      private var _imageGoRight:Boolean = false;
      
      private var _tutorialPageList:Vector.<LoadingPageContainer>;
      
      private var _picIndex:int = 0;
      
      private var _introData:EventLoadingVO = null;
      
      private var _useBigPictures:Boolean = false;
      
      private var _tweens:Vector.<Tween>;
      
      public function EventBattleLoading()
      {
         this._tutorialPageList = new Vector.<LoadingPageContainer>();
         this._tweens = new Vector.<Tween>();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.blackOverlay.alpha = 0;
         this.backgroundVignette.mouseChildren = this.backgroundVignette.mouseEnabled = false;
         this.blackOverlay.mouseChildren = this.blackOverlay.mouseEnabled = false;
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
               invalidate(STAGE_RESIZED);
            }
            if(isInvalid(STAGE_RESIZED))
            {
               this.updateUIPosition();
            }
         }
      }
      
      override protected function setData(param1:EventLoadingVO) : void
      {
         this._introData = param1;
         invalidate(INTRO_INFO_CHANGED);
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * FULL_PROGRESS;
         if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
         {
            this.loadingProgress.gotoAndStop(_loc2_ + 1);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         this.btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.disposeBackgroundRenderers();
         this.stepperBar.dispose();
         this.stepperBar = null;
         this._tutorialPageList = null;
         this.backgroundContainer = null;
         this.backgroundVignette = null;
         this.blackBG = null;
         this.blackOverlay = null;
         this.btnLeft = null;
         this.btnRight = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this.logoContainer.dispose();
         this.logoContainer = null;
         super.onDispose();
      }
      
      private function updateUIPosition() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = App.appWidth;
         _loc2_ = App.appHeight;
         var _loc3_:Boolean = _loc1_ >= SMALL_SCREEN_WIDTH && _loc2_ >= SMALL_SCREEN_HEIGHT;
         if(this._introData)
         {
            if(this._useBigPictures != _loc3_ || !this._inited)
            {
               this._useBigPictures = _loc3_;
               this.createImagesList();
               this.updateBackgroundRenderer();
            }
            this.backgroundContainer.x = -((!!this._useBigPictures ? BACK_WIDTH_BIG : BACK_WIDTH_SMALL) - _loc1_ >> 1);
            this.backgroundContainer.y = -((!!this._useBigPictures ? BACK_HEIGHT_SMALL : BACK_HEIGHT_BIG) - _loc2_ >> 1);
         }
         this.logoContainer.setSize(_loc1_,_loc2_);
         this.backgroundVignette.width = _loc1_;
         this.backgroundVignette.height = _loc2_;
         this.backgroundVignette.x = 0;
         this.backgroundVignette.y = 0;
         this.blackOverlay.width = _loc1_;
         this.blackOverlay.height = _loc2_;
         this.btnLeft.x = BTN_PADDING;
         this.btnRight.x = _loc1_ - BTN_PADDING;
         this.btnLeft.y = this.btnRight.y = (_loc2_ >> 1) - (this.btnLeft.height >> 1);
         this.stepperBar.x = _loc1_ - this.stepperBar.width >> 1;
         this.loadingProgress.x = _loc1_ >> 1;
         this.loadingProgress.y = _loc2_;
         this.loadingProgress.setWidth(_loc1_);
      }
      
      private function createImagesList() : void
      {
         var _loc4_:EventLoadingPageVO = null;
         var _loc5_:LoadingPageContainer = null;
         this._inited = true;
         if(this._tutorialPageList.length)
         {
            this.disposeBackgroundRenderers();
         }
         var _loc1_:Vector.<EventLoadingPageVO> = !!this._useBigPictures ? this._introData.lessonPagesBigData : this._introData.lessonPagesSmallData;
         var _loc2_:int = _loc1_.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = App.utils.classFactory.getComponent(_loc4_.rendererLinkage,LoadingPageContainer);
            _loc5_.setData(_loc4_);
            this._tutorialPageList.push(_loc5_);
            _loc3_++;
         }
         if(_loc2_ > 1)
         {
            this.stepperBar.setCount(_loc2_);
         }
      }
      
      private function disposeBackgroundRenderers() : void
      {
         var _loc3_:LoadingPageContainer = null;
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
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         this._imageGoRight = param1.currentTarget == this.btnRight;
         this.tweenFadeOut();
      }
      
      private function tweenFadeOut() : void
      {
         var _loc1_:Tween = new Tween(OVERLAY_TWEEN_DURATION,this.blackOverlay,{"alpha":0},{
            "ease":Strong.easeIn,
            "onComplete":this.onFadeOutTweenComplete
         });
         this._tweens.push(_loc1_);
      }
      
      private function onFadeOutTweenComplete() : void
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
      
      private function updateBackgroundRenderer() : void
      {
         if(this.backgroundContainer.numChildren > 0)
         {
            this.backgroundContainer.removeChildAt(0);
         }
         this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
         this.stepperBar.selectItem(this._picIndex);
      }
   }
}
