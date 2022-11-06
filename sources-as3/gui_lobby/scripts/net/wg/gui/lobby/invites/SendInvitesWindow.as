package net.wg.gui.lobby.invites
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTACTS_ALIASES;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.advanced.SearchInput;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.invites.controls.CandidatesList;
   import net.wg.gui.lobby.invites.controls.SearchListDragController;
   import net.wg.gui.lobby.invites.controls.TreeDragController;
   import net.wg.gui.messenger.controls.ContactsTreeComponent;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ContactsShared;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.gui.messenger.evnts.ContactsScrollingListEvent;
   import net.wg.gui.messenger.evnts.ContactsTreeEvent;
   import net.wg.infrastructure.base.meta.ISendInvitesWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SendInvitesWindowMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.FocusHandlerEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.MouseEventEx;
   
   public class SendInvitesWindow extends SendInvitesWindowMeta implements ISendInvitesWindowMeta
   {
      
      private static const UPDATE_DEFAULT_POSITION:String = "updateWindowPosition";
      
      private static const ADD_BTN_ENABLING_INV:String = "addBtnEnablingInv";
      
      private static const ADD_ALL_BTN_ENABLING_INV:String = "addAllBtnEnablingInv";
      
      private static const REMOVE_BTN_ENABLING_INV:String = "removeBtnEnablingInv";
      
      private static const CHECK_CANDIDATES_LIST_INV:String = "checkCandidatesListInv";
      
      private static const FOCUS_INVALID:String = "fcInv";
      
      private static const FOCUS_CHAIN_INVALID:String = "fchainInv";
      
      private static const TREE_HEIGHT:uint = 458;
      
      private static const DB_ID:String = "dbID";
      
      private static const USER_PROPS:String = "userProps";
      
      private static const COLOR:String = "color";
       
      
      public var addUserButton:IButtonIconLoader = null;
      
      public var addAllUsersButton:IButtonIconLoader = null;
      
      public var removeUserButton:IButtonIconLoader = null;
      
      public var removeAllUsersButton:IButtonIconLoader = null;
      
      public var receiverList:CandidatesList = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var onlineCheckBox:CheckBox = null;
      
      public var messageTextInput:TextInput = null;
      
      public var sendButton:ISoundButtonEx = null;
      
      public var cancelButton:ISoundButtonEx = null;
      
      public var externalSearchButton:ISoundButtonEx = null;
      
      public var bottomTreeLip:MovieClip = null;
      
      public var treeComponent:ContactsTreeComponent = null;
      
      public var vSeparatorRight:MovieClip = null;
      
      private var _receiverData:DataProvider;
      
      private var _isUnderCoolDown:Boolean = false;
      
      private var _pendingUpdatingContacts:Object;
      
      private var _focusInited:Boolean = false;
      
      private var _focusChain:Vector.<InteractiveObject> = null;
      
      private var _sendInviteTooltip:String = "";
      
      private var _dragController:DropListDelegateCtrlr = null;
      
      private var _invalidUserTags:Vector.<String> = null;
      
      private var _createdContactItems:Vector.<IDisposable> = null;
      
      private var _isMassSendEnabled:Boolean = true;
      
      public function SendInvitesWindow()
      {
         this._receiverData = new DataProvider();
         this._pendingUpdatingContacts = {};
         super();
         this._invalidUserTags = new <String>[UserTags.IGNORED,UserTags.IGNORED_TMP,UserTags.CURRENT];
         this._createdContactItems = new Vector.<IDisposable>(0);
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         window.useBottomBtns = true;
      }
      
      override protected function onPopulate() : void
      {
         this.updateWindowProperties(false);
         super.onPopulate();
         window.title = Values.EMPTY_STR;
         this.addAllUsersButton.tooltip = MESSENGER.PREBATTLE_ADDALLBTN_TOOLTIP;
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:ContactItemVO = null;
         var _loc9_:Object = null;
         var _loc10_:ContactItemVO = null;
         var _loc11_:Vector.<InteractiveObject> = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         super.draw();
         if(isInvalid(UPDATE_DEFAULT_POSITION))
         {
            window.x = 0;
            window.y = 0;
         }
         if(isInvalid(ADD_BTN_ENABLING_INV))
         {
            this.checkAddButtonEnabling();
         }
         var _loc1_:Boolean = isInvalid(ADD_ALL_BTN_ENABLING_INV);
         if(_loc1_)
         {
            this.addAllUsersButton.enabled = this._isMassSendEnabled && this.treeComponent.isTopLevelListHasContacts() && !this._isUnderCoolDown;
         }
         var _loc2_:Boolean = isInvalid(REMOVE_BTN_ENABLING_INV);
         if(_loc2_)
         {
            _loc3_ = this.isInvitationCanBeSent();
            this.removeUserButton.enabled = _loc3_ && this.receiverList.selectedIndex != -1;
            this.removeAllUsersButton.enabled = _loc3_;
            this.sendButton.enabled = _loc3_;
         }
         if(isInvalid(CHECK_CANDIDATES_LIST_INV))
         {
            for(_loc4_ in this._pendingUpdatingContacts)
            {
               _loc5_ = false;
               _loc6_ = this._receiverData.length;
               _loc7_ = _loc6_ - 1;
               while(_loc7_ >= 0)
               {
                  _loc8_ = ContactItemVO(this._receiverData.requestItemAt(_loc7_));
                  _loc9_ = this._pendingUpdatingContacts[_loc4_];
                  if(_loc8_ && _loc8_.dbID == _loc9_.dbID)
                  {
                     _loc10_ = new ContactItemVO(_loc9_);
                     if(UserTags.isIgnored(_loc10_.userPropsVO.tags) || UserTags.isCurrentPlayer(_loc10_.userPropsVO.tags))
                     {
                        this._receiverData.splice(_loc7_,1);
                        _loc10_.dispose();
                     }
                     else
                     {
                        this._receiverData[_loc7_] = _loc10_;
                        this._createdContactItems.push(_loc10_);
                     }
                     _loc5_ = true;
                     break;
                  }
                  _loc7_--;
               }
               if(_loc5_)
               {
                  this._receiverData.invalidate();
               }
            }
            App.utils.data.cleanupDynamicObject(this._pendingUpdatingContacts);
         }
         if(isInvalid(FOCUS_INVALID))
         {
            if(this._focusInited)
            {
               setFocus(this.treeComponent.getComponentForFocus());
            }
            this._focusInited = true;
            invalidate(FOCUS_CHAIN_INVALID);
         }
         if(isInvalid(FOCUS_CHAIN_INVALID) || _loc2_ || _loc1_)
         {
            _loc11_ = this.treeComponent.getFocusChain();
            if(this.treeComponent.getMode() != ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
            {
               _loc12_ = _loc11_.length;
               _loc13_ = 0;
               while(_loc13_ < _loc12_)
               {
                  if(_loc11_[_loc13_] is SearchInput)
                  {
                     break;
                  }
                  _loc13_++;
               }
               _loc11_.splice(_loc13_ + 1,0,this.onlineCheckBox);
               if(this.treeComponent.getMode() == ContactsTreeComponent.NORMAL_MODE)
               {
                  _loc14_ = _loc11_.indexOf(this.treeComponent.list);
                  if(_loc14_ != -1)
                  {
                     _loc11_.splice(_loc14_ + 1,0,this.externalSearchButton);
                  }
               }
            }
            _loc11_ = _loc11_.concat(new <InteractiveObject>[InteractiveObject(this.addAllUsersButton),InteractiveObject(this.addUserButton),InteractiveObject(this.removeUserButton),InteractiveObject(this.removeAllUsersButton),this.receiverList,this.messageTextInput,InteractiveObject(this.sendButton),InteractiveObject(this.cancelButton)]);
            this.cleanupFocusChain();
            this._focusChain = _loc11_;
            App.utils.commons.initTabIndex(this._focusChain);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         registerFlashComponentS(this.treeComponent,CONTACTS_ALIASES.CONTACTS_TREE);
         this.treeComponent.isAddingContactAllow = false;
         this.treeComponent.showResultLabel = false;
         this.treeComponent.height = TREE_HEIGHT;
         this.treeComponent.setListTopBound(this.onlineCheckBox.y + this.onlineCheckBox.height + ContactsShared.CONTROLS_PADDING);
         this.treeComponent.addChild(this.onlineCheckBox);
         this.treeComponent.showUserNotes = false;
         this.treeComponent.addEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_SELECTED_INDEX_CHANGED,this.onTreeComponentTopLevelListSelectedIndexChangedHandler,false,0,true);
         this.treeComponent.addEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_DOUBLE_CLICK,this.onTreeComponentTopLevelListDoubleClickHandler,false,0,true);
         this.treeComponent.addEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_VALID_CHANGED,this.onTreeComponentExternalSearchValidChangedHandler);
         this.treeComponent.addEventListener(ContactsScrollingListEvent.DATA_POPULATED,this.onTreeComponentDataPopulatedHandler);
         this.createNewTreeController();
         this.treeComponent.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onTreeComponentRequestFocusHandler);
         this.treeComponent.addEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_CHANGED,this.onTreeComponentTopLevelListChangedHandler);
         this.treeComponent.addEventListener(ContactsTreeEvent.MODE_CHANGED,this.onTreeComponentModeChangedHandler,false,0,true);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.label = MENU.PREBATTLE_INVITATIONS_BUTTONS_CANCEL;
         this.sendButton.label = MENU.PREBATTLE_INVITATIONS_BUTTONS_SEND;
         this.addAllUsersButton.addEventListener(ButtonEvent.CLICK,this.onAddAllUsersButtonClickHandler);
         this.addUserButton.addEventListener(ButtonEvent.CLICK,this.onAddUserButtonClickHandler);
         this.removeUserButton.addEventListener(ButtonEvent.CLICK,this.onRemoveUserButtonClickHandler);
         this.removeAllUsersButton.addEventListener(ButtonEvent.CLICK,this.onRemoveAllUsersButtonClickHandler);
         this.addUserButton.tooltip = MESSENGER.PREBATTLE_ADDBTN_TOOLTIP;
         this.removeUserButton.tooltip = MESSENGER.PREBATTLE_REMOVEBTN_TOOLTIP;
         this.removeAllUsersButton.tooltip = MESSENGER.PREBATTLE_REMOVEALLBTN_TOOLTIP;
         this.onlineCheckBox.addEventListener(ButtonEvent.CLICK,this.onOnlineCheckBoxClickHandler);
         this.onlineCheckBox.toolTip = TOOLTIPS.PREBATTLE_INVITATIONS_TOOLTIP_ISONLINE;
         this.messageTextInput.defaultTextFormat.color = ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR;
         this.messageTextInput.textField.textColor = ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR;
         this.messageTextInput.defaultTextFormat.italic = false;
         this.messageTextInput.textField.multiline = true;
         this.messageTextInput.textField.wordWrap = true;
         var _loc1_:int = 100;
         this.messageTextInput.maxChars = _loc1_;
         this._sendInviteTooltip = App.utils.locale.makeString(MENU.PREBATTLE_INVITATIONS_LABELS_DEFAULTINVITETEXT_TOOLTIP,{"maxChars":_loc1_.toString()});
         this.messageTextInput.addEventListener(MouseEvent.ROLL_OVER,this.onMessageTextInputRollOverHandler);
         this.messageTextInput.addEventListener(MouseEvent.ROLL_OUT,this.onMessageTextInputRollOutHandler);
         this.messageTextInput.maxChars = _loc1_;
         this.messageTextInput.addEventListener(FocusHandlerEvent.FOCUS_IN,this.onMessageTextInputFocusInHandler);
         this.messageTextInput.defaultText = MENU.PREBATTLE_INVITATIONS_LABELS_DEFAULTINVITETEXT;
         this.sendButton.addEventListener(ButtonEvent.CLICK,this.onSendButtonClickHandler);
         this.receiverList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onReceiverListItemDoubleClickHandler);
         this.receiverList.addEventListener(ListEventEx.ITEM_CLICK,this.onReceiverListItemClickHandler);
         this.receiverList.addEventListener(ListEventEx.INDEX_CHANGE,this.onReceiverListIndexChangeHandler);
         this.receiverList.dataProvider = this._receiverData;
         this.receiverList.useRightButtonForSelect = true;
         this.receiverList.useRightButton = true;
         this._receiverData.addEventListener(Event.CHANGE,this.onReceiverDataChangeHandler);
         App.utils.scheduler.scheduleOnNextFrame(this.updateFocus);
         this.addAllUsersButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_RIGHT_DOUBLE;
         this.addUserButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_RIGHT;
         this.removeUserButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_LEFT;
         this.removeAllUsersButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_ARROW_FORMATION_LEFT_DOUBLE;
         var _loc2_:uint = this.addUserButton.height;
         var _loc3_:uint = 10;
         var _loc4_:uint = 32;
         this.addAllUsersButton.y = this.vSeparatorRight.height - ((_loc2_ >> 2) + (_loc3_ >> 1) + _loc4_) >> 1;
         this.addUserButton.y = this.addAllUsersButton.y + _loc2_ + _loc3_;
         this.removeUserButton.y = this.addUserButton.y + _loc2_ + _loc4_;
         this.removeAllUsersButton.y = this.removeUserButton.y + _loc2_ + _loc3_;
         var _loc5_:uint = TREE_HEIGHT - ContactsShared.BOTTOM_CTRLS_PADDING - this.externalSearchButton.height;
         this.externalSearchButton.addEventListener(ButtonEvent.CLICK,this.onExternalSearchButtonClickHandler,false,0,true);
         this.externalSearchButton.y = _loc5_;
         this.externalSearchButton.x = this.treeComponent.x + this.treeComponent.width - this.externalSearchButton.width >> 1;
         this.externalSearchButton.label = MESSENGER.MESSENGER_CONTACTS_BUTTONS_EXTERNALSEARCH;
         this.externalSearchButton.tooltip = MESSENGER.CONTACTS_TOOLTIPS_BTNS_EXTERNALSEARCH;
         this.bottomTreeLip.mouseEnabled = this.bottomTreeLip.mouseChildren = false;
         this.bottomTreeLip.y = _loc5_ + (this.bottomTreeLip.height >> 1) - ContactsShared.CONTROLS_PADDING;
         this.checkExternalSearchControlsEnabling();
         invalidate(UPDATE_DEFAULT_POSITION);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         this.updateFocus();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.onEndSendInvitesCooldown);
         this._invalidUserTags = null;
         this.disposeDragController();
         this.externalSearchButton.removeEventListener(ButtonEvent.CLICK,this.onExternalSearchButtonClickHandler);
         this.treeComponent.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onTreeComponentRequestFocusHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.MODE_CHANGED,this.onTreeComponentModeChangedHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_SELECTED_INDEX_CHANGED,this.onTreeComponentTopLevelListSelectedIndexChangedHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_DOUBLE_CLICK,this.onTreeComponentTopLevelListDoubleClickHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.EXTERNAL_SEARCH_VALID_CHANGED,this.onTreeComponentExternalSearchValidChangedHandler);
         this.treeComponent.removeEventListener(ContactsScrollingListEvent.DATA_POPULATED,this.onTreeComponentDataPopulatedHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.TOP_LEVEL_LIST_CHANGED,this.onTreeComponentTopLevelListChangedHandler);
         this.treeComponent = null;
         this._receiverData.removeEventListener(Event.CHANGE,this.onReceiverDataChangeHandler);
         this.onlineCheckBox.removeEventListener(ButtonEvent.CLICK,this.onOnlineCheckBoxClickHandler);
         if(!this.onlineCheckBox.isDisposed())
         {
            this.onlineCheckBox.dispose();
         }
         this.onlineCheckBox = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         App.utils.scheduler.cancelTask(this.updateFocus);
         this.sendButton.removeEventListener(ButtonEvent.CLICK,this.onSendButtonClickHandler);
         this.receiverList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onReceiverListItemDoubleClickHandler);
         this.receiverList.removeEventListener(ListEventEx.ITEM_CLICK,this.onReceiverListItemClickHandler);
         this.receiverList.removeEventListener(ListEventEx.INDEX_CHANGE,this.onReceiverListIndexChangeHandler);
         this.messageTextInput.removeEventListener(MouseEvent.ROLL_OVER,this.onMessageTextInputRollOverHandler);
         this.messageTextInput.removeEventListener(MouseEvent.ROLL_OUT,this.onMessageTextInputRollOutHandler);
         this.messageTextInput.removeEventListener(FocusHandlerEvent.FOCUS_IN,this.onMessageTextInputFocusInHandler);
         this.addAllUsersButton.removeEventListener(ButtonEvent.CLICK,this.onAddAllUsersButtonClickHandler);
         this.addUserButton.removeEventListener(ButtonEvent.CLICK,this.onAddUserButtonClickHandler);
         this.removeUserButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveUserButtonClickHandler);
         this.removeAllUsersButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveAllUsersButtonClickHandler);
         this.receiverList.dispose();
         this.receiverList = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this._receiverData.cleanUp();
         this._receiverData = null;
         this.addUserButton.dispose();
         this.addUserButton = null;
         this.addAllUsersButton.dispose();
         this.addAllUsersButton = null;
         this.removeUserButton.dispose();
         this.removeUserButton = null;
         this.removeAllUsersButton.dispose();
         this.removeAllUsersButton = null;
         this.messageTextInput.dispose();
         this.messageTextInput = null;
         this.sendButton.dispose();
         this.sendButton = null;
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.externalSearchButton.dispose();
         this.externalSearchButton = null;
         this.bottomTreeLip = null;
         this.vSeparatorRight = null;
         this.clearCreatedContactItems();
         this._pendingUpdatingContacts = App.utils.data.cleanupDynamicObject(this._pendingUpdatingContacts);
         this._pendingUpdatingContacts = null;
         this.cleanupFocusChain();
         super.onDispose();
      }
      
      override protected function setInvalidUserTags(param1:Vector.<String>) : void
      {
         this._invalidUserTags = param1;
      }
      
      public function as_enableDescription(param1:Boolean) : void
      {
         this.messageTextInput.enabled = param1;
      }
      
      public function as_enableMassSend(param1:Boolean, param2:String) : void
      {
         this._isMassSendEnabled = param1;
         this.addAllUsersButton.tooltip = param2;
         this.addAllUsersButton.mouseEnabledOnDisabled = !this._isMassSendEnabled;
         invalidate(ADD_ALL_BTN_ENABLING_INV);
      }
      
      public function as_onContactUpdated(param1:Object) : void
      {
         var _loc2_:Number = param1.dbID;
         this._pendingUpdatingContacts[_loc2_] = param1;
         invalidate(CHECK_CANDIDATES_LIST_INV);
      }
      
      public function as_onListStateChanged(param1:Boolean) : void
      {
         this.onlineCheckBox.enabled = !param1;
      }
      
      public function as_onReceiveSendInvitesCooldown(param1:uint) : void
      {
         this._isUnderCoolDown = true;
         App.utils.scheduler.scheduleTask(this.onEndSendInvitesCooldown,param1 * 1000);
         this.invalidateAddBtnEnabling();
         this.invalidateMngmntBtnEnabling();
         this.invalidateAddAllBtnEnabling();
         this.treeComponent.enabled = false;
         this.receiverList.enabled = false;
      }
      
      public function as_setDefaultOnlineFlag(param1:Boolean) : void
      {
         this.onlineCheckBox.selected = param1;
      }
      
      public function as_setWindowTitle(param1:String) : void
      {
         window.title = param1;
      }
      
      private function clearCreatedContactItems() : void
      {
         var _loc1_:IDisposable = null;
         if(this._createdContactItems != null)
         {
            for each(_loc1_ in this._createdContactItems)
            {
               _loc1_.dispose();
            }
            this._createdContactItems.splice(0,this._createdContactItems.length);
            this._createdContactItems = null;
         }
      }
      
      private function isUserValid(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in this._invalidUserTags)
         {
            if(param1.indexOf(_loc2_) != -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function createNewTreeController() : void
      {
         this._dragController = new TreeDragController(this.onReceiverEndDropHandler,new <InteractiveObject>[this.treeComponent.list,this.receiverList],Linkages.CONTACTS_TREE_ITEM_RENDERER);
      }
      
      private function disposeDragController() : void
      {
         if(this._dragController)
         {
            this._dragController.dispose();
            this._dragController = null;
         }
      }
      
      private function isInvitationCanBeSent() : Boolean
      {
         return !this._isUnderCoolDown && this._receiverData.length > 0;
      }
      
      private function checkExternalSearchControlsEnabling() : void
      {
         this.bottomTreeLip.visible = this.externalSearchButton.visible = this.treeComponent.getMode() == ContactsTreeComponent.NORMAL_MODE;
      }
      
      private function updateWindowProperties(param1:Boolean) : void
      {
         if(window)
         {
            Window(window).visible = param1;
         }
      }
      
      private function updateFocus() : void
      {
         this.updateWindowProperties(true);
      }
      
      private function onEndSendInvitesCooldown() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         this._receiverData.cleanUp();
         this._receiverData.invalidate();
         App.utils.scheduler.cancelTask(this.onEndSendInvitesCooldown);
         this._isUnderCoolDown = false;
         this.invalidateAddBtnEnabling();
         this.invalidateMngmntBtnEnabling();
         this.invalidateAddAllBtnEnabling();
         this.treeComponent.enabled = true;
         this.receiverList.enabled = true;
      }
      
      private function hasUserInReceiverList(param1:Number) : Boolean
      {
         var _loc2_:uint = this._receiverData.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            if(ContactItemVO(this._receiverData[_loc3_]).dbID == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function removeReceiveItem() : void
      {
         if(this._receiverData.length > 0)
         {
            if(this.receiverList.selectedIndex > -1)
            {
               this._receiverData.splice(this.receiverList.selectedIndex,1);
               this._receiverData.invalidate();
            }
            else
            {
               showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOREMOVE);
            }
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
         }
      }
      
      private function cleanupFocusChain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._focusChain)
         {
            _loc1_ = this._focusChain.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._focusChain[_loc2_].tabIndex = -1;
               _loc2_++;
            }
            this._focusChain.splice(0,this._focusChain.length);
            this._focusChain = null;
         }
      }
      
      private function addTopLevelSelectedVOToReceivingList() : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:ContactItemVO = null;
         var _loc1_:Object = this.treeComponent.getTopLevelSelectedItem();
         if(_loc1_ is ContactItemVO)
         {
            this.addContactVOToReceivingList(ContactItemVO(_loc1_));
         }
         else if(_loc1_ is ITreeItemInfo)
         {
            _loc2_ = ITreeItemInfo(_loc1_).children;
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = new ContactItemVO(_loc3_.data);
               this._createdContactItems.push(_loc4_);
               this.addContactVOToReceivingList(_loc4_,false);
            }
         }
         else
         {
            DebugUtils.LOG_ERROR("Attempt to add item to candidates list. Unexpected item: " + _loc1_);
         }
      }
      
      private function addContactVOToReceivingList(param1:ContactItemVO, param2:Boolean = true) : void
      {
         if(this.isUserValid(param1.userPropsVO.tags))
         {
            if(this.hasUserInReceiverList(param1.dbID))
            {
               if(param2)
               {
                  showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_EXISTSINRECEIVELIST);
               }
            }
            else
            {
               this._receiverData.push(param1);
               this._receiverData.invalidate();
            }
         }
      }
      
      private function onReceiverEndDropHandler(param1:Object, param2:Object) : void
      {
         if(param1 == this.receiverList)
         {
            this.addContactVOToReceivingList(ContactItemVO(param2));
         }
      }
      
      private function invalidateAddBtnEnabling() : void
      {
         invalidate(ADD_BTN_ENABLING_INV);
      }
      
      override public function get height() : Number
      {
         return this.sendButton.y + this.sendButton.height;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ENTER && this.isInvitationCanBeSent() && _loc2_.value == InputValue.KEY_DOWN)
         {
            this.onSendButtonClickHandler();
            param1.handled = true;
         }
      }
      
      private function onCancelButtonClickHandler(param1:Event) : void
      {
         onWindowCloseS();
      }
      
      private function onTreeComponentTopLevelListChangedHandler(param1:ContactsTreeEvent) : void
      {
         this.invalidateAddAllBtnEnabling();
         this.invalidateAddBtnEnabling();
      }
      
      private function onMessageTextInputRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onMessageTextInputRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this._sendInviteTooltip);
      }
      
      private function onTreeComponentExternalSearchValidChangedHandler(param1:ContactsTreeEvent) : void
      {
         invalidate(FOCUS_CHAIN_INVALID);
      }
      
      private function onTreeComponentTopLevelListDoubleClickHandler(param1:ContactsTreeEvent) : void
      {
         this.addTopLevelSelectedVOToReceivingList();
      }
      
      private function onAddUserButtonClickHandler(param1:ButtonEvent = null) : void
      {
         this.addTopLevelSelectedVOToReceivingList();
      }
      
      private function checkAddButtonEnabling(param1:Event = null) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Boolean = !this._isUnderCoolDown && this.treeComponent.isTopLevelListHasContacts();
         if(_loc2_)
         {
            _loc3_ = this.treeComponent.getTopLevelSelectedItem();
            if(_loc3_)
            {
               if(_loc3_ is ContactItemVO)
               {
                  _loc2_ = this.isUserValid(ContactItemVO(_loc3_).userPropsVO.tags);
               }
               else if(_loc3_ is ITreeItemInfo)
               {
                  _loc2_ = ITreeItemInfo(_loc3_).children.length > 0;
               }
            }
            else
            {
               _loc2_ = false;
            }
         }
         this.addUserButton.enabled = _loc2_;
      }
      
      private function onExternalSearchButtonClickHandler(param1:ButtonEvent) : void
      {
         this.treeComponent.switchExternalSearchMode(Values.EMPTY_STR);
      }
      
      private function onTreeComponentModeChangedHandler(param1:ContactsTreeEvent) : void
      {
         this.invalidateAddBtnEnabling();
         invalidate(REMOVE_BTN_ENABLING_INV);
         this.checkExternalSearchControlsEnabling();
         if(this.treeComponent.getMode() == ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
         {
            invalidate(FOCUS_INVALID);
            if(!(this._dragController is SearchListDragController))
            {
               this.disposeDragController();
            }
            if(this._dragController == null)
            {
               this._dragController = new SearchListDragController(this.onReceiverEndDropHandler,new <InteractiveObject>[this.treeComponent.getTopList(),this.receiverList],Linkages.CONTACT_LIST_ITEM_RENDERER);
            }
         }
         else
         {
            if(param1.data == ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
            {
               invalidate(FOCUS_INVALID);
            }
            if(!(this._dragController is TreeDragController))
            {
               this.disposeDragController();
            }
            if(this._dragController == null)
            {
               this.createNewTreeController();
            }
         }
      }
      
      private function onTreeComponentRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         invalidate(FOCUS_INVALID);
      }
      
      private function onReceiverDataChangeHandler(param1:Event) : void
      {
         invalidate(REMOVE_BTN_ENABLING_INV);
      }
      
      private function onTreeComponentDataPopulatedHandler(param1:Event = null) : void
      {
         this.invalidateAddBtnEnabling();
         this.invalidateAddAllBtnEnabling();
      }
      
      private function onTreeComponentTopLevelListSelectedIndexChangedHandler(param1:ContactsTreeEvent) : void
      {
         this.invalidateAddBtnEnabling();
      }
      
      private function invalidateAddAllBtnEnabling(param1:Event = null) : void
      {
         invalidate(ADD_ALL_BTN_ENABLING_INV);
      }
      
      private function invalidateMngmntBtnEnabling(param1:Event = null) : void
      {
         invalidate(REMOVE_BTN_ENABLING_INV);
      }
      
      private function onMessageTextInputFocusInHandler(param1:FocusHandlerEvent) : void
      {
         var _loc2_:uint = this.messageTextInput.textField.getTextFormat()[COLOR];
         if(_loc2_ == ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR)
         {
            this.messageTextInput.textField.textColor = ContactsShared.INVITE_INPUT_TEXT_COLOR;
            this.messageTextInput.text = Values.EMPTY_STR;
         }
      }
      
      private function onReceiverListIndexChangeHandler(param1:ListEvent) : void
      {
         this.invalidateMngmntBtnEnabling();
      }
      
      private function onReceiverListItemClickHandler(param1:ListEvent) : void
      {
         var _loc2_:ContactItemVO = null;
         var _loc3_:Object = null;
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            _loc2_ = ContactItemVO(param1.itemData);
            _loc3_ = {
               "dbID":_loc2_.dbID,
               "userName":_loc2_.userName,
               "clanAbbrev":(Boolean(_loc2_.userPropsVO) ? _loc2_.userPropsVO.clanAbbrev : Values.EMPTY_STR)
            };
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,_loc3_);
         }
      }
      
      private function onReceiverListItemDoubleClickHandler(param1:ListEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            return;
         }
         this.removeReceiveItem();
      }
      
      private function onAddAllUsersButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:ContactItemVO = null;
         if(this.treeComponent.getMode() == ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
         {
            _loc2_ = this.treeComponent.getFoundContacts();
         }
         else
         {
            _loc2_ = getAllAvailableContactsS();
         }
         var _loc3_:uint = Boolean(_loc2_) ? uint(_loc2_.length) : uint(0);
         if(_loc3_ > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = _loc2_[_loc5_];
               if(!_loc6_.hasOwnProperty(USER_PROPS))
               {
                  _loc4_ = USER_PROPS;
                  break;
               }
               if(!_loc6_.hasOwnProperty(DB_ID))
               {
                  _loc4_ = DB_ID;
                  break;
               }
               if(this.isUserValid(_loc6_.userProps.tags))
               {
                  if(!this.hasUserInReceiverList(_loc6_.dbID))
                  {
                     _loc7_ = new ContactItemVO(_loc6_);
                     this._createdContactItems.push(_loc7_);
                     this._receiverData.push(_loc7_);
                  }
               }
               _loc5_++;
            }
            if(_loc4_ != null)
            {
               throw new Error("There is no property \'" + _loc4_ + "\' in received data! Check sent python data!");
            }
            this._receiverData.invalidate();
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY);
         }
      }
      
      private function onRemoveUserButtonClickHandler(param1:ButtonEvent = null) : void
      {
         this.removeReceiveItem();
      }
      
      private function onRemoveAllUsersButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this._receiverData.length > 0)
         {
            this._receiverData.cleanUp();
            this._receiverData.invalidate();
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
         }
      }
      
      private function onOnlineCheckBoxClickHandler(param1:ButtonEvent) : void
      {
         setOnlineFlagS(this.onlineCheckBox.selected);
         this.treeComponent.resetSelected();
      }
      
      private function onSendButtonClickHandler(param1:ButtonEvent = null) : void
      {
         var _loc2_:Array = [];
         var _loc3_:String = Values.EMPTY_STR;
         if(this.messageTextInput.textField.getTextFormat()[COLOR] != ContactsShared.INVITE_PROMPT_DEFAULT_TEXT_COLOR)
         {
            _loc3_ = StringUtils.trim(this.messageTextInput.text);
         }
         var _loc4_:uint = this._receiverData.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_.push(ContactItemVO(this._receiverData[_loc5_]).dbID);
            _loc5_++;
         }
         sendInvitesS(_loc2_,_loc3_);
      }
   }
}
