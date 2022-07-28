package net.wg.gui.dialogs
{
   import flash.display.InteractiveObject;
   import flash.events.EventPhase;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.base.meta.ISimpleDialogMeta;
   import net.wg.infrastructure.base.meta.impl.SimpleDialogMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class SimpleDialog extends SimpleDialogMeta implements ISimpleDialogMeta
   {
      
      public static const SUBMIT_BUTTON:String = "submit";
      
      public static const CLOSE_BUTTON:String = "close";
      
      private static const BTN_MARGIN:int = 9;
      
      private static const MIN_WIDTH:int = 360;
      
      private static const MIN_HEIGHT:int = 115;
      
      private static const TEXT_HEIGHT_PADDING:uint = 3;
      
      private static const WINDOW_PADDING_RIGHT:int = 12;
      
      private static const WINDOW_PADDING_BOTTOM:int = 15;
      
      private static const BUTTON_ENABLE_INVALID:String = "btnEnInv";
      
      private static const BUTTON_FOCUS_INVALID:String = "btnFocusInv";
      
      private static const ID_FIELD:String = "id";
      
      private static const BTN_GAP:Number = 5;
      
      protected static const ADDITIONAL_MULTI_LINE_PADDING:uint = 10;
       
      
      public var textField:TextField = null;
      
      public var firstBtn:SoundButtonEx = null;
      
      public var secondBtn:SoundButtonEx = null;
      
      public var thirdBtn:SoundButtonEx = null;
      
      public var dynamicWhiteButton:SoundButtonEx = null;
      
      private var _minWidth:int = 360;
      
      private var _minHeight:int = 115;
      
      private var _btnEnableCandidate:ItemStatusData;
      
      private var _btnFocusCandidateId:String;
      
      private var _lastFocusedBtn:SoundButtonEx = null;
      
      public function SimpleDialog()
      {
         super();
      }
      
      private static function hideBtnProcessor(param1:Button) : void
      {
         param1.visible = false;
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(window != null)
         {
            _loc2_ = window.contentPadding as Padding;
            if(_loc2_ != null)
            {
               _loc2_.right = WINDOW_PADDING_RIGHT;
               _loc2_.bottom = WINDOW_PADDING_BOTTOM;
            }
         }
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         setFocus(this._lastFocusedBtn);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         this.firstBtn.dynamicSizeByText = true;
         this.secondBtn.dynamicSizeByText = true;
         this.thirdBtn.dynamicSizeByText = true;
         this.dynamicWhiteButton.dynamicSizeByText = true;
         this.firstBtn.changeSizeOnlyUpwards = true;
         this.secondBtn.changeSizeOnlyUpwards = true;
         this.thirdBtn.changeSizeOnlyUpwards = true;
         this.dynamicWhiteButton.changeSizeOnlyUpwards = true;
         this.reflowDialogToCtrl();
         updateStage(App.appWidth,App.appHeight);
         this.processButtons(this.addListenerButtonProcessor);
      }
      
      override protected function onDispose() : void
      {
         this.processButtons(this.removeListenerButtonProcessor);
         this.dynamicWhiteButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.textField = null;
         this._lastFocusedBtn = null;
         this.firstBtn.dispose();
         this.firstBtn = null;
         this.secondBtn.dispose();
         this.secondBtn = null;
         this.thirdBtn.dispose();
         this.thirdBtn = null;
         this.dynamicWhiteButton.dispose();
         this.dynamicWhiteButton = null;
         this._btnEnableCandidate = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Button = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:SoundButtonEx = null;
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.applyLayout();
         }
         var _loc1_:Vector.<SoundButtonEx> = null;
         if(isInvalid(BUTTON_ENABLE_INVALID) && this._btnEnableCandidate)
         {
            _loc2_ = this._btnEnableCandidate.id;
            _loc3_ = this._btnEnableCandidate.status;
            _loc1_ = this.getAllButtons();
            _loc5_ = _loc1_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = _loc1_[_loc6_];
               if(_loc4_.data && _loc4_.data.hasOwnProperty(ID_FIELD))
               {
                  if(_loc2_ == _loc4_.data.id)
                  {
                     _loc4_.enabled = _loc3_;
                     break;
                  }
               }
               _loc6_++;
            }
         }
         if(isInvalid(BUTTON_FOCUS_INVALID) && this._btnFocusCandidateId)
         {
            _loc1_ = this.getAllButtons();
            for each(_loc7_ in _loc1_)
            {
               if(_loc7_.data && _loc7_.data.hasOwnProperty(ID_FIELD) && this._btnFocusCandidateId == _loc7_.data.id)
               {
                  if(_loc7_.enabled)
                  {
                     this._lastFocusedBtn = _loc7_;
                  }
                  break;
               }
            }
         }
      }
      
      public function as_setButtonEnabling(param1:String, param2:Boolean) : void
      {
         if(this._btnEnableCandidate == null)
         {
            this._btnEnableCandidate = new ItemStatusData();
         }
         this._btnEnableCandidate.id = param1;
         this._btnEnableCandidate.status = param2;
         invalidate(BUTTON_ENABLE_INVALID);
      }
      
      public function as_setButtonFocus(param1:String) : void
      {
         this._btnFocusCandidateId = param1;
         invalidate(BUTTON_FOCUS_INVALID);
      }
      
      override protected function setButtons(param1:Array) : void
      {
         var _loc5_:SoundButtonEx = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc2_:Vector.<Button> = this.getButtonsOrder();
         var _loc3_:int = param1.length;
         var _loc4_:int = _loc2_.length - _loc3_;
         assert(_loc4_ >= 0,"buttonNames too much");
         _loc5_ = null;
         var _loc6_:int = _loc3_ - 1;
         while(_loc6_ >= 0)
         {
            _loc5_ = _loc2_[_loc6_ + _loc4_] as SoundButtonEx;
            App.utils.asserter.assertNotNull(_loc5_,"button" + Errors.CANT_NULL);
            _loc7_ = param1[_loc6_];
            _loc8_ = _loc7_.id;
            if(_loc8_ == CLOSE_BUTTON)
            {
               this.dynamicWhiteButton.x = _loc5_.x;
               this.dynamicWhiteButton.y = _loc5_.y;
               this.dynamicWhiteButton.data = _loc7_;
               this.dynamicWhiteButton.label = _loc7_.label;
               if(_loc7_.focused)
               {
                  this._lastFocusedBtn = this.dynamicWhiteButton;
               }
               this.dynamicWhiteButton.visible = true;
               this.dynamicWhiteButton.soundType = SoundTypes.CANCEL_BTN;
               this.addListenerButtonProcessor(this.dynamicWhiteButton);
               _loc5_.visible = false;
               this.dynamicWhiteButton.validateNow();
            }
            else
            {
               _loc5_.data = _loc7_;
               _loc5_.label = _loc7_.label;
               if(_loc7_.focused)
               {
                  this._lastFocusedBtn = _loc5_;
               }
               _loc5_.visible = true;
               if(_loc8_ == SUBMIT_BUTTON)
               {
                  _loc5_.soundType = SoundTypes.OK_BTN;
               }
               else
               {
                  _loc5_.soundType = SoundTypes.NORMAL_BTN;
               }
               _loc5_.validateNow();
            }
            _loc6_--;
         }
      }
      
      public function as_setText(param1:String) : void
      {
         this.textField.htmlText = param1;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         invalidateLayout();
      }
      
      public function as_setTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      protected function applyLayout() : void
      {
         this.layoutButtons(this.getBackgroundActualHeight());
         UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
      }
      
      protected function getBackgroundActualHeight() : Number
      {
         return Math.max(this.getTextAreaCurrentHeight(),this.getTextAreaMinHeight());
      }
      
      protected function getTextAreaMinHeight() : Number
      {
         var _loc1_:Number = this.thirdBtn.height;
         return Math.ceil(this._minHeight - _loc1_ - TEXT_HEIGHT_PADDING);
      }
      
      protected function getTextAreaCurrentHeight() : Number
      {
         return Math.ceil(this.textField.y + this.textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING);
      }
      
      protected function layoutButtons(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:Vector.<SoundButtonEx> = this.getAllButtons();
         var _loc3_:uint = _loc2_.length;
         var _loc4_:SoundButtonEx = null;
         _loc5_ = window.width - window.contentPadding.horizontal;
         var _loc6_:int = _loc3_ - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = _loc2_[_loc6_];
            if(_loc4_.visible)
            {
               _loc5_ -= _loc4_.width;
               _loc2_[_loc6_].x = _loc5_;
               _loc5_ -= BTN_GAP;
               _loc2_[_loc6_].y = param1;
            }
            _loc6_--;
         }
      }
      
      protected function getButtonsOrder() : Vector.<Button>
      {
         return Vector.<Button>([this.firstBtn,this.secondBtn,this.thirdBtn]);
      }
      
      protected function getAllButtons() : Vector.<SoundButtonEx>
      {
         return Vector.<SoundButtonEx>([this.firstBtn,this.secondBtn,this.thirdBtn,this.dynamicWhiteButton]);
      }
      
      protected function updateActualSize() : void
      {
         this.textField.height = Math.max(this.textField.textHeight,this._minHeight - this.thirdBtn.height - BTN_MARGIN);
         var _loc1_:Number = this.getBackgroundActualHeight();
         window.setMinHeight(_loc1_);
         window.setSize(actualWidth,_loc1_);
      }
      
      protected function onBtnClick(param1:Object) : void
      {
         var _loc2_:String = param1.id;
         assertNotNull(_loc2_,"Button has not unique name");
         onButtonClickS(_loc2_);
      }
      
      private function reflowDialogToCtrl() : void
      {
         this.processButtons(hideBtnProcessor);
      }
      
      private function processButtons(param1:Function) : void
      {
         var _loc2_:Button = null;
         for each(_loc2_ in this.getButtonsOrder())
         {
            param1(_loc2_);
         }
      }
      
      private function addListenerButtonProcessor(param1:Button) : void
      {
         param1.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      private function removeListenerButtonProcessor(param1:Button) : void
      {
         param1.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override public function get height() : Number
      {
         var _loc1_:Number = this.thirdBtn.height;
         return this.getBackgroundActualHeight() + TEXT_HEIGHT_PADDING + _loc1_;
      }
      
      public function get minWidth() : Number
      {
         return this._minWidth;
      }
      
      public function set minWidth(param1:Number) : void
      {
         if(param1 == this._minWidth)
         {
            return;
         }
         this._minWidth = param1;
      }
      
      public function get minHeight() : Number
      {
         return this._minHeight;
      }
      
      public function set minHeight(param1:Number) : void
      {
         if(param1 == this._minHeight)
         {
            return;
         }
         this._minHeight = param1;
         this.updateActualSize();
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         if(param1.eventPhase == EventPhase.AT_TARGET)
         {
            this.onBtnClick(Button(param1.target).data);
         }
      }
   }
}
