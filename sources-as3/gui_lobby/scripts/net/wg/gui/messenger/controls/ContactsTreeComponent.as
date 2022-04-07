package net.wg.gui.messenger.controls
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTACTS_ALIASES;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.advanced.SearchInput;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ContactsListGroupVO;
   import net.wg.gui.messenger.data.ContactsShared;
   import net.wg.gui.messenger.data.ContactsTreeDataProvider;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.gui.messenger.evnts.ContactsTreeEvent;
   import net.wg.gui.messenger.views.BaseContactView;
   import net.wg.gui.messenger.views.SearchContactView;
   import net.wg.infrastructure.base.meta.IContactsTreeComponentMeta;
   import net.wg.infrastructure.base.meta.impl.ContactsTreeComponentMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.MouseEventEx;
   
   public class ContactsTreeComponent extends ContactsTreeComponentMeta implements IContactsTreeComponentMeta, IFocusChainContainer, IFocusContainer
   {
      
      private static const LIST_HEIGHT_INV:String = "listHInv";
      
      public static const NORMAL_MODE:String = "normalMode";
      
      public static const INTERNAL_SEARCH_MODE:String = "internalSearchMode";
      
      public static const EXTERNAL_SEARCH_MODE:String = "externalSearchMode";
      
      private static const USER_PROPS:String = "userProps";
      
      private static const ID:String = "id";
       
      
      public var showUserNotes:Boolean = true;
      
      public var list:ContactScrollingList = null;
      
      public var searchInput:SearchInput = null;
      
      public var externalSearchButton:ISoundButtonEx = null;
      
      public var externalSearchCancelButton:ISoundButtonEx = null;
      
      public var infoView:InfoMessageView = null;
      
      public var bottomLip:MovieClip = null;
      
      public var hit:MovieClip = null;
      
      public var lipsUp:MovieClip = null;
      
      public var isAddingContactAllow:Boolean = true;
      
      public var scrollBar:ScrollBar = null;
      
      public var showResultLabel:Boolean = true;
      
      private var _mainTreeDataProvider:ContactsTreeDataProvider;
      
      private var _externalSearchView:SearchContactView = null;
      
      private var _listTopBound:Number = NaN;
      
      private var _currentMode:String = "normalMode";
      
      private var _treeSelectedItemVO:Object = null;
      
      private var _searchInputTooltip:String = null;
      
      private var _minSearchChars:uint = 0;
      
      public function ContactsTreeComponent()
      {
         this._mainTreeDataProvider = new ContactsTreeDataProvider();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.lipsUp.mouseChildren = this.lipsUp.mouseEnabled = false;
         this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.addEventListener(InputEvent.INPUT,this.onSearchInputInputHandler,false,0,true);
         this.searchInput.defaultText = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_SEARCHINPUTPROMPT);
         this.infoView.enabled = this.infoView.mouseChildren = false;
         this.list.useRightButton = true;
         this.list.useRightButtonForSelect = true;
         this.list.dataProvider = this._mainTreeDataProvider;
         this.list.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler,false,0,true);
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler,false,0,true);
         this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListItemDoubleClickHandler,false,0,true);
         this.list.setSelectionNavigator(new ContactsListSelectionNavigator());
         this.bottomLip.mouseEnabled = this.bottomLip.mouseChildren = false;
         this.bottomLip.visible = this.externalSearchCancelButton.visible = this.externalSearchButton.visible = false;
         this.externalSearchButton.label = MESSENGER.MESSENGER_CONTACTS_BUTTONS_EXTERNALSEARCH;
         this.externalSearchCancelButton.label = MESSENGER.MESSENGER_CONTACTS_BUTTONS_EXTERNALSEARCHCANCEL;
         this.externalSearchButton.tooltip = MESSENGER.CONTACTS_TOOLTIPS_BTNS_EXTERNALSEARCH;
         this.externalSearchButton.addEventListener(ButtonEvent.CLICK,this.onExternalSearchClickHandler);
         this.externalSearchCancelButton.addEventListener(ButtonEvent.CLICK,this.onExternalSearchCancelClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(isInvalid(InvalidationType.SIZE) || isInvalid(LIST_HEIGHT_INV))
         {
            _loc1_ = _height - ContactsShared.BOTTOM_CTRLS_PADDING - this.externalSearchCancelButton.height;
            this.externalSearchButton.y = this.externalSearchCancelButton.y = _loc1_;
            _loc1_ -= ContactsShared.CONTROLS_PADDING;
            if(isNaN(this._listTopBound))
            {
               _loc2_ = this.list.height;
            }
            else
            {
               _loc3_ = _loc1_ - this._listTopBound;
               _loc2_ = (_loc3_ / ContactsShared.CONTACT_RENDERER_HEIGHT >> 0) * ContactsShared.CONTACT_RENDERER_HEIGHT;
               this.list.height = _loc2_;
            }
            this.list.y = _loc1_ - _loc2_;
            this.lipsUp.y = this.list.y - (this.lipsUp.height >> 1) - ContactsShared.CONTROLS_PADDING;
            this.bottomLip.y = _loc1_ + (this.bottomLip.height >> 1);
            this.infoView.y = this.list.y + (_loc2_ - this.infoView.height >> 1) - ContactsShared.INFO_VIEW_PADDING;
            this.scrollBar.y = this.list.y;
            this.scrollBar.height = _loc2_ - (ContactsShared.SCROLL_LIST_GAP >> 1) + ContactsShared.SCROLL_LIST_GAP;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this._mainTreeDataProvider.cleanUp();
         this._mainTreeDataProvider = null;
         this.list.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler);
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler);
         this.list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListItemDoubleClickHandler);
         this.list.dispose();
         this.list = null;
         if(this._externalSearchView)
         {
            this._externalSearchView.removeEventListener(BaseContactView.ON_CANCEL_CLICKED,this.onExternalSearchViewCancelClickedHandler);
            this._externalSearchView.removeEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_CHANGED,this.onExternalSearchViewExtListChangedHandler);
            this._externalSearchView.removeEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_SELECTED_INDEX_CHANGED,this.onExternalSearchViewExtListSelIndChangedHandler);
            this._externalSearchView.removeEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_DOUBLE_CLICK,this.onExternalSearchViewExtListDoubleClickHandler);
            removeChild(this._externalSearchView);
            this._externalSearchView = null;
         }
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.removeEventListener(InputEvent.INPUT,this.onSearchInputInputHandler);
         this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.dispose();
         this.searchInput = null;
         this.externalSearchButton.removeEventListener(ButtonEvent.CLICK,this.onExternalSearchClickHandler);
         this.externalSearchButton.dispose();
         this.externalSearchButton = null;
         this.externalSearchCancelButton.removeEventListener(ButtonEvent.CLICK,this.onExternalSearchCancelClickHandler);
         this.externalSearchCancelButton.dispose();
         this.externalSearchCancelButton = null;
         this.infoView.dispose();
         this.infoView = null;
         this.bottomLip = null;
         this.hit = null;
         this.lipsUp = null;
         this._treeSelectedItemVO = null;
         super.onDispose();
      }
      
      public function as_getMainDP() : Object
      {
         return this._mainTreeDataProvider;
      }
      
      public function as_setInitData(param1:Object) : void
      {
         var _loc2_:uint = param1.accMaxChars;
         this._minSearchChars = param1.accMinChars;
         this.onSearchInputChangeHandler();
         this._searchInputTooltip = App.utils.locale.makeString(MESSENGER.CONTACTS_TOOLTIPS_SEARCHINPUT_CREDENTIALS,{"maxChars":_loc2_.toString()});
         this.searchInput.maxChars = _loc2_;
      }
      
      public function as_updateInfoMessage(param1:Boolean, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:Boolean = param2 != Values.EMPTY_STR && param3 != Values.EMPTY_STR;
         if(_loc5_)
         {
            this.infoView.showMessage(param2,param3,param4);
         }
         this.infoView.visible = _loc5_;
         this.list.visible = !_loc5_;
         this.searchInput.enabled = param1;
         if(this._currentMode != EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListChangeEvent();
         }
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         if(this._externalSearchView && this._externalSearchView.visible)
         {
            return this._externalSearchView.getComponentForFocus();
         }
         return this.list;
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         if(this.isInSearchMode())
         {
            if(this._externalSearchView && this._externalSearchView.visible)
            {
               return this._externalSearchView.getFocusChain();
            }
            return new <InteractiveObject>[InteractiveObject(this.searchInput),this.list,InteractiveObject(this.externalSearchButton),InteractiveObject(this.externalSearchCancelButton)];
         }
         return new <InteractiveObject>[InteractiveObject(this.searchInput),this.list];
      }
      
      public function getFoundContacts() : Array
      {
         var _loc1_:IDataProvider = null;
         if(this._externalSearchView)
         {
            _loc1_ = this._externalSearchView.list.dataProvider;
            return _loc1_.requestItemRange(0,_loc1_.length);
         }
         return null;
      }
      
      public function getMode() : String
      {
         return this._currentMode;
      }
      
      public function getTopLevelSelectedItem() : Object
      {
         var _loc1_:ContactScrollingList = null;
         var _loc2_:Object = null;
         if(this._currentMode != EXTERNAL_SEARCH_MODE)
         {
            _loc1_ = this.list;
            if(_loc1_.selectedIndex > -1)
            {
               return this._treeSelectedItemVO;
            }
         }
         else
         {
            _loc2_ = this._externalSearchView.list.dataProvider.requestItemAt(this._externalSearchView.list.selectedIndex);
            if(_loc2_)
            {
               return new ContactItemVO(_loc2_);
            }
         }
         return null;
      }
      
      public function getTopList() : ScrollingListEx
      {
         if(this._currentMode == EXTERNAL_SEARCH_MODE)
         {
            return this._externalSearchView.list;
         }
         return this.list;
      }
      
      public function isInSearchMode() : Boolean
      {
         return this._currentMode == INTERNAL_SEARCH_MODE || this._currentMode == EXTERNAL_SEARCH_MODE;
      }
      
      public function isTopLevelListHasContacts() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._currentMode == INTERNAL_SEARCH_MODE || this._currentMode == NORMAL_MODE)
         {
            return Boolean(hasDisplayingContactsS());
         }
         if(this._currentMode == EXTERNAL_SEARCH_MODE)
         {
            return this._externalSearchView.list.dataProvider.length > 0;
         }
         throw new Error("Unexpected tree component mode: " + this._currentMode);
      }
      
      public function resetSelected() : void
      {
         this.list.selectedIndex = -1;
         this._treeSelectedItemVO = null;
      }
      
      public function setListTopBound(param1:Number) : void
      {
         if(this._listTopBound != param1)
         {
            this._listTopBound = param1;
            invalidate(LIST_HEIGHT_INV);
         }
      }
      
      public function switchExternalSearchMode(param1:String = null) : void
      {
         if(!this._externalSearchView)
         {
            this._externalSearchView = App.utils.classFactory.getComponent(CONTACTS_ALIASES.FIND_CONTACT_VIEW_LINKAGE,SearchContactView);
            addChild(this._externalSearchView);
            this._externalSearchView.setSize(width,height);
            this._externalSearchView.addEventListener(BaseContactView.ON_CANCEL_CLICKED,this.onExternalSearchViewCancelClickedHandler,false,0,true);
            this._externalSearchView.addEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_CHANGED,this.onExternalSearchViewExtListChangedHandler,false,0,true);
            this._externalSearchView.addEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_SELECTED_INDEX_CHANGED,this.onExternalSearchViewExtListSelIndChangedHandler,false,0,true);
            this._externalSearchView.addEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_DOUBLE_CLICK,this.onExternalSearchViewExtListDoubleClickHandler,false,0,true);
            this._externalSearchView.showResultLabel(this.showResultLabel);
            this._externalSearchView.validateNow();
            registerFlashComponentS(this._externalSearchView,CONTACTS_ALIASES.FIND_CONTACT_VIEW_ALIAS);
         }
         this._externalSearchView.update(param1 != null ? param1 : ContactsShared.trim(this.searchInput.text));
         this._externalSearchView.isAddingContactAllow = this.isAddingContactAllow;
         this._externalSearchView.setLabel(MESSENGER.MESSENGER_CONTACTS_VIEW_SEARCHUSER_TITLE);
         this._externalSearchView.visible = true;
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         this.setMode(EXTERNAL_SEARCH_MODE);
         this.dispatchTopLevelListChangeEvent();
      }
      
      private function setMode(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:ContactsTreeEvent = null;
         if(this._currentMode != param1)
         {
            _loc2_ = this._currentMode;
            this._currentMode = param1;
            this.bottomLip.visible = this.externalSearchCancelButton.visible = this.externalSearchButton.visible = this.isInSearchMode();
            _loc3_ = new ContactsTreeEvent(ContactsTreeEvent.MODE_CHANGED);
            _loc3_.data = _loc2_;
            dispatchEvent(_loc3_);
         }
      }
      
      private function dispatchTopLevelListChangeEvent() : void
      {
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.TOP_LEVEL_LIST_CHANGED));
      }
      
      private function dispatchTopLevelListIndexChangeEvent() : void
      {
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.TOP_LEVEL_LIST_SELECTED_INDEX_CHANGED));
      }
      
      private function dispatchTopLevelListDClickEvent() : void
      {
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.TOP_LEVEL_LIST_DOUBLE_CLICK));
      }
      
      private function isTextValidForInternalSearch() : Boolean
      {
         return ContactsShared.searchTextValid(ContactsShared.trim(this.searchInput.text),this._minSearchChars);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         var _loc4_:DisplayObject = null;
         super.enabled = param1;
         var _loc2_:int = numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = getChildAt(_loc3_);
            if(_loc4_ is MovieClip)
            {
               MovieClip(_loc4_).enabled = param1;
            }
            _loc3_++;
         }
      }
      
      private function onSearchInputRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onSearchInputRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this._searchInputTooltip);
      }
      
      private function onSearchInputInputHandler(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ENTER && _loc2_.value == InputValue.KEY_DOWN)
         {
            if(this._currentMode == INTERNAL_SEARCH_MODE && this.isTextValidForInternalSearch())
            {
               this.switchExternalSearchMode();
            }
            param1.handled = true;
         }
         super.handleInput(param1);
      }
      
      private function onSearchInputChangeHandler(param1:Event = null) : void
      {
         searchLocalContactS(ContactsShared.trim(this.searchInput.text));
         this.setMode(!!this.isTextValidForInternalSearch() ? INTERNAL_SEARCH_MODE : NORMAL_MODE);
      }
      
      private function onExternalSearchClickHandler(param1:ButtonEvent) : void
      {
         this.switchExternalSearchMode();
      }
      
      private function onListIndexChangeHandler(param1:ListEvent) : void
      {
         if(this._currentMode != EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListIndexChangeEvent();
         }
      }
      
      private function onExternalSearchViewExtListSelIndChangedHandler(param1:ContactsTreeEvent) : void
      {
         if(this._currentMode == EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListIndexChangeEvent();
         }
      }
      
      private function onListItemDoubleClickHandler(param1:ListEvent) : void
      {
         if(this._currentMode != EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListDClickEvent();
         }
      }
      
      private function onExternalSearchViewExtListDoubleClickHandler(param1:ContactsTreeEvent) : void
      {
         if(this._currentMode == EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListDClickEvent();
         }
      }
      
      private function onExternalSearchViewExtListChangedHandler(param1:ContactsTreeEvent) : void
      {
         if(this._currentMode == EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListChangeEvent();
         }
      }
      
      private function onExternalSearchViewCancelClickedHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         this._externalSearchView.visible = false;
         this.onSearchInputChangeHandler();
         this.setMode(!!this.isTextValidForInternalSearch() ? INTERNAL_SEARCH_MODE : NORMAL_MODE);
         this.dispatchTopLevelListChangeEvent();
      }
      
      private function onExternalSearchCancelClickHandler(param1:ButtonEvent) : void
      {
         this.searchInput.text = Values.EMPTY_STR;
         searchLocalContactS(Values.EMPTY_STR);
         this.onSearchInputChangeHandler();
      }
      
      private function onListItemClickHandler(param1:ListEvent) : void
      {
         var _loc5_:ContactsListGroupVO = null;
         var _loc6_:ContactItem = null;
         var _loc7_:ContactsListGroupVO = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:ContactsListGroupVO = null;
         var _loc2_:Boolean = param1.buttonIdx == MouseEventEx.RIGHT_BUTTON;
         var _loc3_:ITreeItemInfo = ITreeItemInfo(param1.itemData);
         var _loc4_:ContactsTreeItemRenderer = ContactsTreeItemRenderer(param1.itemRenderer);
         this._treeSelectedItemVO = null;
         if(_loc3_.isBrunch && _loc3_.parent != null)
         {
            if(!_loc2_)
            {
               _loc5_ = new ContactsListGroupVO(_loc3_.data);
               onGroupSelectedS(int(_loc3_.parent.id),{
                  "groupName":_loc5_.headerTitle,
                  "currentOpened":_loc5_.isOpened
               });
               _loc5_.dispose();
            }
            this._treeSelectedItemVO = _loc3_;
         }
         else
         {
            _loc6_ = _loc4_.getCurrentContentItem() as ContactItem;
            if(_loc6_)
            {
               this._treeSelectedItemVO = ContactItemVO(_loc6_.data);
            }
         }
         if(this._currentMode != EXTERNAL_SEARCH_MODE)
         {
            this.dispatchTopLevelListIndexChangeEvent();
         }
         if(_loc2_)
         {
            if(_loc3_.isBrunch)
            {
               if(_loc3_.parent != null)
               {
                  _loc7_ = ContactsListGroupVO(ContactGroupItem(_loc4_.getCurrentContentItem()).getData());
                  if(_loc7_.canBeManaged)
                  {
                     App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CONTACTS_GROUP,this,{"targetGroupName":_loc7_.headerTitle});
                  }
               }
            }
            else if(_loc3_.gui[ID] != null)
            {
               _loc8_ = _loc3_.data;
               if(_loc8_.hasOwnProperty(USER_PROPS))
               {
                  _loc9_ = {
                     "dbID":_loc8_.dbID,
                     "userName":_loc8_.userProps.userName,
                     "targetGroupName":Values.EMPTY_STR,
                     "showUserNotes":this.showUserNotes,
                     "noteText":_loc8_.note
                  };
                  if(_loc3_.parent && _loc3_.parent.parent && _loc3_.parent.data)
                  {
                     _loc10_ = new ContactsListGroupVO(_loc3_.parent.data);
                     if(_loc10_.canBeManaged)
                     {
                        _loc9_.targetGroupName = _loc3_.parent.data.headerTitle;
                     }
                     _loc10_.dispose();
                  }
                  App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PLAYER_CONTACTS,this,_loc9_);
               }
            }
         }
      }
   }
}
