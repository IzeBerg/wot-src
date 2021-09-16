package net.wg.gui.messenger.forms
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class ChannelsSearchForm extends UIComponentEx implements IViewStackContent
   {
       
      
      public var searchLabel:LabelControl = null;
      
      public var searchResultLabel:LabelControl = null;
      
      public var searchNameInput:TextInput = null;
      
      public var searchButton:SoundButtonEx = null;
      
      public var searchResultList:ScrollingListEx = null;
      
      public var joinButton:SoundButtonEx = null;
      
      public var bg:Sprite = null;
      
      private var _data:Object = null;
      
      private const SB_PADDING:Padding = new Padding(2,2,2,2);
      
      public function ChannelsSearchForm()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG ChannelsSearchForm " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.joinButton.enabled = false;
         this.searchButton.addEventListener(ButtonEvent.CLICK,this.onSearchButtonClickHandler);
         this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinButtonClickHandler);
         this.searchResultList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onSearchResultListItemDoubleClickHandler);
         this.searchResultList.addEventListener(ListEvent.INDEX_CHANGE,this.onSearchResultListIndexChangeHandler);
         this.searchNameInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("searchLabel",this.searchLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchNameInput",this.searchNameInput,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchButton",this.searchButton,Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchResultLabel",this.searchResultLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchResultList",this.searchResultList,Constraints.ALL);
         constraints.addElement("bg",this.bg,Constraints.ALL);
         constraints.addElement("joinButton",this.joinButton,Constraints.LEFT | Constraints.BOTTOM);
         this.searchResultList.sbPadding = this.SB_PADDING;
         this.searchResultList.smartScrollBar = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.searchButton.removeEventListener(ButtonEvent.CLICK,this.onSearchButtonClickHandler);
         this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinButtonClickHandler);
         this.searchResultList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onSearchResultListItemDoubleClickHandler);
         this.searchResultList.removeEventListener(ListEvent.INDEX_CHANGE,this.onSearchResultListIndexChangeHandler);
         this.searchNameInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.searchLabel.dispose();
         this.searchLabel = null;
         this.searchResultLabel.dispose();
         this.searchResultLabel = null;
         this.searchNameInput.dispose();
         this.searchNameInput = null;
         this.searchButton.dispose();
         this.searchButton = null;
         this.searchResultList.dispose();
         this.searchResultList = null;
         this.joinButton.dispose();
         this.joinButton = null;
         this.bg = null;
         this._data = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.searchNameInput;
      }
      
      public function lockSearchButton(param1:Boolean) : void
      {
         this.searchButton.enabled = param1;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function tryJoin() : void
      {
         if(this.searchResultList.selectedIndex >= 0)
         {
            dispatchEvent(new ChannelsFormEvent(ChannelsFormEvent.JOIN,true,false,"","","",this.searchResultList.selectedIndex));
         }
      }
      
      private function dispatchSearchEv() : void
      {
         var _loc1_:String = null;
         _loc1_ = this.searchNameInput.text;
         this.searchResultList.selectedIndex = -1;
         this.searchButton.enabled = this.joinButton.enabled = false;
         dispatchEvent(new ChannelsFormEvent(ChannelsFormEvent.SEARCH_CHANNEL_CLICK,true,false,_loc1_));
      }
      
      private function handlePress(param1:uint) : void
      {
         this.dispatchSearchEv();
      }
      
      public function set searchResultText(param1:String) : void
      {
         this.searchResultLabel.text = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = null;
         if(param1.isDefaultPrevented())
         {
            return;
         }
         _loc2_ = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         if(_loc2_.navEquivalent == null && _loc2_.code == Keyboard.ENTER)
         {
            if(_loc2_.code == Keyboard.ENTER)
            {
               this.handlePress(_loc3_);
               param1.handled = true;
            }
         }
         else if(_loc2_.code != Keyboard.SPACE && _loc2_.navEquivalent == NavigationCode.ENTER && _loc2_.value == InputValue.KEY_DOWN)
         {
            this.handlePress(_loc3_);
            param1.handled = true;
         }
      }
      
      private function onSearchResultListIndexChangeHandler(param1:ListEvent = null) : void
      {
         this.joinButton.enabled = this.searchResultList.selectedIndex > -1;
      }
      
      private function onSearchResultListItemDoubleClickHandler(param1:ListEventEx) : void
      {
         this.tryJoin();
      }
      
      private function onJoinButtonClickHandler(param1:ButtonEvent) : void
      {
         this.tryJoin();
      }
      
      private function onSearchButtonClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchSearchEv();
      }
   }
}
