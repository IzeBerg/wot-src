package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.interfaces.IAutoSearchFormView;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class StateViewBase extends UIComponentEx implements IAutoSearchFormView
   {
      
      public static const UPDATE_TIMER:String = "csUpdateTimer";
      
      private static const SCHEDULE_TIMER:uint = 1000;
      
      private static const TEN:uint = 10;
       
      
      public var sec:TextField;
      
      public var min:TextField;
      
      public var timerSeparator:TextField;
      
      public var mainField:TextField;
      
      public var submitButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      protected var model:AutoSearchVO;
      
      protected var currentState:String;
      
      protected var time:int = 0;
      
      public function StateViewBase()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.currentState = this.getSearchState();
         if(this.sec && this.min)
         {
            this.sec.mouseEnabled = this.min.mouseEnabled = false;
         }
         if(this.timerSeparator)
         {
            this.timerSeparator.mouseEnabled = false;
            this.timerSeparator.text = COMMON.COMMON_COLON;
         }
         if(this.mainField)
         {
            this.mainField.mouseEnabled = false;
            this.mainField.text = this.getMainLabel();
         }
         if(this.submitButton)
         {
            this.submitButton.addEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
            this.submitButton.mouseEnabled = true;
            this.submitButton.label = this.getSubmitLabel();
            this.submitButton.validateNow();
         }
         if(this.cancelButton)
         {
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
            this.cancelButton.mouseEnabled = true;
            this.cancelButton.label = this.getCancelLabel();
            this.cancelButton.validateNow();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.model)
         {
            this.enableButtons(true);
            this.updateView();
         }
      }
      
      override protected function onDispose() : void
      {
         this.stopTimer();
         this.model = null;
         if(this.submitButton)
         {
            this.submitButton.removeEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
            this.submitButton.dispose();
            this.submitButton = null;
         }
         if(this.cancelButton)
         {
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
            this.cancelButton.dispose();
            this.cancelButton = null;
         }
         this.timerSeparator = null;
         this.mainField = null;
         this.sec = null;
         this.min = null;
         super.onDispose();
      }
      
      public function changeButtonsState(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function enableButtons(param1:Boolean) : void
      {
         if(visible && this.cancelButton && this.cancelButton.visible)
         {
            this.cancelButton.enabled = param1;
         }
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         if(visible)
         {
            if(this.submitButton)
            {
               return this.submitButton;
            }
            if(this.cancelButton)
            {
               return this.cancelButton;
            }
         }
         return null;
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         if(this.submitButton)
         {
            _loc1_.push(this.submitButton);
         }
         if(this.cancelButton)
         {
            _loc1_.push(this.cancelButton);
         }
         return _loc1_;
      }
      
      public function setData(param1:AutoSearchVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.model = param1;
         if(this.model.timeDirection < 0)
         {
            this.mainField.visible = false;
            this.sec.visible = false;
            this.min.visible = false;
            this.timerSeparator.visible = false;
         }
         invalidateData();
      }
      
      public function setMainLabel(param1:String) : void
      {
         this.mainField.text = param1;
         this.mainField.visible = true;
      }
      
      public function setTimeDirection(param1:int) : void
      {
         this.model.timeDirection = param1;
         this.stopTimer();
      }
      
      public function setCountDownSeconds(param1:int) : void
      {
         this.time = param1;
         this.sec.visible = true;
         this.min.visible = true;
         this.timerSeparator.visible = true;
         this.updateTime();
         if(this.model.timeDirection > 0)
         {
            this.startTimer();
         }
         else
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.TIMER_TICK,null);
         }
      }
      
      public function stopTimer() : void
      {
         App.utils.scheduler.cancelTask(this.onTimer);
         this.time = 0;
      }
      
      protected function getSubmitLabel() : String
      {
         return Values.EMPTY_STR;
      }
      
      protected function getCancelLabel() : String
      {
         return Values.EMPTY_STR;
      }
      
      protected function getMainLabel() : String
      {
         return Values.EMPTY_STR;
      }
      
      protected function getSearchState() : String
      {
         return Values.EMPTY_STR;
      }
      
      protected function updateView() : void
      {
         this.stopTimer();
         this.time = this.model.countDownSeconds;
      }
      
      protected function contextMessage(param1:String) : void
      {
         if(param1 == null || param1 == Values.EMPTY_STR)
         {
            DebugUtils.LOG_ERROR(name,Errors.ABSTRACT_INVOKE);
         }
      }
      
      protected function startTimer() : void
      {
         App.utils.scheduler.scheduleTask(this.onTimer,SCHEDULE_TIMER);
      }
      
      protected function onTimer() : void
      {
         ++this.time;
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.TIMER_TICK,null);
      }
      
      protected function formatTime(param1:int) : Object
      {
         var _loc2_:uint = param1 | 0;
         var _loc3_:uint = _loc2_ / Time.HOUR | 0;
         var _loc4_:uint = (_loc2_ - _loc3_ * Time.HOUR) / Time.MINUTES_IN_HOUR;
         var _loc5_:uint = _loc2_ - _loc3_ * Time.HOUR - _loc4_ * Time.SECONDS_IN_MINUTE;
         var _loc6_:String = (_loc4_ < TEN ? Time.PREFIX : Values.EMPTY_STR) + _loc4_;
         var _loc7_:String = (_loc5_ < TEN ? Time.PREFIX : Values.EMPTY_STR) + _loc5_;
         return {
            "hours":String(_loc3_),
            "minutes":_loc6_,
            "seconds":_loc7_
         };
      }
      
      protected function updateTime() : void
      {
         var _loc1_:Object = null;
         if(this.min && this.sec)
         {
            _loc1_ = this.formatTime(this.time);
            this.min.text = _loc1_.minutes;
            this.sec.text = _loc1_.seconds;
            dispatchEvent(new Event(UPDATE_TIMER,true));
         }
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
            param1.handled = true;
            if(this.cancelButton && (this.model.canInvokeAutoSearch || this.model.canInvokeBattleQueue))
            {
               this.onCancelButtonClickHandler();
            }
         }
      }
      
      protected function onCancelButtonClick() : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.currentState));
      }
      
      private function onSubmitButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.currentState));
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent = null) : void
      {
         this.onCancelButtonClick();
      }
      
      public function get isOnStage() : Boolean
      {
         return Boolean(this.stage);
      }
   }
}
