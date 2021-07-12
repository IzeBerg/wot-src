package net.wg.gui.lobby.clans.search
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.interfaces.ISearchInput;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.interfaces.IButtonIconTextTransparent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchItemVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowInitDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowStateDataVO;
   import net.wg.infrastructure.base.meta.IClanSearchWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ClanSearchWindowMeta;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ClanSearchWindow extends ClanSearchWindowMeta implements IClanSearchWindowMeta
   {
      
      private static const INV_INIT_DATA:String = "InvInitData";
      
      private static const INV_STATE_DATA:String = "InvStateData";
      
      private static const INV_FOCUS_CHAIN:String = "InvFocusChain";
      
      private static const SEARCH_BUTTONS_GAP:int = 1;
      
      private static const WINDOW_WIDTH:int = 1006;
      
      private static const WINDOW_HEIGHT:int = 597;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var table:ISortableTable = null;
      
      public var foundClansTF:TextField = null;
      
      public var info:ClanSearchInfo = null;
      
      public var searchInput:ISearchInput = null;
      
      public var previousBtn:IButtonIconTextTransparent = null;
      
      public var nextBtn:IButtonIconTextTransparent = null;
      
      public var searchBtn:ISoundButtonEx = null;
      
      public var headerSeparator:ISeparatorAsset = null;
      
      public var verticalSeparator:ISeparatorAsset = null;
      
      public var navigationSeparator:ISeparatorAsset = null;
      
      public var noInfoImage:Sprite = null;
      
      public var dummy:IDummy = null;
      
      private var _initData:ClanSearchWindowInitDataVO = null;
      
      private var _stateData:ClanSearchWindowStateDataVO = null;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      public function ClanSearchWindow()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         super();
      }
      
      private static function onBtnRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function setInitData(param1:ClanSearchWindowInitDataVO) : void
      {
         this._initData = param1;
         invalidate(INV_INIT_DATA);
      }
      
      override protected function setStateData(param1:ClanSearchWindowStateDataVO) : void
      {
         this._stateData = param1;
         invalidate(INV_STATE_DATA);
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.previousBtn.dispose();
         this.previousBtn = null;
         this.nextBtn.dispose();
         this.nextBtn = null;
         this.searchBtn.dispose();
         this.searchBtn = null;
         this.searchInput.dispose();
         this.searchInput = null;
         this.info = null;
         this.table.dispose();
         this.table = null;
         this.headerSeparator.dispose();
         this.headerSeparator = null;
         this.navigationSeparator.dispose();
         this.navigationSeparator = null;
         this.verticalSeparator.dispose();
         this.verticalSeparator = null;
         this.dummy.dispose();
         this.dummy = null;
         this.foundClansTF = null;
         this.descriptionTF = null;
         this.titleTF = null;
         this.noInfoImage = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         this._initData = null;
         this._stateData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData && isInvalid(INV_INIT_DATA))
         {
            this.setupInitData();
         }
         if(this._stateData && isInvalid(INV_STATE_DATA))
         {
            this.foundClansTF.htmlText = this._stateData.foundClans;
            this.previousBtn.enabled = this._stateData.previousBtnEnabled;
            this.nextBtn.enabled = this._stateData.nextBtnEnabled;
            this.searchBtn.enabled = this._stateData.searchBtnEnabled;
            this.searchInput.enabled = this._stateData.searchInputEnabled;
         }
         if(isInvalid(INV_FOCUS_CHAIN))
         {
            this.refreshFocusChain();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerSeparator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.navigationSeparator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.verticalSeparator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.nextBtn.mouseEnabledOnDisabled = true;
         this.previousBtn.mouseEnabledOnDisabled = true;
         this.table.mouseEnabled = false;
         this.table.isListMouseEnabled = false;
         this.info.mouseEnabled = false;
         this.noInfoImage.mouseEnabled = false;
         focusable = true;
         this.addListeners();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.descriptionTF.autoSize = TextFieldAutoSize.CENTER;
         this.noInfoImage.visible = true;
         this.info.visible = false;
         this.table.listVisible = false;
         this.dummy.visible = false;
         registerFlashComponentS(this.info,CLANS_ALIASES.CLAN_SEARCH_INFO_PY);
         this._dataProvider = new ListDAAPIDataProvider(ClanSearchItemVO);
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         this.table.listDP = this._dataProvider;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         invalidate(INV_FOCUS_CHAIN);
      }
      
      override protected function setDummy(param1:DummyVO) : void
      {
         this.dummy.setData(param1);
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_setDummyVisible(param1:Boolean) : void
      {
         this.dummy.visible = param1;
         this.table.listVisible = !param1;
         invalidate(INV_FOCUS_CHAIN);
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         _loc1_.push(this);
         _loc1_.push(this.searchInput);
         _loc1_.push(this.searchBtn);
         _loc1_ = _loc1_.concat(this.table.getFocusChain(),this.dummy.getFocusChain());
         _loc1_.push(this.previousBtn);
         _loc1_.push(this.nextBtn);
         _loc1_ = _loc1_.concat(this.info.getFocusChain());
         _loc1_.push(Window(window).minimizeBtn);
         _loc1_.push(window.getCloseBtn());
         return _loc1_;
      }
      
      private function updateItem(param1:ClanSearchItemVO) : void
      {
         var _loc2_:Boolean = param1 != null;
         this.info.visible = _loc2_;
         this.noInfoImage.visible = !_loc2_;
         if(_loc2_)
         {
            this.info.setClanId(param1.clanInfo.dbID);
         }
      }
      
      private function refreshFocusChain() : void
      {
         var _loc1_:int = this._focusChain.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._focusChain[_loc2_].tabIndex = -1;
            _loc2_++;
         }
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = this.getFocusChain();
         App.utils.commons.initTabIndex(this._focusChain);
         setFocus(!!this.dummy.visible ? InteractiveObject(this.searchInput) : this.table.getComponentForFocus());
      }
      
      private function removeListeners() : void
      {
         this.previousBtn.removeEventListener(ButtonEvent.CLICK,this.onPreviousBtnClickHandler);
         this.previousBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onPreviousBtnRollOverHandler);
         this.previousBtn.removeEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.nextBtn.removeEventListener(ButtonEvent.CLICK,this.onNextBtnClickHandler);
         this.nextBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onNextBtnRollOverHandler);
         this.nextBtn.removeEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.searchBtn.removeEventListener(ButtonEvent.CLICK,this.onSearchBtnClickHandler);
         this.searchBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchBtnRollOverHandler);
         this.searchBtn.removeEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.searchInput.removeEventListener(InputEvent.INPUT,this.onSearchInputInputHandler);
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         this.table.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onTableListIndexChangeHandler);
         this.table.removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.dummy.removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.dummy.removeEventListener(DummyEvent.CLICK,this.onDummyButtonClickHandler);
      }
      
      private function addListeners() : void
      {
         this.searchBtn.addEventListener(MouseEvent.ROLL_OVER,this.onSearchBtnRollOverHandler);
         this.searchBtn.addEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.searchBtn.addEventListener(ButtonEvent.CLICK,this.onSearchBtnClickHandler);
         this.nextBtn.addEventListener(ButtonEvent.CLICK,this.onNextBtnClickHandler);
         this.nextBtn.addEventListener(MouseEvent.ROLL_OVER,this.onNextBtnRollOverHandler);
         this.nextBtn.addEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.previousBtn.addEventListener(ButtonEvent.CLICK,this.onPreviousBtnClickHandler);
         this.previousBtn.addEventListener(MouseEvent.ROLL_OVER,this.onPreviousBtnRollOverHandler);
         this.previousBtn.addEventListener(MouseEvent.ROLL_OUT,onBtnRollOutHandler);
         this.searchInput.addEventListener(InputEvent.INPUT,this.onSearchInputInputHandler);
         this.table.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onTableListIndexChangeHandler);
         this.table.addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.dummy.addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.dummy.addEventListener(DummyEvent.CLICK,this.onDummyButtonClickHandler);
      }
      
      private function setupInitData() : void
      {
         window.title = this._initData.windowTitle;
         this.table.headerDP = this._initData.tableHeaders;
         this.previousBtn.label = this._initData.previousBtnLabel;
         this.nextBtn.label = this._initData.nextBtnLabel;
         this.titleTF.htmlText = this._initData.title;
         this.descriptionTF.htmlText = this._initData.titleDescription;
         this.searchBtn.label = this._initData.searchBtnLabel;
         this.searchInput.defaultText = this._initData.searchInputPrompt;
         this.searchInput.maxChars = this._initData.searchInputMaxChars;
         this.searchBtn.validateNow();
         this.searchInput.x = this.searchBtn.x - SEARCH_BUTTONS_GAP - this.searchInput.width;
      }
      
      private function searchClans() : void
      {
         searchS(this.searchInput.text);
      }
      
      override public function get width() : Number
      {
         return WINDOW_WIDTH;
      }
      
      override public function get height() : Number
      {
         return WINDOW_HEIGHT;
      }
      
      private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc2_:ClanSearchItemVO = ClanSearchItemVO(param1.data);
         if(param1.index == this.table.listSelectedIndex)
         {
            this.updateItem(_loc2_);
         }
      }
      
      private function onDummyButtonClickHandler(param1:DummyEvent) : void
      {
         dummyButtonPressS();
      }
      
      private function onFocusChainChangeHandler(param1:FocusChainChangeEvent) : void
      {
         invalidate(INV_FOCUS_CHAIN);
      }
      
      private function onPreviousBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._initData.previousBtnTooltip);
      }
      
      private function onNextBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._initData.nextBtnTooltip);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         if(this._dataProvider.length > 0)
         {
            this.table.listSelectedIndex = 0;
         }
         else
         {
            this.updateItem(null);
         }
      }
      
      private function onTableListIndexChangeHandler(param1:SortableTableListEvent) : void
      {
         var _loc2_:ClanSearchItemVO = ClanSearchItemVO(param1.itemData);
         this.updateItem(_loc2_);
      }
      
      private function onSearchInputInputHandler(param1:InputEvent) : void
      {
         if(param1.details.value == InputValue.KEY_DOWN && param1.details.code == Keyboard.ENTER)
         {
            param1.handled = true;
            this.searchClans();
         }
      }
      
      private function onPreviousBtnClickHandler(param1:ButtonEvent) : void
      {
         previousPageS();
      }
      
      private function onNextBtnClickHandler(param1:ButtonEvent) : void
      {
         nextPageS();
      }
      
      private function onSearchBtnClickHandler(param1:ButtonEvent) : void
      {
         searchS(this.searchInput.text);
      }
      
      private function onSearchBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(this._initData)
         {
            App.toolTipMgr.showComplex(this._initData.searchBtnTooltip);
         }
      }
   }
}
