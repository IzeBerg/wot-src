package net.wg.gui.messenger.views
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.advanced.SearchInput;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.messenger.controls.BaseContactsScrollingList;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ContactsShared;
   import net.wg.gui.messenger.data.ContactsViewInitDataVO;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import net.wg.gui.messenger.evnts.ContactsTreeEvent;
   import net.wg.gui.messenger.meta.ISearchContactViewMeta;
   import net.wg.gui.messenger.meta.impl.SearchContactViewMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.MouseEventEx;
   
   public class SearchContactView extends SearchContactViewMeta implements ISearchContactViewMeta
   {
      
      private static const INPUT_TEXT_INV:String = "inTInvalid";
      
      private static const CHECK_ENABLING_INV:String = "checkEnableInv";
      
      private static const LBL_INVALID:String = "lblInv";
      
      private static const INIT_INVALID:String = "initInv";
      
      private static const SHOW_RES_LBL_INV:String = "showResLblInv";
      
      private static const SEARCH_DISABLED_COOLDOWN_INV:String = "searchDisInv";
      
      private static const SEARCH_TEXT_VALIDATION_INV:String = "searchTextValidationInv";
      
      private static const GAP_SEARCH_AND_BUTTONS_BAR:int = 20;
       
      
      public var list:BaseContactsScrollingList = null;
      
      public var searchBtn:SoundButtonEx = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var searchInput:SearchInput = null;
      
      public var resultsLabel:TextField = null;
      
      public var infoMsg:TextField = null;
      
      public var lipsUp:MovieClip = null;
      
      public var waitingIndicator:InviteIndicator = null;
      
      private var _searchDP:IDataProvider;
      
      private var _searchText:String = null;
      
      private var _extLabel:String = null;
      
      private var _defaultSearchCooldown:String = null;
      
      private var _minSearchChars:uint = 0;
      
      private var _searchInitialized:Boolean = false;
      
      private var _showResultLabel:Boolean = true;
      
      private var _searchDisabledCoolDown:Number = NaN;
      
      public function SearchContactView()
      {
         this._searchDP = new DAAPIDataProvider();
         super();
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return InteractiveObject(this.searchInput);
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[InteractiveObject(this.searchInput),this.searchBtn,this.list].concat(super.getFocusChain());
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
         super.setViewSize(param1,param2);
         validateNow();
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:String = null;
         super.update(param1);
         if(param1 != null)
         {
            _loc2_ = param1.toString();
            if(_loc2_ == "")
            {
               this._searchInitialized = false;
               invalidate(INIT_INVALID);
            }
            this.searchInput.text = this._searchText = ContactsShared.trim(_loc2_);
            invalidate(INPUT_TEXT_INV);
            invalidate(SEARCH_TEXT_VALIDATION_INV);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.searchInput.addEventListener(InputEvent.INPUT,this.onSearchInputInputHandler,false,0,true);
         this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchBtn.mouseEnabledOnDisabled = true;
         this.searchBtn.addEventListener(ButtonEvent.CLICK,this.onSearchBtnClickHandler,false,0,true);
         this._searchDP.addEventListener(Event.CHANGE,this.onSearchDPChangeHandler,false,0,true);
         this.list.useRightButton = true;
         this.list.useRightButtonForSelect = true;
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler,false,0,true);
         this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListItemDoubleClickHandler,false,0,true);
         this.list.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler);
         this.list.dataProvider = this._searchDP;
         this.onSearchDPChange();
         this.infoMsg.mouseEnabled = false;
         this.infoMsg.text = MESSENGER.MESSENGER_CONTACTS_EXTERNALSEARCH_EMPTYSEARCHRESULTPROMPT;
      }
      
      override protected function draw() : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         super.draw();
         if(isInvalid(INPUT_TEXT_INV))
         {
            if(isDAAPIInited && StringUtils.isNotEmpty(this._searchText))
            {
               this._searchInitialized = true;
               searchS(this._searchText);
            }
         }
         var _loc1_:Boolean = isInvalid(CHECK_ENABLING_INV);
         if(_loc1_)
         {
            _loc5_ = false;
            _loc6_ = this.list.selectedIndex;
            if(this._searchDP.length > 0 && _loc6_ != -1)
            {
               _loc7_ = this._searchDP.requestItemAt(_loc6_);
               if(_loc7_)
               {
                  if(_loc7_.userProps.tags)
                  {
                     _loc5_ = !(UserTags.isCurrentPlayer(_loc7_.userProps.tags) || UserTags.isFriend(_loc7_.userProps.tags));
                  }
                  else
                  {
                     _loc5_ = true;
                  }
               }
            }
            btns.btnOk.enabled = _loc5_;
         }
         var _loc2_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_ || _loc2_ || isInvalid(INIT_INVALID))
         {
            _loc8_ = this.searchInput.y + this.searchInput.height >> 0;
            if(this._searchInitialized)
            {
               _loc9_ = this.getButtonsBarY();
               btns.y = _loc9_;
               this.scrollBar.alpha = 1;
               _loc10_ = _loc9_ - (_loc8_ + this.resultsLabel.height >> 0);
               _loc11_ = (_loc10_ / ContactsShared.CONTACT_RENDERER_HEIGHT >> 0) * ContactsShared.CONTACT_RENDERER_HEIGHT;
               this.list.height = _loc11_;
               _loc12_ = _loc9_ - _loc11_;
               this.list.y = _loc12_;
               this.lipsUp.y = _loc12_ - (this.lipsUp.height >> 1);
               this.scrollBar.y = _loc12_ + ContactsShared.SCROLL_SIDE_PADDING;
               this.scrollBar.height = _loc11_ - (ContactsShared.SCROLL_SIDE_PADDING << 1);
               this.infoMsg.x = this.list.x + (this.list.width - this.infoMsg.width >> 1);
               this.infoMsg.y = this.list.y + (this.list.height - this.infoMsg.height >> 1);
               this.resultsLabel.y = (_loc12_ - _loc8_ - this.resultsLabel.height >> 1) + _loc8_;
            }
            else
            {
               btns.y = _loc8_ + GAP_SEARCH_AND_BUTTONS_BAR;
               this.scrollBar.alpha = 0;
            }
            this.list.visible = this.lipsUp.visible = this._searchInitialized;
            this.checkInfoMsgVisible();
            invalidate(SHOW_RES_LBL_INV);
         }
         if(isInvalid(LBL_INVALID) && this._extLabel)
         {
            title.text = this._extLabel;
         }
         if(isInvalid(SHOW_RES_LBL_INV))
         {
            this.resultsLabel.visible = this._showResultLabel && this._searchInitialized;
         }
         var _loc3_:Boolean = this.isSearchUnderCoolDown();
         var _loc4_:Boolean = isInvalid(SEARCH_DISABLED_COOLDOWN_INV);
         if(_loc4_)
         {
            this.waitingIndicator.visible = _loc3_;
         }
         if(_loc4_ || isInvalid(SEARCH_TEXT_VALIDATION_INV))
         {
            if(_loc3_)
            {
               this.searchBtn.enabled = false;
               this.searchBtn.tooltipParams = new ToolTipParams(null,{"time":this._defaultSearchCooldown});
               this.searchBtn.tooltip = MESSENGER.CONTACTS_SEARCHVIEW_TOOLTIPS_SEARCHDISABLED;
            }
            else if(this.isSearchInputValid())
            {
               this.searchBtn.enabled = true;
               this.searchBtn.tooltipParams = null;
               this.searchBtn.tooltip = MESSENGER.CONTACTS_SEARCHVIEW_TOOLTIPS_BTNS_SEARCH;
            }
            else
            {
               this.searchBtn.enabled = false;
               this.searchBtn.tooltipParams = new ToolTipParams(null,{
                  "minChars":this._minSearchChars.toString(),
                  "maxChars":this.searchInput.maxChars.toString()
               });
               this.searchBtn.tooltip = MESSENGER.CONTACTS_SEARCHVIEW_TOOLTIPS_SEARCHCREDENTIALS;
            }
            dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.EXTERNAL_SEARCH_VALID_CHANGED,true));
         }
      }
      
      override protected function onDispose() : void
      {
         this._searchDisabledCoolDown = NaN;
         App.utils.scheduler.cancelTask(this.searchCoolDownFinished);
         this.searchInput.removeEventListener(InputEvent.INPUT,this.onSearchInputInputHandler,false);
         this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.dispose();
         this.searchInput = null;
         this.searchBtn.removeEventListener(ButtonEvent.CLICK,this.onSearchBtnClickHandler,false);
         this.searchBtn.dispose();
         this.searchBtn = null;
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler,false);
         this.list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListItemDoubleClickHandler,false);
         this.list.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClickHandler);
         this.list.dispose();
         this.list = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.waitingIndicator.dispose();
         this.waitingIndicator = null;
         this.resultsLabel = null;
         this.infoMsg = null;
         this.lipsUp = null;
         if(this._searchDP)
         {
            this._searchDP.removeEventListener(Event.CHANGE,this.onSearchDPChangeHandler,false);
            this._searchDP.cleanUp();
            this._searchDP = null;
         }
         super.onDispose();
      }
      
      override protected function applyInitData(param1:ContactsViewInitDataVO) : void
      {
         super.applyInitData(param1);
         var _loc2_:SearchViewInitData = SearchViewInitData(param1);
         this._defaultSearchCooldown = _loc2_.searchCoolDown;
         this.waitingIndicator.tooltip = MESSENGER.CONTACTS_SEARCHVIEW_TOOLTIPS_SEARCHDISABLED;
         this.waitingIndicator.tooltipParams = new ToolTipParams(null,{"time":this._defaultSearchCooldown});
         this.searchInput.defaultText = _loc2_.inputPrompt;
         this.searchInput.maxChars = _loc2_.accMaxChars;
         this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this._minSearchChars = _loc2_.accMinChars;
         invalidate(SEARCH_TEXT_VALIDATION_INV);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         invalidate(INPUT_TEXT_INV);
      }
      
      override protected function getContactsViewInitDataVOForData(param1:Object) : ContactsViewInitDataVO
      {
         return new SearchViewInitData(param1);
      }
      
      override protected function onButtonClick() : void
      {
         var _loc1_:Object = this.list.dataProvider.requestItemAt(this.list.selectedIndex);
         var _loc2_:ContactsFormEvent = new ContactsFormEvent(ContactsFormEvent.ADD_TO_FRIENDS,true);
         if(_loc1_)
         {
            _loc2_.dbID = _loc1_.dbID;
            _loc2_.name = _loc1_.userProps.userName;
         }
         dispatchEvent(_loc2_);
      }
      
      public function as_getSearchDP() : Object
      {
         return this._searchDP;
      }
      
      public function as_setSearchDisabled(param1:Number) : void
      {
         this._searchDisabledCoolDown = param1;
         if(this.isSearchUnderCoolDown())
         {
            App.utils.scheduler.scheduleTask(this.searchCoolDownFinished,param1 * 1000);
         }
         else
         {
            App.utils.scheduler.cancelTask(this.searchCoolDownFinished);
         }
         invalidate(SEARCH_DISABLED_COOLDOWN_INV);
      }
      
      public function as_setSearchResultText(param1:String) : void
      {
         this.resultsLabel.text = param1;
      }
      
      public function setLabel(param1:String) : void
      {
         this._extLabel = param1;
         invalidate(LBL_INVALID);
      }
      
      public function showResultLabel(param1:Boolean) : void
      {
         this._showResultLabel = param1;
         invalidate(SHOW_RES_LBL_INV);
      }
      
      private function isSearchInputValid() : Boolean
      {
         return ContactsShared.searchTextValid(ContactsShared.trim(this.searchInput.text),this._minSearchChars);
      }
      
      private function checkInfoMsgVisible() : void
      {
         this.infoMsg.visible = this._searchInitialized && this._searchDP.length == 0 && ContactsShared.trim(this.searchInput.text) != "";
      }
      
      private function isSearchUnderCoolDown() : Boolean
      {
         return !isNaN(this._searchDisabledCoolDown) && this._searchDisabledCoolDown > 0;
      }
      
      private function searchCoolDownFinished() : void
      {
         this._searchDisabledCoolDown = NaN;
         invalidate(SEARCH_DISABLED_COOLDOWN_INV);
      }
      
      private function getButtonsBarY() : int
      {
         return _height - ContactsShared.CONTROLS_PADDING - btns.verricalBtnsPadding - btns.getActualBtnsHeight() >> 0;
      }
      
      private function onSearchDPChange() : void
      {
         this.checkInfoMsgVisible();
         this.scrollBar.visible = !this.infoMsg.visible;
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_CHANGED));
         invalidate(CHECK_ENABLING_INV);
      }
      
      private function onSearchBtnClick() : void
      {
         this._searchText = ContactsShared.trim(this.searchInput.text);
         invalidate(INPUT_TEXT_INV);
      }
      
      public function set isAddingContactAllow(param1:Boolean) : void
      {
         btns.showOkButton(param1);
      }
      
      private function onListItemDoubleClickHandler(param1:ListEvent) : void
      {
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_DOUBLE_CLICK));
      }
      
      private function onSearchInputChangeHandler(param1:Event) : void
      {
         invalidate(SEARCH_TEXT_VALIDATION_INV);
      }
      
      private function onSearchInputRollOutHandler(param1:MouseEvent) : void
      {
         ContactsShared.hideSearchInputTextValidTooltip();
      }
      
      private function onSearchInputRollOverHandler(param1:MouseEvent) : void
      {
         ContactsShared.showSearchInputTextValidTooltip(this._minSearchChars,this.searchInput.maxChars);
      }
      
      private function onListIndexChangeHandler(param1:ListEvent) : void
      {
         invalidate(CHECK_ENABLING_INV);
         dispatchEvent(new ContactsTreeEvent(ContactsTreeEvent.EXTERNAL_SEARCH_LIST_SELECTED_INDEX_CHANGED));
      }
      
      private function onListItemClickHandler(param1:ListEventEx) : void
      {
         var _loc2_:ContactItemVO = null;
         var _loc3_:Object = null;
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            _loc2_ = new ContactItemVO(param1.itemData);
            _loc3_ = {
               "dbID":_loc2_.dbID,
               "userName":_loc2_.userName,
               "clanAbbrev":(Boolean(_loc2_.userPropsVO) ? _loc2_.userPropsVO.clanAbbrev : "")
            };
            _loc2_.dispose();
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,_loc3_);
         }
      }
      
      private function onSearchDPChangeHandler(param1:Event) : void
      {
         this.onSearchDPChange();
      }
      
      private function onSearchInputInputHandler(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         invalidate(SEARCH_TEXT_VALIDATION_INV);
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ENTER:
               if(_loc2_.code != Keyboard.SPACE && _loc2_.value == InputValue.KEY_DOWN)
               {
                  if(!this.isSearchUnderCoolDown() && this.isSearchInputValid())
                  {
                     this.onSearchBtnClick();
                  }
                  param1.handled = true;
                  break;
               }
         }
      }
      
      private function onSearchBtnClickHandler(param1:Event) : void
      {
         this.onSearchBtnClick();
      }
   }
}

import net.wg.gui.messenger.data.ExtContactsViewInitVO;

class SearchViewInitData extends ExtContactsViewInitVO
{
    
   
   public var searchCoolDown:String = "";
   
   public var accMinChars:uint;
   
   public var accMaxChars:uint;
   
   function SearchViewInitData(param1:Object)
   {
      super(param1);
   }
}
