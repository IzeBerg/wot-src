package net.wg.gui.battle.components.buttons
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.buttons.interfaces.IBattleButton;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IDragOutButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IDragOverButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IPressButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IReleaseOutSideButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IRollOutButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IRollOverButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IStateChangedButtonHandler;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleButton extends BattleUIComponent implements IBattleButton
   {
       
      
      protected var _isEnabled:Boolean = true;
      
      protected var _buttonState:String = "";
      
      protected var _newFrameStr:String = "";
      
      protected var _isRightClickAllowed:Boolean = false;
      
      private var _clickButtonHandler:IClickButtonHandler = null;
      
      private var _pressButtonHandler:IPressButtonHandler = null;
      
      private var _releaseOutSideButtonHandler:IReleaseOutSideButtonHandler = null;
      
      private var _rollOverButtonHandler:IRollOverButtonHandler = null;
      
      private var _rollOutButtonHandler:IRollOutButtonHandler = null;
      
      private var _dragOverButtonHandler:IDragOverButtonHandler = null;
      
      private var _dragOutButtonHandler:IDragOutButtonHandler = null;
      
      private var _stateChangedButtonHandler:IStateChangedButtonHandler = null;
      
      public function BattleButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._buttonState = InteractiveStates.UP;
         mouseChildren = false;
         tabChildren = false;
         buttonMode = true;
      }
      
      override protected function configUI() : void
      {
         this.setListeners();
         super.configUI();
      }
      
      override protected function draw() : void
      {
         throwLifeCycleException();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._newFrameStr != Values.EMPTY_STR)
            {
               gotoAndPlay(this._newFrameStr);
               this._newFrameStr = Values.EMPTY_STR;
            }
            if(this._stateChangedButtonHandler)
            {
               this._stateChangedButtonHandler.onButtonStateChanged(this);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._clickButtonHandler = null;
         this._pressButtonHandler = null;
         this._releaseOutSideButtonHandler = null;
         this._rollOverButtonHandler = null;
         this._rollOutButtonHandler = null;
         this._dragOverButtonHandler = null;
         this._dragOutButtonHandler = null;
         this._stateChangedButtonHandler = null;
         this.removeListeners();
         super.onDispose();
      }
      
      public function addClickCallBack(param1:IClickButtonHandler) : void
      {
         this._clickButtonHandler = param1;
      }
      
      public function addDragOutCallBack(param1:IDragOutButtonHandler) : void
      {
         this._dragOutButtonHandler = param1;
      }
      
      public function addDragOverCallBack(param1:IDragOverButtonHandler) : void
      {
         this._dragOverButtonHandler = param1;
      }
      
      public function addPressCallBack(param1:IPressButtonHandler) : void
      {
         this._pressButtonHandler = param1;
      }
      
      public function addReleaseOutSideCallBack(param1:IReleaseOutSideButtonHandler) : void
      {
         this._releaseOutSideButtonHandler = param1;
      }
      
      public function addRollOutCallBack(param1:IRollOutButtonHandler) : void
      {
         this._rollOutButtonHandler = param1;
      }
      
      public function addRollOverCallBack(param1:IRollOverButtonHandler) : void
      {
         this._rollOverButtonHandler = param1;
      }
      
      public function addStateChangeCallBack(param1:IStateChangedButtonHandler) : void
      {
         this._stateChangedButtonHandler = param1;
      }
      
      protected function setListeners() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePressHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler,false,0,true);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onMouseClickHandler,false,0,true);
      }
      
      protected function removeListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePressHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onMouseClickHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onReleaseOutsideHandler);
      }
      
      protected function invokeRollOverActions() : void
      {
      }
      
      protected function invokeRollOutActions() : void
      {
      }
      
      protected function invokePressActions() : void
      {
      }
      
      protected function invokeReleaseActions() : void
      {
      }
      
      protected function invokeReleaseOutsideActions() : void
      {
      }
      
      protected function getFrameLabel(param1:String) : String
      {
         return param1;
      }
      
      protected function invokeEnableActions() : void
      {
         this.state = InteractiveStates.UP;
         buttonMode = true;
      }
      
      protected function invokeDisableActions() : void
      {
         this.state = InteractiveStates.DISABLED;
         buttonMode = false;
      }
      
      override public function get enabled() : Boolean
      {
         return this._isEnabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this.enabled != param1)
         {
            this._isEnabled = param1;
            mouseChildren = false;
            if(this._isEnabled)
            {
               this.invokeEnableActions();
            }
            else
            {
               this.invokeDisableActions();
            }
         }
      }
      
      public function get state() : String
      {
         return this._buttonState;
      }
      
      public function set state(param1:String) : void
      {
         var _loc2_:String = this.getFrameLabel(param1);
         if(this._buttonState != param1 || this._newFrameStr != _loc2_)
         {
            this._buttonState = param1;
            this._newFrameStr = _loc2_;
            invalidate(InvalidationType.STATE);
         }
      }
      
      public function get isRightClickAllowed() : Boolean
      {
         return this._isRightClickAllowed;
      }
      
      public function set isRightClickAllowed(param1:Boolean) : void
      {
         this._isRightClickAllowed = param1;
      }
      
      protected function isClickAllowed(param1:MouseEvent) : Boolean
      {
         if(!(param1 is MouseEventEx))
         {
            return true;
         }
         var _loc2_:uint = MouseEventEx(param1).buttonIdx;
         return _loc2_ == MouseEventEx.LEFT_BUTTON || this._isRightClickAllowed && _loc2_ == MouseEventEx.RIGHT_BUTTON;
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         throwLifeCycleException();
         if(param1.buttonDown)
         {
            if(this._dragOverButtonHandler)
            {
               this._dragOverButtonHandler.onButtonDragOver(this);
            }
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onReleaseOutsideHandler,false,0,true);
            this.invokeRollOverActions();
            if(!this._isEnabled)
            {
               return;
            }
         }
         else
         {
            this.invokeRollOverActions();
            if(!this._isEnabled)
            {
               return;
            }
            if(this._rollOverButtonHandler)
            {
               this._rollOverButtonHandler.onButtonRollOver(this);
            }
         }
         this.state = InteractiveStates.OVER;
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         throwLifeCycleException();
         if(param1.buttonDown)
         {
            if(this._dragOutButtonHandler)
            {
               this._dragOutButtonHandler.onButtonDragOut(this);
            }
            this.invokeRollOutActions();
            if(!this._isEnabled)
            {
               return;
            }
         }
         else
         {
            this.invokeRollOutActions();
            if(!this.enabled)
            {
               return;
            }
            if(this._rollOutButtonHandler)
            {
               this._rollOutButtonHandler.onButtonRollOut(this);
            }
         }
         this.state = InteractiveStates.OUT;
      }
      
      private function onMousePressHandler(param1:MouseEvent) : void
      {
         throwLifeCycleException();
         if(!this.enabled)
         {
            return;
         }
         if(this.isClickAllowed(param1))
         {
            if(this._pressButtonHandler)
            {
               this._pressButtonHandler.onButtonPress(this);
            }
            this.state = InteractiveStates.DOWN;
         }
         this.invokePressActions();
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         throwLifeCycleException();
         this.invokeReleaseActions();
         if(!this.enabled)
         {
            return;
         }
         if(this.isClickAllowed(param1))
         {
            this.state = InteractiveStates.RELEASE;
            if(this._clickButtonHandler)
            {
               this._clickButtonHandler.onButtonClick(this);
            }
         }
      }
      
      private function onReleaseOutsideHandler(param1:MouseEvent) : void
      {
         throwLifeCycleException();
         if(contains(DisplayObject(param1.target)))
         {
            return;
         }
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onReleaseOutsideHandler,false);
         this.invokeReleaseOutsideActions();
         if(!this.enabled)
         {
            return;
         }
         if(this._releaseOutSideButtonHandler)
         {
            this._releaseOutSideButtonHandler.onButtonReleaseOutSide(this);
         }
         this.state = InteractiveStates.RELEASE;
      }
   }
}
