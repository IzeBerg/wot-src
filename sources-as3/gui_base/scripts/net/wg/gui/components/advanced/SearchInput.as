package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.interfaces.ISearchInput;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.utils.Constraints;
   
   public class SearchInput extends TextInput implements ISearchInput
   {
      
      private static const SEARCH_ICON_GAP:int = 1;
      
      private static const SEARCH_ICON_WIDTH:int = 11;
      
      private static const SEARCH_ICON_X:int = 8;
      
      private static const SEARCH_ICON_VISIBLE_INV:String = "searchIconVisibleInv";
       
      
      public var clearButton:SoundButtonEx = null;
      
      public var searchIcon:Sprite = null;
      
      private var _promptTextColor:uint = 5066047;
      
      private var _normalTextColor:uint = 9868935;
      
      private var _isSearchIconVisible:Boolean = true;
      
      public function SearchInput()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         defaultTextFormat.italic = false;
         defaultTextFormat.color = this._promptTextColor;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!constraintsDisabled)
         {
            constraints.addElement(this.clearButton.name,this.clearButton,Constraints.RIGHT | Constraints.TOP);
         }
         this.clearButton.addEventListener(ButtonEvent.CLICK,this.onClearButtonClickHandler);
         this.updateClearButton();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(SEARCH_ICON_VISIBLE_INV))
         {
            this.setSearchIconVisibility(this._isSearchIconVisible);
         }
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         var _loc1_:String = textField.text;
         textField.textColor = !!this.isPromptShow ? uint(this._promptTextColor) : uint(this._normalTextColor);
         textField.text = _loc1_;
         this.updateClearButton();
      }
      
      override protected function onDispose() : void
      {
         this.clearButton.removeEventListener(ButtonEvent.CLICK,this.onClearButtonClickHandler);
         this.clearButton.dispose();
         this.clearButton = null;
         this.searchIcon = null;
         super.onDispose();
      }
      
      private function setSearchIconVisibility(param1:Boolean) : void
      {
         var _loc2_:ConstrainedElement = null;
         this.searchIcon.visible = param1;
         if(!constraintsDisabled)
         {
            _loc2_ = constraints.getElement(textField.name);
            if(param1)
            {
               _loc2_.left = SEARCH_ICON_GAP + SEARCH_ICON_WIDTH + SEARCH_ICON_X;
            }
            else
            {
               _loc2_.left = SEARCH_ICON_X;
            }
            setActualSize(_width,_height);
            constraints.update(_width,_height);
         }
      }
      
      private function updateClearButton() : void
      {
         this.clearButton.visible = !this.isPromptShow && _text != Values.EMPTY_STR;
      }
      
      private function clear() : void
      {
         text = Values.EMPTY_STR;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get promptTextColor() : uint
      {
         return this._promptTextColor;
      }
      
      public function set promptTextColor(param1:uint) : void
      {
         this._promptTextColor = param1;
         this.updateText();
      }
      
      public function get normalTextColor() : uint
      {
         return this._normalTextColor;
      }
      
      public function set normalTextColor(param1:uint) : void
      {
         this._normalTextColor = param1;
         this.updateText();
      }
      
      public function get isPromptShow() : Boolean
      {
         return textField.text.length > 0 && _text == Values.EMPTY_STR;
      }
      
      public function get isSearchIconVisible() : Boolean
      {
         return this._isSearchIconVisible;
      }
      
      public function set isSearchIconVisible(param1:Boolean) : void
      {
         if(this._isSearchIconVisible != param1)
         {
            this._isSearchIconVisible = param1;
            invalidate(SEARCH_ICON_VISIBLE_INV);
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.details.code == Keyboard.ESCAPE && text != Values.EMPTY_STR)
         {
            this.clear();
            param1.handled = true;
         }
         super.handleInput(param1);
      }
      
      override protected function handleTextChange(param1:Event) : void
      {
         super.handleTextChange(param1);
         this.updateClearButton();
      }
      
      private function onClearButtonClickHandler(param1:ButtonEvent) : void
      {
         this.clear();
      }
   }
}
