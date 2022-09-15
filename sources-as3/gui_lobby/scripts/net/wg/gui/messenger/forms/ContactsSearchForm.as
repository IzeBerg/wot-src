package net.wg.gui.messenger.forms
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import net.wg.gui.messenger.meta.IContactsListPopoverMeta;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   import scaleform.gfx.MouseEventEx;
   
   public class ContactsSearchForm extends UIComponentEx implements IViewStackContent
   {
       
      
      public var titleLabel:LabelControl;
      
      public var resultsLabel:LabelControl;
      
      public var searchButton:SoundButtonEx;
      
      public var addToFriendsButton:SoundButtonEx;
      
      public var addToIgnoredButton:SoundButtonEx;
      
      public var textInput:TextInput;
      
      public var list:ScrollingListEx;
      
      public function ContactsSearchForm()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.searchButton.removeEventListener(ButtonEvent.CLICK,this.onSearchButtonClickHandler);
         this.addToFriendsButton.removeEventListener(ButtonEvent.CLICK,this.onAddToFriendsClickHandler);
         this.addToIgnoredButton.removeEventListener(ButtonEvent.CLICK,this.onAddToIgnoredClickHandler);
         this.list.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler);
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler);
         this.textInput.removeEventListener(InputEvent.INPUT,this.handleInput);
         if(this.list.dataProvider && this.list.dataProvider.hasEventListener(Event.CHANGE))
         {
            this.list.dataProvider.removeEventListener(Event.CHANGE,this.onListIndexChangeHandler);
            this.list.dataProvider.cleanUp();
            this.list.dataProvider = null;
         }
         this.titleLabel.dispose();
         this.titleLabel = null;
         this.resultsLabel.dispose();
         this.resultsLabel = null;
         this.searchButton.dispose();
         this.searchButton = null;
         this.searchButton.dispose();
         this.searchButton = null;
         this.addToFriendsButton.dispose();
         this.addToFriendsButton = null;
         this.addToIgnoredButton.dispose();
         this.addToIgnoredButton = null;
         this.textInput.dispose();
         this.textInput = null;
         this.list.dispose();
         this.list = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("titleLabel",this.titleLabel,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("textInput",this.textInput,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("searchButton",this.searchButton,Constraints.RIGHT);
         constraints.addElement("resultsLabel",this.resultsLabel,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("list",this.list,Constraints.ALL);
         constraints.addElement("addToFriendsButton",this.addToFriendsButton,Constraints.BOTTOM | Constraints.LEFT);
         constraints.addElement("addToIgnoredButton",this.addToIgnoredButton,Constraints.BOTTOM | Constraints.LEFT);
         this.textInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.searchButton.addEventListener(ButtonEvent.CLICK,this.onSearchButtonClickHandler);
         this.addToFriendsButton.addEventListener(ButtonEvent.CLICK,this.onAddToFriendsClickHandler);
         this.addToIgnoredButton.addEventListener(ButtonEvent.CLICK,this.onAddToIgnoredClickHandler);
         this.list.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler);
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler);
         this.list.sbPadding = new Padding(-1,-1,-1,-1);
         this.list.smartScrollBar = true;
         this.addToFriendsButton.enabled = false;
         this.addToIgnoredButton.enabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.textInput;
      }
      
      public function getSelectedItem() : Object
      {
         return this.list.dataProvider.requestItemAt(this.list.selectedIndex);
      }
      
      public function update(param1:Object) : void
      {
         if(param1)
         {
            this.list.dataProvider = param1.searchDP;
            this.list.dataProvider.addEventListener(Event.CHANGE,this.onListIndexChangeHandler);
            this.resultsLabel.text = param1.resultText;
            this.searchButton.enabled = !param1.freezeSearch;
         }
      }
      
      private function generateEvent(param1:String) : ContactsFormEvent
      {
         var _loc2_:Object = this.getSelectedItem();
         var _loc3_:ContactsFormEvent = new ContactsFormEvent(param1,true,false,this.textInput.text);
         if(_loc2_)
         {
            _loc3_.dbID = _loc2_.dbID;
            _loc3_.name = _loc2_.userName;
         }
         return _loc3_;
      }
      
      private function getParent() : IContactsListPopoverMeta
      {
         return IContactsListPopoverMeta(parent.parent.parent);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:Number = param1.details.code;
         if(param1.details.value == InputValue.KEY_UP)
         {
            switch(_loc2_)
            {
               case Keyboard.ENTER:
                  param1.handled = true;
                  dispatchEvent(this.generateEvent(ContactsFormEvent.SEARCH));
                  param1.handled = true;
            }
         }
      }
      
      private function onListIndexChangeHandler(param1:Event = null) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc2_:Object = this.getSelectedItem();
         if(_loc2_)
         {
            _loc3_ = this.getParent().isEnabledInRoamingS(_loc2_.dbID);
            _loc4_ = !!_loc2_.hasOwnProperty("tags") ? _loc2_.tags : [];
            if(UserTags.isCurrentPlayer(_loc4_))
            {
               this.addToFriendsButton.enabled = this.addToIgnoredButton.enabled = false;
            }
            else
            {
               this.addToFriendsButton.enabled = !!_loc3_ ? Boolean(!UserTags.isFriend(_loc4_)) : Boolean(false);
               this.addToIgnoredButton.enabled = !!_loc3_ ? Boolean(!UserTags.isIgnored(_loc4_)) : Boolean(false);
            }
         }
         else
         {
            this.addToFriendsButton.enabled = false;
            this.addToIgnoredButton.enabled = false;
         }
      }
      
      private function onListItemClickHandler(param1:ListEventEx) : void
      {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,param1.itemData);
         }
      }
      
      private function onSearchButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(this.generateEvent(ContactsFormEvent.SEARCH));
      }
      
      private function onAddToFriendsClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(this.generateEvent(ContactsFormEvent.ADD_TO_FRIENDS));
      }
      
      private function onAddToIgnoredClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(this.generateEvent(ContactsFormEvent.ADD_TO_IGNORED));
      }
   }
}
