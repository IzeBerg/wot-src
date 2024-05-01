package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattleResultsVO;
   import net.wg.gui.lobby.rankedBattles19.events.RankWidgetEvent;
   import net.wg.infrastructure.base.meta.IRankedBattlesBattleResultsMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesBattleResultsMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class RankedBattlesBattleResults extends RankedBattlesBattleResultsMeta implements IRankedBattlesBattleResultsMeta
   {
      
      private static const CLOSE_BTN_TOP_OFFSET:int = 30;
      
      private static const CLOSE_BTN_RIGHT_OFFSET:int = 19;
      
      private static const RESULTS_CONTAINER_OFFSET:int = 214;
      
      private static const RESULT_CONTAINER_WIDTH:int = 741;
      
      private static const TITLE_TF_OFFSET:int = 273;
      
      private static const STATUS_ANIM_OFFSET:int = 306;
      
      private static const WIDGET_ANIMATION_OFFSET:int = 128;
      
      private static const BIG_SIZE_APP_HEIGHT:int = 900;
      
      private static const WIDGET_ANIM_PRE_END_LABEL:String = "beforeEnd";
      
      private static const ANIMATION_CHECK_BOX_X:int = 40;
      
      private static const ANIMATION_CHECK_BOX_Y:int = 60;
      
      private static const STATUS_ANIM_SHOW_LABEL:String = "show";
      
      private static const STATUS_ANIM_POSITIVE_SHOW_LABEL:String = "positive_show";
      
      private static const STATUS_ANIM_NORMAL_SHOW_LABEL:String = "normal_show";
      
      private static const STATUS_ANIM_NEGATIVE_SHOW_LABEL:String = "negative_show";
       
      
      public var titleTF:TextField = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public var animationCheckBox:CompactCheckBox = null;
      
      public var resultsContainer:ResultsContainer = null;
      
      public var widgetAnimation:MovieClip = null;
      
      public var statusAnim:MovieClip = null;
      
      private var _readyBtn:UniversalBtn = null;
      
      private var _widget:RankedBattlesHangarWidget = null;
      
      private var _isWidgetShown:Boolean = false;
      
      private var _isAnimationsComplete:Boolean = false;
      
      private var _isCompactSize:Boolean = false;
      
      private var _animationEnabled:Boolean = true;
      
      private var _widjetAnimTotalFrames:int = -1;
      
      private var _showWidgetAnimation:Boolean = true;
      
      private var _statusTF:TextField = null;
      
      private var _data:RankedBattleResultsVO = null;
      
      public function RankedBattlesBattleResults()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         invalidateSize();
         super.updateStage(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._widget = this.widgetAnimation.widgetContainer.battleResWidget;
         this._widget.bg.visible = false;
         this._widjetAnimTotalFrames = this.widgetAnimation.totalFrames - 1;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this._widget,RANKEDBATTLES_ALIASES.RANKED_BATTLE_RESULTS_WIDGET);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._readyBtn = this.resultsContainer.readyBtn;
         this.titleTF.autoSize = TextFieldAutoSize.CENTER;
         this.closeBtn.x = width - this.closeBtn.width - CLOSE_BTN_RIGHT_OFFSET;
         this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this._readyBtn.addEventListener(ButtonEvent.CLICK,this.onReadyBtnClickHandler);
         this.animationCheckBox.addEventListener(Event.SELECT,this.onAnimationCheckBoxSelectHandler);
         this.animationCheckBox.visible = false;
         this.resultsContainer.init();
         this.widgetAnimation.gotoAndStop(1);
         this._widget.visible = false;
         this._statusTF = this.statusAnim.statusMc.statusTF;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            width = bgActualWidth;
            height = bgActualHeight;
            this.closeBtn.x = width - this.closeBtn.actualWidth - CLOSE_BTN_RIGHT_OFFSET;
            this.closeBtn.y = CLOSE_BTN_TOP_OFFSET;
            this.animationCheckBox.x = ANIMATION_CHECK_BOX_X;
            this.animationCheckBox.y = height - ANIMATION_CHECK_BOX_Y;
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.statusAnim.x = width - this.statusAnim.width >> 1;
            this.resultsContainer.x = width - RESULT_CONTAINER_WIDTH >> 1;
            this.widgetAnimation.x = width >> 1;
            _loc1_ = bgActualHeight >> 1;
            _loc2_ = viewRestrictions.topOffset;
            this.titleTF.y = _loc1_ - TITLE_TF_OFFSET + _loc2_;
            this.statusAnim.y = _loc1_ - STATUS_ANIM_OFFSET + _loc2_;
            this.resultsContainer.y = _loc1_ - RESULTS_CONTAINER_OFFSET + _loc2_;
            this.widgetAnimation.y = _loc1_ - WIDGET_ANIMATION_OFFSET + _loc2_;
            _loc3_ = App.appHeight < BIG_SIZE_APP_HEIGHT;
            if(_loc3_ != this._isCompactSize)
            {
               this._isCompactSize = _loc3_;
               this.resultsContainer.setCompact(_loc3_);
            }
         }
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.resultsContainer.setData(this._data);
            this._animationEnabled = this._data.animationEnabled;
            this._showWidgetAnimation = this._data.showWidgetAnimation;
            this.animationCheckBox.label = this._data.animationEnabledLabel;
            this.animationCheckBox.selected = this._animationEnabled;
            setBackground(this._data.mainBackground);
            this._statusTF.htmlText = this._data.statusText;
            this.startResultsAnimation();
         }
      }
      
      override protected function setData(param1:RankedBattleResultsVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this._readyBtn.removeEventListener(ButtonEvent.CLICK,this.onReadyBtnClickHandler);
         this.animationCheckBox.removeEventListener(Event.SELECT,this.onAnimationCheckBoxSelectHandler);
         this.resetAnimation();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.animationCheckBox.dispose();
         this.animationCheckBox = null;
         this.closeBtn.dispose();
         this.resultsContainer.dispose();
         this.resultsContainer = null;
         this._readyBtn = null;
         this.closeBtn = null;
         this.titleTF = null;
         this._widget = null;
         this.widgetAnimation = null;
         this.statusAnim = null;
         this._statusTF = null;
         this._data = null;
         super.onDispose();
      }
      
      private function startResultsAnimation() : void
      {
         this.resultsContainer.show();
         this.resultsContainer.leftBlock.blink();
         this.resultsContainer.rightBlock.blink();
      }
      
      private function startRankChainAnimation() : void
      {
         this._widget.visible = true;
         this.widgetAnimation.addFrameScript(WIDGET_ANIM_PRE_END_LABEL,this.endOfWidgetAnimation);
         this.widgetAnimation.gotoAndPlay(1);
      }
      
      private function endOfWidgetAnimation() : void
      {
         this._widget.addEventListener(RankWidgetEvent.READY,this.onWidgetReadyHandler);
         this._widget.enableRanksReflections(false);
         onWidgetUpdateS();
         this.titleTF.visible = false;
         switch(this._data.state)
         {
            case RANKEDBATTLES_ALIASES.BATTLE_RESULTS_POSITIVE_STATE:
               this.statusAnim.gotoAndPlay(STATUS_ANIM_POSITIVE_SHOW_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.BATTLE_RESULTS_NEGATIVE_STATE:
               this.statusAnim.gotoAndPlay(STATUS_ANIM_NEGATIVE_SHOW_LABEL);
               break;
            default:
               this.statusAnim.gotoAndPlay(STATUS_ANIM_NORMAL_SHOW_LABEL);
         }
      }
      
      private function onWidgetAnimComplete() : void
      {
         this._isAnimationsComplete = true;
      }
      
      private function tryToCloseView(param1:Boolean = false) : void
      {
         if(!this._isAnimationsComplete && this._showWidgetAnimation)
         {
            this.resultsContainer.switchLists(false);
            this.widgetAnimation.y = (bgActualHeight >> 1) - WIDGET_ANIMATION_OFFSET + viewRestrictions.topOffset;
            if(!this._isWidgetShown)
            {
               this._isWidgetShown = true;
               this.animationCheckBox.visible = true;
               if(!this._animationEnabled)
               {
                  this._isAnimationsComplete = true;
                  this.widgetAnimation.gotoAndStop(this._widjetAnimTotalFrames);
                  this.showWidgetFinalState();
               }
               else
               {
                  this.startRankChainAnimation();
               }
            }
            else
            {
               this._isAnimationsComplete = true;
               this.widgetAnimation.gotoAndStop(this._widjetAnimTotalFrames);
               if(param1 || this._animationEnabled)
               {
                  this.cleanAndClose();
               }
               else
               {
                  this.showWidgetFinalState();
               }
            }
         }
         else
         {
            this.cleanAndClose();
         }
      }
      
      private function showWidgetFinalState() : void
      {
         onWidgetUpdateS();
         this._widget.enableRanksReflections(false);
         this._widget.showFinalState();
         this._widget.visible = true;
         this.titleTF.visible = false;
         this.statusAnim.gotoAndStop(STATUS_ANIM_SHOW_LABEL);
      }
      
      private function resetAnimation() : void
      {
         this._widget.removeEventListener(RankWidgetEvent.READY,this.onWidgetReadyHandler);
         this.widgetAnimation.addFrameScript(WIDGET_ANIM_PRE_END_LABEL,null);
         this.widgetAnimation.stop();
      }
      
      private function cleanAndClose() : void
      {
         this.resetAnimation();
         onCloseS();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.stopPropagation();
            this.tryToCloseView();
         }
      }
      
      private function onAnimationCheckBoxSelectHandler(param1:Event) : void
      {
         animationCheckBoxSelectedS(this.animationCheckBox.selected);
         this._animationEnabled = this.animationCheckBox.selected;
      }
      
      private function onWidgetReadyHandler(param1:RankWidgetEvent) : void
      {
         this._widget.removeEventListener(RankWidgetEvent.READY,this.onWidgetReadyHandler);
         this.onWidgetAnimComplete();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         this.tryToCloseView(true);
      }
      
      private function onReadyBtnClickHandler(param1:ButtonEvent) : void
      {
         this.tryToCloseView(true);
      }
   }
}
