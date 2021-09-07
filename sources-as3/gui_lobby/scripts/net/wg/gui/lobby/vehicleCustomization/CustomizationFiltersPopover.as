package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.infrastructure.base.meta.ICustomizationFiltersPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationFiltersPopoverMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class CustomizationFiltersPopover extends CustomizationFiltersPopoverMeta implements ICustomizationFiltersPopoverMeta
   {
      
      private static const PADDING:int = 9;
      
      private static const ELEMENT_PADDING:int = 12;
      
      private static const BTNDEFAULT_OFFSET:int = -12;
      
      private static const DD_OFFSET:int = -2;
      
      private static const CHECKBOX_OFFSET:int = -9;
      
      private static const SEPARATOR_OFFSET:int = -29;
      
      private static const INV_FOCUS_CHAIN:String = "InvFocusChain";
      
      private static const LINKAGE_TOGGLE_RENDERER:String = "ToggleHotFilterSmallRendererUI";
      
      private static const FILTERS_TILE_WIDTH:int = 47;
      
      private static const FILTERS_TILE_HEIGHT:int = 22;
      
      private static const FILTERS_VERT_GAP:int = 13;
      
      private static const FILTERS_HOR_GAP:int = 12;
      
      private static const TITLE_OFFSET:int = 4;
      
      private static const GROUPS_OFFSET:int = 3;
      
      private static const ADD_TEXT_OFFSET:int = 2;
      
      private static const FILTERS_OFFSET:int = 3;
      
      private static const AFTER_FILTERS_OFFSET:int = 20;
      
      private static const AFTER_FORM_FILTERS_OFFSET:int = 18;
       
      
      public var separator:DisplayObject = null;
      
      public var lblTitle:TextField = null;
      
      public var lblGroups:TextField = null;
      
      public var ddlGroups:DropdownMenu = null;
      
      public var btnDefault:ISoundButtonEx = null;
      
      public var lblShowOnlyFilters:TextField = null;
      
      public var filterBtns:SimpleTileList = null;
      
      public var lblFormFilters:TextField = null;
      
      public var formBtns:SimpleTileList = null;
      
      public var lblAdditional:TextField = null;
      
      public var additionalCheckBox:CheckBox = null;
      
      private var _initData:FiltersPopoverVO = null;
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      private var _dpInited:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function CustomizationFiltersPopover()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      private static function setListParams(param1:SimpleTileList) : void
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         param1.tileWidth = FILTERS_TILE_WIDTH;
         param1.tileHeight = FILTERS_TILE_HEIGHT;
         param1.verticalGap = FILTERS_VERT_GAP;
         param1.horizontalGap = FILTERS_HOR_GAP;
         param1.directionMode = DirectionMode.HORIZONTAL;
         param1.itemRenderer = _loc2_.getClass(LINKAGE_TOGGLE_RENDERER);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ddlGroups.addEventListener(ListEvent.INDEX_CHANGE,this.onDdlGroupIndexChangeHandler);
         this.btnDefault.addEventListener(ButtonEvent.CLICK,this.onBtnDefaultClickHandler);
         this.ddlGroups.addEventListener(MouseEvent.MOUSE_OVER,this.onDdlGroupTypeMouseOverHandler);
         this.ddlGroups.addEventListener(MouseEvent.MOUSE_OUT,this.onDdlGroupTypeMouseOutHandler);
         this.additionalCheckBox.addEventListener(Event.SELECT,this.onAdditionalCheckBoxSelectHandler);
         setListParams(this.filterBtns);
         setListParams(this.formBtns);
         this.formBtns.addEventListener(RendererEvent.ITEM_CLICK,this.onFormBtnsItemClickHandler);
         this.filterBtns.addEventListener(RendererEvent.ITEM_CLICK,this.onFilterBtnsItemClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.ddlGroups.removeEventListener(ListEvent.INDEX_CHANGE,this.onDdlGroupIndexChangeHandler);
         this.btnDefault.removeEventListener(ButtonEvent.CLICK,this.onBtnDefaultClickHandler);
         this.ddlGroups.removeEventListener(MouseEvent.MOUSE_OVER,this.onDdlGroupTypeMouseOverHandler);
         this.ddlGroups.removeEventListener(MouseEvent.MOUSE_OUT,this.onDdlGroupTypeMouseOutHandler);
         this.filterBtns.removeEventListener(RendererEvent.ITEM_CLICK,this.onFilterBtnsItemClickHandler);
         this.formBtns.removeEventListener(RendererEvent.ITEM_CLICK,this.onFormBtnsItemClickHandler);
         this.additionalCheckBox.removeEventListener(Event.SELECT,this.onAdditionalCheckBoxSelectHandler);
         this.separator = null;
         this.lblTitle = null;
         this.lblShowOnlyFilters = null;
         this.lblFormFilters = null;
         this.formBtns.dispose();
         this.formBtns = null;
         this.lblGroups = null;
         this.ddlGroups.dispose();
         this.ddlGroups = null;
         this.btnDefault.dispose();
         this.btnDefault = null;
         this._initData.dispose();
         this._initData = null;
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         this.filterBtns.dispose();
         this.filterBtns = null;
         this.lblAdditional = null;
         this.additionalCheckBox.dispose();
         this.additionalCheckBox = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._initData != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.lblTitle.htmlText = this._initData.lblTitle;
               this.lblGroups.htmlText = this._initData.lblGroups;
               this.lblShowOnlyFilters.htmlText = this._initData.lblShowOnlyFilters;
               this.lblFormFilters.htmlText = this._initData.formsBtnsLbl;
               this.btnDefault.label = this._initData.btnDefault;
               this.btnDefault.tooltip = this._initData.btnDefaultTooltip;
               if(!this._dpInited)
               {
                  this.ddlGroups.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._initData.groupType));
                  this.ddlGroups.visible = this.ddlGroups.enabled = this._initData.groupType.length > 0;
                  this._dpInited = true;
               }
               if(this.ddlGroups.visible)
               {
                  this.ddlGroups.selectedIndex = this._initData.groupTypeSelectedIndex;
               }
               this.lblGroups.visible = this.ddlGroups.visible;
               this.lblAdditional.htmlText = this._initData.lblAdditional;
               this.additionalCheckBox.label = this._initData.additionalCheckBoxData.label;
               this.additionalCheckBox.toolTip = this._initData.additionalCheckBoxData.tooltip;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = ELEMENT_PADDING;
               this.lblTitle.y = _loc1_ + TITLE_OFFSET;
               _loc1_ += this.lblTitle.height + ELEMENT_PADDING;
               if(this.lblGroups.visible)
               {
                  this.lblGroups.y = _loc1_ + GROUPS_OFFSET;
                  _loc1_ += this.lblGroups.height;
               }
               if(this.ddlGroups.visible)
               {
                  this.ddlGroups.y = _loc1_ + DD_OFFSET;
                  _loc1_ += this.ddlGroups.height;
               }
               _loc1_ += ELEMENT_PADDING;
               if(this.formBtns.visible)
               {
                  this.lblFormFilters.y = _loc1_ + ADD_TEXT_OFFSET;
                  _loc1_ += this.lblFormFilters.height;
                  _loc1_ += DD_OFFSET + FILTERS_OFFSET;
                  this.formBtns.validateNow();
                  this.formBtns.y = _loc1_;
                  _loc1_ += this.formBtns.height + AFTER_FORM_FILTERS_OFFSET;
               }
               this.lblShowOnlyFilters.y = _loc1_ + ADD_TEXT_OFFSET;
               _loc1_ += this.lblShowOnlyFilters.height;
               this.filterBtns.validateNow();
               this.filterBtns.y = _loc1_;
               _loc1_ += this.filterBtns.height + AFTER_FILTERS_OFFSET;
               if(this.lblAdditional.visible)
               {
                  this.lblAdditional.y = _loc1_;
                  _loc1_ += this.lblAdditional.height;
                  this.additionalCheckBox.y = _loc1_ + CHECKBOX_OFFSET + FILTERS_OFFSET;
                  _loc1_ += this.additionalCheckBox.height + AFTER_FILTERS_OFFSET;
               }
               else
               {
                  _loc1_ += ELEMENT_PADDING;
               }
               this.separator.y = _loc1_ + SEPARATOR_OFFSET;
               _loc1_ += this.separator.height;
               this.btnDefault.y = _loc1_ + BTNDEFAULT_OFFSET;
               _loc1_ += this.btnDefault.height;
               _loc1_ += PADDING;
               setViewSize(this.width,_loc1_);
            }
         }
         if(isInvalid(INV_FOCUS_CHAIN))
         {
            this.refreshFocusChain();
         }
      }
      
      override protected function setData(param1:FiltersPopoverVO) : void
      {
         this._initData = param1;
         this.filterBtns.dataProvider = this._initData.filterBtns;
         this.formBtns.dataProvider = this._initData.formsBtns;
         this.formBtns.visible = this._initData.formsBtns && this._initData.formsBtns.length;
         this.lblFormFilters.visible = this.formBtns.visible;
         this.additionalCheckBox.selected = this._initData.additionalCheckBoxData.selected;
         this.additionalCheckBox.visible = this.lblAdditional.visible = this._initData.additionalEnabled;
         invalidateData();
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      public function as_enableDefBtn(param1:Boolean) : void
      {
         this.btnDefault.enabled = param1;
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         if(this.ddlGroups.visible)
         {
            _loc1_.push(this.ddlGroups);
         }
         _loc1_.push(this.btnDefault,PopOver(wrapper).closeBtn);
         return _loc1_;
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
         var _loc3_:InteractiveObject = null;
         if(this.ddlGroups.visible)
         {
            _loc3_ = this.ddlGroups;
         }
         if(_loc3_ != null)
         {
            setFocus(_loc3_);
         }
      }
      
      private function onFilterBtnsItemClickHandler(param1:RendererEvent) : void
      {
         onFilterChangeS(param1.index,this.filterBtns.getRendererAt(param1.index).selectable);
      }
      
      private function onFormBtnsItemClickHandler(param1:RendererEvent) : void
      {
         onFormChangeS(param1.index,this.formBtns.getRendererAt(param1.index).selectable);
      }
      
      private function onDdlGroupIndexChangeHandler(param1:ListEvent) : void
      {
         changeGroupS(param1.index);
      }
      
      private function onBtnDefaultClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationEvent(CustomizationEvent.RESET_FILTER,true));
         setDefaultFilterS();
      }
      
      private function onDdlGroupTypeMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.ddlGroups.enabled)
         {
            this._toolTipMgr.showComplex(this._initData.bonusTypeDisableTooltip);
         }
      }
      
      private function onDdlGroupTypeMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onAdditionalCheckBoxSelectHandler(param1:Event) : void
      {
         setHideOnAnotherVehS(this.additionalCheckBox.selected);
      }
   }
}
