package net.wg.gui.lobby.vehicleCustomization
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemPopoverHeaderVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverItemRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
   import net.wg.infrastructure.base.meta.ICustomizationItemsPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationItemsPopoverMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class CustomizationItemsPopover extends CustomizationItemsPopoverMeta implements ICustomizationItemsPopoverMeta
   {
      
      private static const WIDTH:int = 420;
      
      private static const HEIGHT:int = 390;
      
      private static const CLEAR_STATE_INVALID:String = "ClearStateInvalid";
       
      
      public var titleTF:TextField;
      
      public var clearTF:TextField;
      
      public var counterTf:TextField;
      
      public var clearBtn:BlackButton;
      
      public var unclearBtn:BlackButton;
      
      public var table:SortableTable;
      
      public var nonHistoricCheckBox:CheckBox = null;
      
      public var backgroundImage:UILoaderAlt = null;
      
      private var _headerData:CustomizationItemPopoverHeaderVO;
      
      private var _dataProvider:IDataProvider;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isClear:Boolean = false;
      
      private var _clearMsg:String = "";
      
      public function CustomizationItemsPopover()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
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
         this.clearBtn.mouseEnabledOnDisabled = true;
         this.clearBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         this.clearBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ASSET_1;
         this.clearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_NONHISTORIC_BUTTONTEXT_REMOVEFROMALL;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.unclearBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATION_NONHISTORIC_BUTTONCLEARTEXT;
         this.unclearBtn.addEventListener(MouseEvent.CLICK,this.onUnclearBtnClickHandler);
         this.counterTf.autoSize = TextFieldAutoSize.LEFT;
         this.nonHistoricCheckBox.autoSize = TextFieldAutoSize.LEFT;
         this.nonHistoricCheckBox.addEventListener(ButtonEvent.CLICK,this.onNonHictoricClickHandler);
         this.nonHistoricCheckBox.addEventListener(MouseEvent.ROLL_OVER,this.onNonHictoricOverHandler);
         this.nonHistoricCheckBox.addEventListener(MouseEvent.ROLL_OUT,this.onNonHictoricOutHandler);
         this.counterTf.addEventListener(MouseEvent.ROLL_OVER,this.onNonHictoricOverHandler);
         this.counterTf.addEventListener(MouseEvent.ROLL_OUT,this.onNonHictoricOutHandler);
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
            this.nonHistoricCheckBox.label = this._headerData.checkBoxText;
            this.backgroundImage.source = this._headerData.currentSeasonImage;
            this.counterTf.htmlText = this._headerData.counterText;
            this.nonHistoricCheckBox.validateNow();
            this.counterTf.x = this.nonHistoricCheckBox.x + this.nonHistoricCheckBox.width ^ 0;
         }
         if(isInvalid(CLEAR_STATE_INVALID))
         {
            this.clearTF.htmlText = this._clearMsg;
            this.table.listVisible = !this._isClear;
            this.clearTF.visible = this._isClear;
            this.clearBtn.enabled = !this._isClear;
            this.unclearBtn.visible = this._isClear && this.nonHistoricCheckBox.selected;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         App.stage.dispatchEvent(new CustomizationEvent(CustomizationEvent.ITEMS_POPOVER_CLOSED));
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr = null;
         this.counterTf.removeEventListener(MouseEvent.ROLL_OVER,this.onNonHictoricOverHandler);
         this.counterTf.removeEventListener(MouseEvent.ROLL_OUT,this.onNonHictoricOutHandler);
         this.nonHistoricCheckBox.removeEventListener(ButtonEvent.CLICK,this.onNonHictoricClickHandler);
         this.nonHistoricCheckBox.removeEventListener(MouseEvent.ROLL_OVER,this.onNonHictoricOverHandler);
         this.nonHistoricCheckBox.removeEventListener(MouseEvent.ROLL_OUT,this.onNonHictoricOutHandler);
         this.nonHistoricCheckBox.dispose();
         this.nonHistoricCheckBox = null;
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.table.removeEventListener(CustomizationIndicatorEvent.REMOVAL,this.onTableDeleteItemRemovalHandler);
         this.table.dispose();
         this.table = null;
         this.unclearBtn.removeEventListener(MouseEvent.CLICK,this.onUnclearBtnClickHandler);
         this.unclearBtn.dispose();
         this.unclearBtn = null;
         this._headerData.dispose();
         this._headerData = null;
         this.backgroundImage.dispose();
         this.backgroundImage = null;
         this._dataProvider = null;
         this.clearTF = null;
         this.titleTF = null;
         this.counterTf = null;
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
      
      private function onNonHictoricClickHandler(param1:Event) : void
      {
         showOnlyNonHistoricS(this.nonHistoricCheckBox.selected);
      }
      
      private function onNonHictoricOverHandler(param1:Event) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_NONHISTORIC_ITEM,null);
      }
      
      private function onNonHictoricOutHandler(param1:Event) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onUnclearBtnClickHandler(param1:Event) : void
      {
         this.nonHistoricCheckBox.selected = false;
         showOnlyNonHistoricS(this.nonHistoricCheckBox.selected);
      }
      
      private function onTableDeleteItemRemovalHandler(param1:CustomizationIndicatorEvent) : void
      {
         removeS(param1.id,param1.itemsList);
      }
   }
}
