package net.wg.gui.components.common
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.UserInputControl;
   import net.wg.infrastructure.base.meta.IInputCheckerMeta;
   import net.wg.infrastructure.base.meta.impl.InputCheckerMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   
   public class InputChecker extends InputCheckerMeta implements IInputCheckerMeta, IFocusContainer
   {
       
      
      public var errorMessage:TextField = null;
      
      public var title:TextField = null;
      
      public var body:TextField = null;
      
      public var textInput:TextInput = null;
      
      private var _formattedControlNumber:String = "";
      
      private var creditsParseResult:IFormattedInt = null;
      
      private var userInputControl:UserInputControl = null;
      
      private var _isInvalidUserText:Boolean = false;
      
      private var _defaultInterval:int = 5000;
      
      private var _originalControlNumber:String = "";
      
      public function InputChecker()
      {
         super();
         this.userInputControl = new UserInputControl();
         this.title.mouseEnabled = this.body.mouseEnabled = this.errorMessage.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.textInput.removeEventListener(InputEvent.INPUT,this.userInputHandler);
         this.textInput.removeEventListener(Event.CHANGE,this.textInputChangeHandler);
         this.textInput.dispose();
         this.textInput = null;
         this.title = null;
         this.body = null;
         this.errorMessage = null;
         this.creditsParseResult = null;
         this.userInputControl = null;
         App.utils.scheduler.cancelTask(this.runtimeValidate);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.showErrorState(false);
         if(this.textInput)
         {
            this.textInput.addEventListener(InputEvent.INPUT,this.userInputHandler);
            this.textInput.addEventListener(Event.CHANGE,this.textInputChangeHandler);
         }
      }
      
      public function as_invalidUserText(param1:Boolean) : void
      {
         if(param1 == this._isInvalidUserText)
         {
            return;
         }
         this._isInvalidUserText = param1;
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }
      
      public function as_setBody(param1:String) : void
      {
         this.body.htmlText = param1;
      }
      
      public function as_setErrorMsg(param1:String) : void
      {
         this.errorMessage.htmlText = param1;
      }
      
      public function as_setFormattedControlNumber(param1:String) : void
      {
         this.creditsParseResult = App.utils.locale.parseFormattedInteger(param1);
         this._formattedControlNumber = param1;
      }
      
      public function as_setOriginalControlNumber(param1:String) : void
      {
         this._originalControlNumber = param1;
      }
      
      public function as_setTitle(param1:String) : void
      {
         this.title.htmlText = param1;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.textInput;
      }
      
      public function getUserText() : String
      {
         var _loc1_:IFormattedInt = App.utils.locale.parseFormattedInteger(this.textInput.text);
         return _loc1_.value.toString();
      }
      
      private function runtimeValidate() : void
      {
         this.showErrorState(!this.isValidControlInput);
      }
      
      private function showErrorState(param1:Boolean) : void
      {
         if(this.textInput.text == "")
         {
            this.textInput.highlight = false;
            this.errorMessage.visible = false;
         }
         else
         {
            this.textInput.highlight = param1;
            this.errorMessage.visible = param1;
         }
      }
      
      public function get isInvalidUserText() : Boolean
      {
         return this._isInvalidUserText;
      }
      
      public function set defaultInterval(param1:int) : void
      {
         this._defaultInterval = param1;
      }
      
      public function get isValidControlInput() : Boolean
      {
         if(this.creditsParseResult)
         {
            return this.userInputControl.cmpFormatUserInputString(this.textInput.text,this.creditsParseResult.delimiter,this.formattedControlText,this.originalControlNumber);
         }
         return false;
      }
      
      public function get formattedControlText() : String
      {
         return this._formattedControlNumber;
      }
      
      private function get originalControlNumber() : String
      {
         return this._originalControlNumber;
      }
      
      private function get isEmptyText() : Boolean
      {
         return this.textInput.text == "";
      }
      
      private function userInputHandler(param1:InputEvent) : void
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
               App.utils.scheduler.scheduleTask(this.runtimeValidate,this._defaultInterval);
            }
         }
      }
      
      private function textInputChangeHandler(param1:Event) : void
      {
         var _loc2_:Boolean = this.isValidControlInput;
         sendUserInputS(this.getUserText(),_loc2_);
         if(_loc2_)
         {
            this.showErrorState(false);
         }
      }
   }
}
