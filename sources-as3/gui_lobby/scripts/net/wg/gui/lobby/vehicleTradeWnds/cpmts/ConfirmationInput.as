package net.wg.gui.lobby.vehicleTradeWnds.cpmts
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.UserInputControl;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class ConfirmationInput extends UIComponentEx
   {
      
      public static const USER_INPUT_HANDLER:String = "userInputHandler";
      
      private static const PADDING_FOR_NEXT_ELEMENT:int = 10;
      
      private static const AUTO_UPDATE_TIMER:int = 5000;
      
      private static const RESTRICT:String = "0-9\\-";
      
      private static const INVALIDATE_QUESTION:String = "invalidateQuestion";
      
      private static const INVALIDATE_TEXTFIELD:String = "invalidateTextField";
      
      private static const DISABLE_ALPHA:Number = 0.5;
      
      private static const ENABLE_ALPHA:Number = 1;
       
      
      public var textHeader:TextField;
      
      public var controlQuestion:TextField;
      
      public var userInput:TextInput;
      
      public var errorMessage:TextField;
      
      private var _headerText:String = "";
      
      private var _questionText:String = "";
      
      private var _errorText:String = "";
      
      private var _controlText:String = "";
      
      private var _formattedControlText:String = "";
      
      private var _creditsParseResult:IFormattedInt;
      
      private var _userInputControl:UserInputControl;
      
      public function ConfirmationInput()
      {
         super();
         this._userInputControl = new UserInputControl();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.showErrorState(false);
         this.userInput.addEventListener(InputEvent.INPUT,this.onUserInputInputHandler);
         this.userInput.addEventListener(Event.CHANGE,this.onUserInputChangeHandler);
         this.userInput.textField.restrict = RESTRICT;
      }
      
      override protected function onDispose() : void
      {
         this.userInput.removeEventListener(InputEvent.INPUT,this.onUserInputInputHandler);
         this.userInput.removeEventListener(Event.CHANGE,this.onUserInputChangeHandler);
         this.userInput.dispose();
         this.userInput = null;
         this.textHeader = null;
         this.controlQuestion = null;
         this.errorMessage = null;
         this._creditsParseResult = null;
         this._userInputControl = null;
         App.utils.scheduler.cancelTask(this.runtimeValidate);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textHeader.htmlText = this._headerText;
            this.errorMessage.htmlText = this._errorText;
            invalidate(INVALIDATE_QUESTION);
         }
         if(isInvalid(INVALIDATE_QUESTION))
         {
            this.controlQuestion.htmlText = this._questionText;
         }
         if(isInvalid(INVALIDATE_TEXTFIELD))
         {
            this.userInput.textField.restrict = RESTRICT;
         }
      }
      
      public function cleanField() : void
      {
         if(this.userInput)
         {
            this.userInput.text = Values.EMPTY_STR;
         }
         this.showErrorState(false);
         dispatchEvent(new Event(USER_INPUT_HANDLER));
      }
      
      public function getNextPosition() : int
      {
         return this.errorMessage.y + this.errorMessage.height + PADDING_FOR_NEXT_ELEMENT;
      }
      
      public function getUserText() : String
      {
         var _loc1_:IFormattedInt = App.utils.locale.parseFormattedInteger(this.userInput.text);
         return _loc1_.value.toString();
      }
      
      private function showErrorState(param1:Boolean) : void
      {
         if(this.userInput.text == Values.EMPTY_STR)
         {
            this.userInput.highlight = false;
            this.errorMessage.visible = false;
         }
         else
         {
            this.userInput.highlight = param1;
            this.errorMessage.visible = param1;
         }
      }
      
      private function runtimeValidate() : void
      {
         this.showErrorState(!this.isValidControlInput);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         this.alpha = !!param1 ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
         this.userInput.enabled = param1;
         this.userInput.textField.restrict = RESTRICT;
         super.enabled = param1;
         invalidate(INVALIDATE_TEXTFIELD);
      }
      
      public function get controlText() : String
      {
         return this._controlText;
      }
      
      public function set controlText(param1:String) : void
      {
         this._controlText = param1;
      }
      
      public function get formattedControlText() : String
      {
         return this._formattedControlText;
      }
      
      public function set formattedControlText(param1:String) : void
      {
         this._creditsParseResult = App.utils.locale.parseFormattedInteger(param1);
         this._formattedControlText = param1;
      }
      
      public function get headerText() : String
      {
         return this._headerText;
      }
      
      public function set headerText(param1:String) : void
      {
         this._headerText = param1;
      }
      
      public function get questionText() : String
      {
         return this._questionText;
      }
      
      public function set questionText(param1:String) : void
      {
         this._questionText = param1;
         invalidate(INVALIDATE_QUESTION);
      }
      
      public function get errorText() : String
      {
         return this._errorText;
      }
      
      public function set errorText(param1:String) : void
      {
         this._errorText = param1;
      }
      
      public function get isValidControlInput() : Boolean
      {
         if(this._creditsParseResult)
         {
            return this._userInputControl.cmpFormatUserInputString(this.userInput.text,this._creditsParseResult.delimiter,this.formattedControlText,this.controlText);
         }
         return false;
      }
      
      private function get isEmptyText() : Boolean
      {
         return this.userInput.text == Values.EMPTY_STR;
      }
      
      private function onUserInputInputHandler(param1:InputEvent) : void
      {
         if(param1.details.value == InputValue.KEY_UP)
         {
            this.showErrorState(false);
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            if(param1.details.code == Keyboard.ENTER)
            {
               this.showErrorState(!this.isValidControlInput);
            }
            else if(!this.isEmptyText)
            {
               App.utils.scheduler.scheduleTask(this.runtimeValidate,AUTO_UPDATE_TIMER);
            }
         }
      }
      
      private function onUserInputChangeHandler(param1:Event) : void
      {
         if(param1.target == this.userInput)
         {
            dispatchEvent(new Event(USER_INPUT_HANDLER));
         }
      }
   }
}
