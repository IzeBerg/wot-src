package net.wg.gui.messenger
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CONTACTS_ALIASES;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.ResizableViewStack;
   import net.wg.gui.lobby.profile.LinkageUtils;
   import net.wg.gui.messenger.controls.ContactsListDragDropDelegate;
   import net.wg.gui.messenger.controls.ContactsListDtagController;
   import net.wg.gui.messenger.controls.ContactsTreeComponent;
   import net.wg.gui.messenger.data.ContactListMainInfo;
   import net.wg.gui.messenger.data.ContactsGroupEvent;
   import net.wg.gui.messenger.data.ContactsShared;
   import net.wg.gui.messenger.data.ContactsWindowInitVO;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import net.wg.gui.messenger.evnts.ContactsTreeEvent;
   import net.wg.gui.messenger.meta.IContactsListPopoverMeta;
   import net.wg.gui.messenger.meta.impl.ContactsListPopoverMeta;
   import net.wg.gui.messenger.views.BaseContactView;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class ContactsListPopover extends ContactsListPopoverMeta implements IContactsListPopoverMeta
   {
      
      private static const FOCUS_INVALID:String = "fcInv";
       
      
      public var viewStack:ResizableViewStack = null;
      
      public var addContactButton:ButtonIconNormal = null;
      
      public var addGroupButton:ButtonIconNormal = null;
      
      public var settingsButton:ButtonIconNormal = null;
      
      public var treeComponent:ContactsTreeComponent = null;
      
      public var lipsDown:MovieClip = null;
      
      public var borderLip:MovieClip = null;
      
      private var _closeBtn:InteractiveObject = null;
      
      private var _linkageUtils:LinkageUtils;
      
      private var _initData:ContactsWindowInitVO = null;
      
      private var _focusChain:Vector.<InteractiveObject> = null;
      
      private var _focusInited:Boolean = false;
      
      private var _dragController:DropListDelegateCtrlr = null;
      
      public function ContactsListPopover()
      {
         this._linkageUtils = new LinkageUtils();
         super();
         this._linkageUtils.addEntity(CONTACTS_ALIASES.FIND_CONTACT_VIEW_ALIAS,CONTACTS_ALIASES.FIND_CONTACT_VIEW_LINKAGE);
         this._linkageUtils.addEntity(CONTACTS_ALIASES.GROUP_CREATE_VIEW_ALIAS,CONTACTS_ALIASES.GROUP_MANAGE_VIEW_LINKAGE);
         this._linkageUtils.addEntity(CONTACTS_ALIASES.CONTACT_CREATE_NOTE_VIEW_ALIAS,CONTACTS_ALIASES.CONTACT_NOTE_MANAGE_LINKAGE);
         this._linkageUtils.addEntity(CONTACTS_ALIASES.GROUP_DELETE_VIEW_ALIAS,CONTACTS_ALIASES.GROUP_DELETE_VIEW_LINKAGE);
         this._linkageUtils.addEntity(CONTACTS_ALIASES.CONTACTS_SETTINGS_VIEW_ALIAS,CONTACTS_ALIASES.CONTACTS_SETTINGS_VIEW_LINKAGE);
      }
      
      private static function getMoveGroupSendData(param1:ContactsGroupEvent) : Object
      {
         return {
            "excludeGroup":param1.excludeGroup.id,
            "targetGroup":param1.targetGroup.id,
            "excludeParentGroup":(Boolean(param1.excludeGroup.parent) ? param1.excludeGroup.parent.id : null),
            "targetParentGroup":(Boolean(param1.targetGroup.parent) ? param1.targetGroup.parent.id : null)
         };
      }
      
      override protected function draw() : void
      {
         var _loc1_:Vector.<InteractiveObject> = null;
         super.draw();
         if(isInvalid(FOCUS_INVALID))
         {
            if(this.viewStack.currentView)
            {
               if(this._focusInited)
               {
                  setFocus(this.viewStack.currentView.getComponentForFocus());
               }
               _loc1_ = IFocusChainContainer(this.viewStack.currentView).getFocusChain().concat(new <InteractiveObject>[this._closeBtn]);
            }
            else
            {
               if(this._focusInited)
               {
                  setFocus(this.treeComponent.getComponentForFocus());
               }
               _loc1_ = this.treeComponent.getFocusChain().concat(new <InteractiveObject>[this.addContactButton,this.addGroupButton,this.settingsButton,this._closeBtn]);
            }
            this._focusInited = true;
            this.cleanupFocusChain();
            this._focusChain = _loc1_;
            App.utils.commons.initTabIndex(this._focusChain);
         }
      }
      
      override protected function applyWaitingChanges(param1:int, param2:int) : void
      {
         super.applyWaitingChanges(param1,this.height - ContactsShared.BOTTOM_CTRLS_PADDING);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lipsDown.mouseChildren = this.lipsDown.mouseEnabled = false;
         this.addContactButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONADDCONTACT;
         this.addGroupButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONADDGROUP;
         this.settingsButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONSETTINGS;
         this.addContactButton.tooltip = MESSENGER.CONTACTS_TOOLTIPS_BTNS_SEARCH;
         this.addGroupButton.tooltip = MESSENGER.CONTACTS_TOOLTIPS_BTNS_ADDGROUP;
         this.settingsButton.tooltip = MESSENGER.CONTACTS_TOOLTIPS_BTNS_SETTINGS;
         this.addContactButton.addEventListener(ButtonEvent.CLICK,this.onAddContactButtonClickHandler);
         this.addGroupButton.addEventListener(ButtonEvent.CLICK,this.onAddGroupButtonClickHandler);
         this.settingsButton.addEventListener(ButtonEvent.CLICK,this.onSettingsButtonClickHandler);
         addEventListener(ContactsFormEvent.ADD_TO_FRIENDS,this.onAddToFriendsHandler);
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewShowHandler);
         this.viewStack.addEventListener(BaseContactView.ON_CANCEL_CLICKED,this.onViewStackOnCancelClickHandler);
         mouseEnabled = false;
         this.borderLip.mouseChildren = this.borderLip.mouseEnabled = false;
         registerFlashComponentS(this.treeComponent,CONTACTS_ALIASES.CONTACTS_TREE);
         this.treeComponent.addEventListener(ContactsGroupEvent.CONTACT_CHANGE_GROUP,this.onTreeComponentContactChangeGroupHandler);
         this.treeComponent.addEventListener(ContactsGroupEvent.CONTACT_COPY_GROUP,this.onTreeComponentContactCopyGroupHandler);
         this.treeComponent.addEventListener(ContactsTreeEvent.MODE_CHANGED,this.onTreeComponentModeChangedHandler);
         this.treeComponent.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onTreeComponentRequestFocusHandler);
         this._dragController = new ContactsListDtagController(new <InteractiveObject>[this.treeComponent.list],ContactsListDragDropDelegate,Linkages.CONTACTS_TREE_ITEM_RENDERER);
         var _loc1_:uint = this.height - ContactsShared.CONTROLS_PADDING - this.addContactButton.height - ContactsShared.BOTTOM_CTRLS_PADDING;
         this.addContactButton.y = this.addGroupButton.y = this.settingsButton.y = _loc1_;
         this.lipsDown.y = _loc1_ - ContactsShared.CONTROLS_PADDING + (this.lipsDown.height >> 1);
         this.viewStack.setAvailableSize(width,this.height - ContactsShared.BOTTOM_CTRLS_PADDING);
         this.treeComponent.setSize(width,this.height - ContactsShared.BOTTOM_CTRLS_PADDING);
         addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this._dragController)
         {
            this._dragController.dispose();
            this._dragController = null;
         }
         this.cleanupFocusChain();
         this.addContactButton.removeEventListener(ButtonEvent.CLICK,this.onAddContactButtonClickHandler);
         this.addGroupButton.removeEventListener(ButtonEvent.CLICK,this.onAddGroupButtonClickHandler);
         this.settingsButton.removeEventListener(ButtonEvent.CLICK,this.onSettingsButtonClickHandler);
         removeEventListener(ContactsFormEvent.ADD_TO_FRIENDS,this.onAddToFriendsHandler);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewShowHandler);
         this.viewStack.removeEventListener(BaseContactView.ON_CANCEL_CLICKED,this.onViewStackOnCancelClickHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this.treeComponent.removeEventListener(ContactsGroupEvent.CONTACT_CHANGE_GROUP,this.onTreeComponentContactChangeGroupHandler);
         this.treeComponent.removeEventListener(ContactsGroupEvent.CONTACT_COPY_GROUP,this.onTreeComponentContactCopyGroupHandler);
         this.treeComponent.removeEventListener(ContactsTreeEvent.MODE_CHANGED,this.onTreeComponentModeChangedHandler);
         this.treeComponent.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onTreeComponentRequestFocusHandler);
         removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.onMouseFocusChangeHandler);
         this.treeComponent = null;
         this._linkageUtils.dispose();
         this._linkageUtils = null;
         this.addContactButton.dispose();
         this.addContactButton = null;
         this.addGroupButton.dispose();
         this.addGroupButton = null;
         this.settingsButton.dispose();
         this.settingsButton = null;
         this.lipsDown = null;
         this.borderLip = null;
         this._closeBtn = null;
         this._initData = null;
         super.onDispose();
      }
      
      public function as_createContactNote(param1:String, param2:Number) : void
      {
         this.manageOperation(CONTACTS_ALIASES.CONTACT_NOTE_MANAGE_LINKAGE,CONTACTS_ALIASES.CONTACT_CREATE_NOTE_VIEW_ALIAS,new ContactListMainInfo(param1,param2));
      }
      
      public function as_editContactNote(param1:String, param2:Number) : void
      {
         this.manageOperation(CONTACTS_ALIASES.CONTACT_NOTE_MANAGE_LINKAGE,CONTACTS_ALIASES.CONTACT_EDIT_NOTE_VIEW_ALIAS,new ContactListMainInfo(param1,param2));
      }
      
      public function as_editGroup(param1:String) : void
      {
         this.manageOperation(CONTACTS_ALIASES.GROUP_MANAGE_VIEW_LINKAGE,CONTACTS_ALIASES.GROUP_RENAME_VIEW_ALIAS,{"text":param1});
      }
      
      public function as_removeGroup(param1:String) : void
      {
         var _loc2_:String = CONTACTS_ALIASES.GROUP_DELETE_VIEW_LINKAGE;
         var _loc3_:IUpdatable = this.viewStack.show(_loc2_,_loc2_);
         _loc3_.update(param1);
      }
      
      override protected function setInitInfo(param1:ContactsWindowInitVO) : void
      {
         this._initData = param1;
         this.checkGroupBtn();
      }
      
      private function manageOperation(param1:String, param2:String, param3:Object = null) : void
      {
         this._linkageUtils.updateEntityWithLinkage(param1,param2);
         var _loc4_:IUpdatable = this.viewStack.show(param1,param1);
         if(param3)
         {
            _loc4_.update(param3);
         }
      }
      
      private function manageButtonsVisiblity(param1:Boolean) : void
      {
         this.addContactButton.visible = param1;
         this.settingsButton.visible = param1;
      }
      
      private function checkGroupBtn() : void
      {
         this.addGroupButton.enabled = Boolean(this._initData) ? Boolean(this._initData.isGroupSupported) : Boolean(false);
         this.addGroupButton.visible = !this.treeComponent.isInSearchMode();
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
      
      override public function get height() : Number
      {
         return this.borderLip.y - (this.borderLip.height >> 1) + ContactsShared.BOTTOM_CTRLS_PADDING;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         var _loc2_:PopOver = PopOver(param1);
         _loc2_.title = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_TITLE);
         _loc2_.isCloseBtnVisible = true;
         this._closeBtn = _loc2_.closeBtn;
      }
      
      private function onTreeComponentRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         invalidate(FOCUS_INVALID);
      }
      
      private function onAddToFriendsHandler(param1:ContactsFormEvent) : void
      {
         param1.stopImmediatePropagation();
         addToFriendsS(param1.dbID,param1.name);
      }
      
      private function onAddContactButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = CONTACTS_ALIASES.FIND_CONTACT_VIEW_LINKAGE;
         this.viewStack.show(_loc2_,_loc2_);
      }
      
      private function onAddGroupButtonClickHandler(param1:ButtonEvent) : void
      {
         this.manageOperation(CONTACTS_ALIASES.GROUP_MANAGE_VIEW_LINKAGE,CONTACTS_ALIASES.GROUP_CREATE_VIEW_ALIAS);
      }
      
      private function onTreeComponentContactChangeGroupHandler(param1:ContactsGroupEvent = null) : void
      {
         param1.stopImmediatePropagation();
         changeGroupS(param1.contactID,param1.contactName,getMoveGroupSendData(param1));
      }
      
      private function onTreeComponentContactCopyGroupHandler(param1:ContactsGroupEvent = null) : void
      {
         param1.stopImmediatePropagation();
         copyIntoGroupS(param1.contactID,getMoveGroupSendData(param1));
      }
      
      private function onSettingsButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = CONTACTS_ALIASES.CONTACTS_SETTINGS_VIEW_LINKAGE;
         this.viewStack.show(_loc2_,_loc2_);
      }
      
      private function onViewStackOnCancelClickHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(this.viewStack.currentViewId)
         {
            unregisterComponent(this._linkageUtils.getAliasByLinkage(this.viewStack.currentViewId));
            invalidate(FOCUS_INVALID);
         }
      }
      
      private function onViewStackViewShowHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:String = this._linkageUtils.getAliasByLinkage(param1.viewId);
         registerFlashComponentS(IDAAPIModule(param1.view),_loc2_);
         invalidate(FOCUS_INVALID);
      }
      
      private function onTreeComponentModeChangedHandler(param1:ContactsTreeEvent) : void
      {
         if(this.treeComponent.getMode() == ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
         {
            invalidate(FOCUS_INVALID);
         }
         else if(param1.data == ContactsTreeComponent.EXTERNAL_SEARCH_MODE)
         {
            invalidate(FOCUS_INVALID);
         }
         this.manageButtonsVisiblity(!this.treeComponent.isInSearchMode());
         this.checkGroupBtn();
      }
      
      private function onMouseFocusChangeHandler(param1:FocusEvent) : void
      {
         var _loc2_:InteractiveObject = param1.relatedObject;
         if(!(_loc2_ is UIComponent || _loc2_ is TextField))
         {
            setFocus(this);
         }
      }
   }
}
