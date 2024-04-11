package net.wg.gui.battle.historicalBattles
{
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import net.wg.gui.battle.historicalBattles.components.LoadingProgress;
   import net.wg.gui.battle.historicalBattles.data.BattleLoadingHintVO;
   import net.wg.gui.components.containers.SoundButtonContainer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.paginator.PaginationStepper;
   import net.wg.gui.events.ListEventEx;
   import net.wg.infrastructure.base.meta.IHBLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.HBLoadingMeta;
   import net.wg.utils.IScheduler;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class HBLoading extends HBLoadingMeta implements IHBLoadingMeta
   {
      
      private static const INVALIDATE_HINT:String = "invalidateHint";
      
      private static const HINT_DURATION:int = 5000;
      
      private static const STEP_FORWARD:int = 1;
      
      private static const STEP_BACK:int = -1;
      
      private static const LABEL_SMALL:String = "small";
      
      private static const LABEL_BIG:String = "big";
      
      private static const TITLE_SIZE_SMALL:int = 28;
      
      private static const TITLE_SIZE:int = 36;
      
      private static const DESCRIPTION_SIZE_SMALL:int = 16;
      
      private static const DESCRIPTION_SIZE:int = 20;
      
      private static const TEXT_WIDTH_SMALL:int = 634;
      
      private static const TEXT_WIDTH:int = 1176;
      
      private static const LOADING_WIDTH_SMALL:int = 391;
      
      private static const LOADING_WIDTH:int = 728;
      
      private static const PAGINATOR_Y_SMALL:int = 45;
      
      private static const PAGINATOR_Y:int = 85;
      
      private static const BUTTON_MARGIN_X_SMALL:int = 42;
      
      private static const BUTTON_MARGIN_X:int = 50;
      
      private static const TITLE_MARGIN_Y_SMALL:int = 17;
      
      private static const TITLE_MARGIN_Y:int = 11;
      
      private static const DESCRIPTION_MARGIN_Y_SMALL:int = 33;
      
      private static const DESCRIPTION_MARGIN_Y:int = 62;
      
      private static const LOADING_MARGIN_Y_SMALL:int = 47;
      
      private static const LOADING_MARGIN_Y:int = 59;
       
      
      public var paginator:PaginationStepper = null;
      
      public var btnLeft:SoundButtonContainer = null;
      
      public var btnRight:SoundButtonContainer = null;
      
      public var loadingProgress:LoadingProgress = null;
      
      public var title:TextField = null;
      
      public var description:TextField = null;
      
      public var backgroundVignette:MovieClip = null;
      
      public var bottomGradient:MovieClip = null;
      
      public var hintBgLoader:UILoaderAlt = null;
      
      public var blackBG:MovieClip = null;
      
      private var _hintIndex:int = 0;
      
      private var _hintsData:Vector.<BattleLoadingHintVO> = null;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _scheduler:IScheduler;
      
      public function HBLoading()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.paginator.addEventListener(ListEventEx.INDEX_CHANGE,this.onPaginatorIndexChangeHandler);
         this.paginator.addEventListener(ListEventEx.LAYOUT_CHANGE,this.onPaginatorLayoutChangeHandler);
         App.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this.btnLeft.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         this.title.autoSize = this.description.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._hintsData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.validateData();
            }
            if(isInvalid(INVALIDATE_HINT))
            {
               this.validateHint();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.validateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this.hintBgLoader.dispose();
         this.hintBgLoader = null;
         this._scheduler.cancelTask(this.showNext);
         this._scheduler = null;
         this.paginator.removeEventListener(ListEventEx.INDEX_CHANGE,this.onPaginatorIndexChangeHandler);
         this.paginator.removeEventListener(ListEventEx.LAYOUT_CHANGE,this.onPaginatorLayoutChangeHandler);
         this.paginator.dispose();
         this.paginator = null;
         this.btnLeft.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         this.btnLeft.dispose();
         this.btnLeft = null;
         this.btnRight.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.dispose();
         this.btnRight = null;
         this.loadingProgress.dispose();
         this.loadingProgress = null;
         this.title = null;
         this.description = null;
         this.backgroundVignette = null;
         this.bottomGradient = null;
         this.blackBG = null;
         this._hintsData = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Vector.<BattleLoadingHintVO>) : void
      {
         this._hintsData = param1;
         invalidateSize();
         invalidateData();
         invalidate(INVALIDATE_HINT);
      }
      
      public function as_loaded() : void
      {
         this.loadingProgress.gotoAndStop(this.loadingProgress.totalFrames);
      }
      
      public function as_updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * 100;
         if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
         {
            this.loadingProgress.gotoAndStop(_loc2_ + 1);
         }
      }
      
      protected function moveHintIndex(param1:int) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = this._hintIndex + param1;
         if(_loc2_ < 0 || _loc2_ >= this._hintsData.length)
         {
            _loc3_ = _loc2_ % this._hintsData.length;
            _loc2_ = _loc3_ < 0 ? int(this._hintsData.length - _loc3_) : int(_loc3_);
         }
         this.hintIndex = _loc2_;
      }
      
      private function validateHint() : void
      {
         var _loc1_:BattleLoadingHintVO = this._hintsData[this._hintIndex];
         this.title.text = _loc1_.title;
         this.description.text = _loc1_.description;
         this.hintBgLoader.source = _loc1_.background;
         this.paginator.selectedIndex = this._hintIndex;
         this.updateTextLayout();
         this.startHintDelay();
      }
      
      private function validateData() : void
      {
         this.paginator.renderersCount = this._hintsData.length;
      }
      
      private function validateSize() : void
      {
         this.hintBgLoader.setOriginalWidth(this._stageWidth);
         this.hintBgLoader.setOriginalHeight(this._stageHeight);
         this.hintBgLoader.updateLoaderSize();
         this.bottomGradient.width = this.backgroundVignette.width = this.blackBG.width = this._stageWidth;
         this.backgroundVignette.height = this.blackBG.height = this._stageHeight;
         this.updatePaginatorPosition();
         if(this._stageWidth <= StageSizeBoundaries.WIDTH_1600)
         {
            this.btnLeft.gotoAndStop(LABEL_SMALL);
            this.btnRight.gotoAndStop(LABEL_SMALL);
            this.btnLeft.x = BUTTON_MARGIN_X_SMALL;
            this.btnRight.x = this._stageWidth - BUTTON_MARGIN_X_SMALL;
            this.loadingProgress.setActualSize(LOADING_WIDTH_SMALL,this.loadingProgress.height);
            this.loadingProgress.y = this._stageHeight - LOADING_MARGIN_Y_SMALL;
         }
         else
         {
            this.btnLeft.gotoAndStop(LABEL_BIG);
            this.btnRight.gotoAndStop(LABEL_BIG);
            this.btnLeft.x = BUTTON_MARGIN_X;
            this.btnRight.x = this._stageWidth - BUTTON_MARGIN_X;
            this.loadingProgress.setActualSize(LOADING_WIDTH,this.loadingProgress.height);
            this.loadingProgress.y = this._stageHeight - LOADING_MARGIN_Y;
         }
         this.loadingProgress.x = this._stageWidth - this.loadingProgress.width >> 1;
         this.btnLeft.y = this.btnRight.y = this._stageHeight - this.btnLeft.height >> 1;
         this.bottomGradient.y = this._stageHeight - this.bottomGradient.height >> 0;
         this.updateTextLayout();
      }
      
      private function updatePaginatorPosition() : void
      {
         this.paginator.x = this._stageWidth - this.paginator.actualWidth >> 1;
         if(this._stageWidth <= StageSizeBoundaries.WIDTH_1600)
         {
            this.paginator.y = PAGINATOR_Y_SMALL;
         }
         else
         {
            this.paginator.y = PAGINATOR_Y;
         }
      }
      
      private function updateTextLayout() : void
      {
         this.updateTextFormat();
         if(this._stageWidth <= StageSizeBoundaries.WIDTH_1600)
         {
            this.description.y = this.loadingProgress.y - this.description.textHeight - DESCRIPTION_MARGIN_Y_SMALL >> 0;
            this.title.y = this.description.y - this.title.textHeight - TITLE_MARGIN_Y_SMALL >> 0;
         }
         else
         {
            this.description.y = this.loadingProgress.y - this.description.textHeight - DESCRIPTION_MARGIN_Y >> 0;
            this.title.y = this.description.y - this.title.textHeight - TITLE_MARGIN_Y >> 0;
         }
         this.description.x = this._stageWidth - this.description.width >> 1;
         this.title.x = this._stageWidth - this.title.width >> 1;
      }
      
      private function updateTextFormat() : void
      {
         var _loc1_:TextFormat = this.title.getTextFormat();
         var _loc2_:TextFormat = this.description.getTextFormat();
         if(this._stageWidth <= StageSizeBoundaries.WIDTH_1600)
         {
            _loc1_.size = TITLE_SIZE_SMALL;
            _loc2_.size = DESCRIPTION_SIZE_SMALL;
            this.title.width = this.description.width = TEXT_WIDTH_SMALL;
         }
         else
         {
            _loc1_.size = TITLE_SIZE;
            _loc2_.size = DESCRIPTION_SIZE;
            this.title.width = this.description.width = TEXT_WIDTH;
         }
         this.title.setTextFormat(_loc1_);
         this.description.setTextFormat(_loc2_);
      }
      
      private function showNext() : void
      {
         this.moveHintIndex(STEP_FORWARD);
      }
      
      private function showPrev() : void
      {
         this.moveHintIndex(STEP_BACK);
      }
      
      private function startHintDelay() : void
      {
         this._scheduler.cancelTask(this.showNext);
         this._scheduler.scheduleTask(this.showNext,HINT_DURATION);
      }
      
      public function set hintIndex(param1:int) : void
      {
         if(this._hintIndex == param1)
         {
            return;
         }
         this._hintIndex = Math.max(Math.min(param1,this._hintsData.length - 1),0);
         invalidate(INVALIDATE_HINT);
      }
      
      private function onPaginatorLayoutChangeHandler(param1:ListEventEx) : void
      {
         this.updatePaginatorPosition();
      }
      
      private function onPaginatorIndexChangeHandler(param1:ListEvent) : void
      {
         this.hintIndex = param1.index;
      }
      
      private function onKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = param1.keyCode;
         if(_loc2_ == Keyboard.RIGHT || _loc2_ == Keyboard.TAB)
         {
            this.showNext();
         }
         else if(_loc2_ == Keyboard.LEFT)
         {
            this.showPrev();
         }
      }
      
      private function onButtonsClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            if(param1.currentTarget == this.btnRight)
            {
               this.showNext();
            }
            else if(param1.currentTarget == this.btnLeft)
            {
               this.showPrev();
            }
         }
      }
   }
}
