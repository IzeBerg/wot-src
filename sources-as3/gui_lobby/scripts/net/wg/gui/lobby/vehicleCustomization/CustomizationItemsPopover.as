package net.wg.gui.lobby.vehicleCustomization
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemPopoverHeaderVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverItemRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
   import net.wg.infrastructure.base.meta.ICustomizationItemsPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationItemsPopoverMeta;
   import net.wg.utils.IUniversalBtnStyles;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class CustomizationItemsPopover extends CustomizationItemsPopoverMeta implements ICustomizationItemsPopoverMeta
   {
      
      private static const WIDTH:int = 420;
      
      private static const HEIGHT:int = 422;
      
      private static const CLEAR_STATE_INVALID:String = "ClearStateInvalid";
      
      private static const FILTER_STATE_INVALID:String = "filterStateInvalid";
       
      
      public var titleTF:TextField;
      
      public var clearTF:TextField;
      
      public var table:SortableTable;
      
      public var clearBtn:UniversalBtn;
      
      public var historicBtn:UniversalBtn;
      
      public var nonHistoricBtn:UniversalBtn;
      
      public var fantasticalBtn:UniversalBtn;
      
      public var backgroundImage:UILoaderAlt;
      
      private var _headerData:CustomizationItemPopoverHeaderVO;
      
      private var _dataProvider:IDataProvider;
      
      private var _isClear:Boolean = false;
      
      private var _clearMsg:String = "";
      
      public function CustomizationItemsPopover()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:IUniversalBtnStyles = App.utils.universalBtnStyles;
         _loc1_.setStyle(this.clearBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.historicBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.nonHistoricBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.fantasticalBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(CustomizationPopoverItemRendererVO);
         this.table.listDP = this._dataProvider;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.isSortable = true;
         this.table.isListSelectable = false;
         this.table.addEventListener(CustomizationIndicatorEvent.REMOVAL,this.onTableDeleteItemRemovalHandler);
         this.clearTF.autoSize = TextFieldAutoSize.CENTER;
         this.clearTF.multiline = true;
         this.clearTF.wordWrap = true;
         this.clearBtn.mouseEnabledOnDisabled = true;
         this.clearBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         this.clearBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ASSET_1;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.historicBtn.toggle = true;
         this.historicBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_HIST_SMALL;
         this.historicBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_HISTORIC_TOOLTIP;
         this.historicBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.nonHistoricBtn.toggle = true;
         this.nonHistoricBtn.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL_MINI;
         this.nonHistoricBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_NONHISTORIC_TOOLTIP;
         this.nonHistoricBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.fantasticalBtn.toggle = true;
         this.fantasticalBtn.iconSource = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_FANTASTICAL_MINI;
         this.fantasticalBtn.tooltip = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_POPOVERFILTER_FANTASTIC_TOOLTIP;
         this.fantasticalBtn.addEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._headerData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._headerData.title;
            this.backgroundImage.source = this._headerData.currentSeasonImage;
         }
         if(isInvalid(CLEAR_STATE_INVALID))
         {
            this.clearTF.htmlText = this._clearMsg;
            this.table.listVisible = !this._isClear;
            this.clearTF.visible = this._isClear;
            this.clearBtn.enabled = !this._isClear;
         }
         if(isInvalid(FILTER_STATE_INVALID))
         {
            if(this.historicBtn.selected || this.nonHistoricBtn.selected || this.fantasticalBtn.selected)
            {
               this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CLEARBUTTON_LABEL_REMOVE;
            }
            else
            {
               this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CLEARBUTTON_LABEL_REMOVEALL;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         App.stage.dispatchEvent(new CustomizationEvent(CustomizationEvent.ITEMS_POPOVER_CLOSED));
         this.historicBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.nonHistoricBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.fantasticalBtn.removeEventListener(ButtonEvent.CLICK,this.onFilterToggleBtnClickHandler);
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.table.removeEventListener(CustomizationIndicatorEvent.REMOVAL,this.onTableDeleteItemRemovalHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.historicBtn.dispose();
         this.historicBtn = null;
         this.nonHistoricBtn.dispose();
         this.nonHistoricBtn = null;
         this.fantasticalBtn.dispose();
         this.fantasticalBtn = null;
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.table.dispose();
         this.table = null;
         this._headerData.dispose();
         this._headerData = null;
         this.backgroundImage.dispose();
         this.backgroundImage = null;
         this._dataProvider = null;
         this.clearTF = null;
         this.titleTF = null;
         super.onDispose();
      }
      
      override protected function setHeaderData(param1:CustomizationItemPopoverHeaderVO) : void
      {
         this._headerData = param1;
         invalidateData();
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_showClearMessage(param1:Boolean, param2:String) : void
      {
         this._isClear = param1;
         this._clearMsg = param2;
         invalidate(CLEAR_STATE_INVALID);
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         removeAllS();
      }
      
      private function onFilterToggleBtnClickHandler(param1:ButtonEvent) : void
      {
         onFilterChangedS(this.historicBtn.selected,this.nonHistoricBtn.selected,this.fantasticalBtn.selected);
         invalidate(FILTER_STATE_INVALID);
      }
      
      private function onTableDeleteItemRemovalHandler(param1:CustomizationIndicatorEvent) : void
      {
         removeS(param1.id,param1.itemsList);
      }
   }
}
