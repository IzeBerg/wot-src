package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.components.common.waiting.WaitingMc;
   import net.wg.gui.cyberSport.interfaces.IAutoSearchFormView;
   import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
   import net.wg.gui.cyberSport.views.events.SCUpdateFocusEvent;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class CSAutoSearchMainView extends UIComponentEx implements ICSAutoSearchMainView
   {
      
      private static const FRAME_ANIMATION:uint = 7;
      
      private static const WAITING_Y_SHIFT:Number = -158;
      
      private static const FORM_Y_SHIFT:Number = 43;
      
      private static const UPDATE_BUTTONS_STATE:String = "updateButtonsState";
      
      private static const UPDATE_MAIN_LABEL:String = "updateMainLabel";
      
      private static const UPDATE_TIME_DIRECTION:String = "updateTimeDirection";
      
      private static const UPDATE_COUNT_DOWN_SECONDS:String = "updateCountDownSeconds";
       
      
      public var waitingCmp:WaitingMc;
      
      public var searchBg:Sprite;
      
      public var formBg:Sprite;
      
      private var _formView:IAutoSearchFormView = null;
      
      private var _model:AutoSearchVO;
      
      private var _frameCount:Number = 7;
      
      private var _enableWaitingPlrBtn:Boolean = false;
      
      private var _enableSearchBtn:Boolean = false;
      
      private var _buttonsUpdated:Boolean = true;
      
      private var _mainLabel:String = "";
      
      private var _timeDirection:int = 0;
      
      private var _countDownSeconds:int = -1;
      
      public function CSAutoSearchMainView()
      {
         super();
         this.waitingCmp.stop();
      }
      
      public function enableButtons(param1:Boolean) : void
      {
         if(this._formView)
         {
            this._formView.enableButtons(param1);
         }
      }
      
      public function changeButtonsState(param1:Boolean, param2:Boolean) : void
      {
         this._enableSearchBtn = param1;
         this._enableWaitingPlrBtn = param2;
         this._buttonsUpdated = false;
         invalidate(UPDATE_BUTTONS_STATE);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         if(this._formView && this._formView.isOnStage && this._formView.visible)
         {
            return this._formView.getComponentForFocus();
         }
         return null;
      }
      
      public function stopTimer() : void
      {
         if(this._formView)
         {
            this._formView.stopTimer();
         }
      }
      
      public function setData(param1:AutoSearchVO) : void
      {
         this.waitingCmp.visible = false;
         this.formBg.visible = false;
         this._model = param1;
         invalidateData();
         this.initWheelBehaviour();
      }
      
      public function setMainLabel(param1:String) : void
      {
         this._mainLabel = param1;
         invalidate(UPDATE_MAIN_LABEL);
      }
      
      public function setTimeDirection(param1:int) : void
      {
         this._timeDirection = param1;
         invalidate(UPDATE_TIME_DIRECTION);
      }
      
      public function setCountDownSeconds(param1:int) : void
      {
         this._countDownSeconds = param1;
         invalidate(UPDATE_COUNT_DOWN_SECONDS);
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         if(this._formView)
         {
            _loc1_ = _loc1_.concat(this._formView.getFocusChain());
         }
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.clearForm();
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         this.searchBg = null;
         this.formBg = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._model)
         {
            this.initForm();
         }
         if(this._formView)
         {
            if(isInvalid(UPDATE_MAIN_LABEL) && this._mainLabel != Values.EMPTY_STR)
            {
               App.utils.scheduler.scheduleOnNextFrame(this._formView.setMainLabel,this._mainLabel);
            }
            if(isInvalid(UPDATE_TIME_DIRECTION) && this._timeDirection != 0)
            {
               App.utils.scheduler.scheduleOnNextFrame(this._formView.setTimeDirection,this._timeDirection);
            }
            if(isInvalid(UPDATE_COUNT_DOWN_SECONDS) && this._countDownSeconds >= 0)
            {
               App.utils.scheduler.scheduleOnNextFrame(this._formView.setCountDownSeconds,this._countDownSeconds);
            }
         }
         if(!this._buttonsUpdated && isInvalid(UPDATE_BUTTONS_STATE))
         {
            this._buttonsUpdated = true;
            this.updateButtons();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      private function initWheelBehaviour() : void
      {
         if(this._model.state == CYBER_SPORT_ALIASES.AUTO_SEARCH_CONFIRMATION_STATE)
         {
            this.waitingCmp.stop();
            this._frameCount = FRAME_ANIMATION;
            this.updateWaiting();
         }
         else if(this._model.state == CYBER_SPORT_ALIASES.AUTO_SEARCH_ERROR_STATE)
         {
            this.waitingCmp.stop();
         }
         else
         {
            this.waitingCmp.play();
         }
      }
      
      private function updateWaiting() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }
      
      private function updateButtons() : void
      {
         if(this._formView)
         {
            this._formView.changeButtonsState(this._enableWaitingPlrBtn,this._enableSearchBtn);
         }
      }
      
      private function initForm() : void
      {
         this.clearForm();
         this._formView = App.utils.classFactory.getComponent(this._model.state,IAutoSearchFormView);
         this._formView.visible = false;
         this.addChild(DisplayObject(this._formView));
         App.utils.scheduler.scheduleOnNextFrame(this.updateForm);
         this.waitingCmp.visible = true;
         this.formBg.visible = true;
      }
      
      private function updateForm() : void
      {
         if(this._formView)
         {
            this._formView.addEventListener(StateViewBase.UPDATE_TIMER,this.onFormViewUpdateTimerHandler);
            this._formView.setData(this._model);
            this._formView.validateNow();
            this.updateFormPosition();
            this._formView.visible = true;
         }
         dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
         dispatchEvent(new SCUpdateFocusEvent(SCUpdateFocusEvent.UPDATE_FOCUS));
      }
      
      private function updateSize() : void
      {
         this.searchBg.width = _width;
         this.searchBg.height = _height;
         this.waitingCmp.x = this.searchBg.x + (this.searchBg.width - this.waitingCmp.width >> 1) | 0;
         this.waitingCmp.y = this.searchBg.y + (this.searchBg.height - this.waitingCmp.height >> 1) + WAITING_Y_SHIFT | 0;
         this.formBg.x = this.searchBg.x + (this.searchBg.width - this.formBg.width >> 1) | 0;
         this.formBg.y = this.waitingCmp.y + FORM_Y_SHIFT;
         this.updateFormPosition();
      }
      
      private function updateFormPosition() : void
      {
         if(this._formView)
         {
            this._formView.x = this.formBg.x + (this.formBg.width - this._formView.width >> 1) | 0;
            this._formView.y = this.formBg.y + (this.formBg.height - this._formView.height >> 1) | 0;
         }
      }
      
      public function removeForm() : void
      {
         this.clearForm();
      }
      
      public function get hasForm() : Boolean
      {
         return this._formView != null;
      }
      
      private function clearForm() : void
      {
         if(this._formView)
         {
            App.utils.scheduler.cancelTask(this.updateForm);
            App.utils.scheduler.cancelTask(this._formView.setMainLabel);
            App.utils.scheduler.cancelTask(this._formView.setTimeDirection);
            App.utils.scheduler.cancelTask(this._formView.setCountDownSeconds);
            dispatchEvent(new SCUpdateFocusEvent(SCUpdateFocusEvent.CLEAR_FOCUS));
            this._formView.removeEventListener(StateViewBase.UPDATE_TIMER,this.onFormViewUpdateTimerHandler);
            this._formView.dispose();
            this.removeChild(DisplayObject(this._formView));
            this._formView = null;
         }
      }
      
      private function onFormViewUpdateTimerHandler(param1:Event) : void
      {
         this.initWheelBehaviour();
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this._frameCount <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         }
         else
         {
            _loc2_ = this.waitingCmp.currentFrame - 1;
            if(_loc2_ <= 0)
            {
               _loc2_ = this.waitingCmp.totalFrames - 1;
            }
            this.waitingCmp.gotoAndStop(_loc2_);
            --this._frameCount;
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(this._formView)
         {
            this._formView.handleInput(param1);
         }
      }
   }
}
