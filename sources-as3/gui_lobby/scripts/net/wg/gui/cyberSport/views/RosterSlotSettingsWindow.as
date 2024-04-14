package net.wg.gui.cyberSport.views
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.cyberSport.controls.VehicleSelector;
   import net.wg.gui.cyberSport.controls.data.CSVehicleButtonSelectionVO;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.cyberSport.data.RosterSlotSettingsWindowStaticVO;
   import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
   import net.wg.gui.cyberSport.vo.RosterLimitsVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.IRosterSlotSettingsWindowMeta;
   import net.wg.infrastructure.base.meta.impl.RosterSlotSettingsWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.utils.INations;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class RosterSlotSettingsWindow extends RosterSlotSettingsWindowMeta implements IRosterSlotSettingsWindowMeta
   {
      
      private static const TAB_SELECTION_INVALIDATION_TYPE:String = "tabSelectionInvalidationType";
      
      private static const VEHICLE_SELECTOR_LIST_HEIGHT:int = 172;
       
      
      public var viewStack:ViewStack;
      
      public var buttonBar:ButtonBarEx;
      
      public var submitBtn:SoundButtonEx;
      
      public var cancelBtn:SoundButtonEx;
      
      public var selectedTxt:TextField;
      
      public var selectedResultBtn:CSVehicleButton;
      
      public var refreshBtn:ButtonIconTextTransparent;
      
      public var headerText:TextField;
      
      private var _staticData:RosterSlotSettingsWindowStaticVO = null;
      
      private var _rangeModel:SettingRosterVO = null;
      
      private var _rangeLimits:RosterLimitsVO = null;
      
      private var _vehicleSelector:VehicleSelector;
      
      private var _rangeRoster:RangeRosterSettingsView;
      
      private var _listData:DataProvider;
      
      private var _selectTabIndex:int = -1;
      
      public function RosterSlotSettingsWindow()
      {
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         this.tryRemoveWindowListeners();
         super.setWindow(param1);
         if(window != null)
         {
            window.addEventListener(WindowEvent.SCALE_X_CHANGED,this.onWindowScaleChangedHandler);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleChangedHandler);
         }
      }
      
      override protected function setVehicleSelection(param1:VehicleVO) : void
      {
         this.setVehicleSelectionResult(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._selectTabIndex >= 0 && isInvalid(TAB_SELECTION_INVALIDATION_TYPE))
         {
            this.buttonBar.selectedIndex = this._selectTabIndex;
         }
      }
      
      override protected function setRosterLimits(param1:RosterLimitsVO) : void
      {
         this._rangeLimits = param1;
         if(this._rangeRoster != null)
         {
            this._rangeRoster.setLevelLimits(this._rangeLimits.minLevel,this._rangeLimits.maxLevel);
         }
      }
      
      override protected function setRangeSelection(param1:SettingRosterVO) : void
      {
         this.updateRangeModel(param1);
         if(this._rangeRoster != null)
         {
            this._rangeRoster.setDefaultState(false);
            this._rangeRoster.update(this._rangeModel);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.visible = false;
         showWindowBgForm = false;
      }
      
      override protected function setStaticData(param1:RosterSlotSettingsWindowStaticVO) : void
      {
         this._staticData = param1;
         window.title = param1.windowTitle;
         this.headerText.htmlText = param1.headerText;
         this.selectedTxt.htmlText = param1.selectedTxt;
         this.submitBtn.label = param1.submitBtnLabel;
         this.cancelBtn.label = param1.cancelBtnLabel;
         if(this.buttonBar.dataProvider != null)
         {
            this.buttonBar.dataProvider.cleanUp();
         }
         this.buttonBar.dataProvider = new DataProvider(param1.buttonBarItems);
         TextFieldEx.setVerticalAlign(this.headerText,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._rangeModel == null)
         {
            this._rangeModel = new SettingRosterVO({});
            this.setDefaultRange();
         }
         this.selectedResultBtn.mouseEnabled = false;
         this.selectedResultBtn.mouseChildren = false;
         this.selectedResultBtn.clickableAreaEnable = false;
         this.selectedResultBtn.enabled = false;
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onRefreshBtnClickHandler);
         this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
         this.viewStack.targetGroup = this.buttonBar.name;
         this.viewStack.cache = true;
         this.selectedTxt.mouseEnabled = false;
         this.headerText.addEventListener(MouseEvent.ROLL_OVER,this.onHeaderTextRollOverHandler);
         this.headerText.addEventListener(MouseEvent.ROLL_OUT,this.onHeaderTextRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.tryRemoveWindowListeners();
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onRefreshBtnClickHandler);
         this.refreshBtn.dispose();
         this.refreshBtn = null;
         this.headerText.removeEventListener(MouseEvent.ROLL_OVER,this.onHeaderTextRollOverHandler);
         this.headerText.removeEventListener(MouseEvent.ROLL_OUT,this.onHeaderTextRollOutHandler);
         this.headerText = null;
         this.selectedTxt = null;
         this._staticData = null;
         this._rangeLimits = null;
         if(this.selectedResultBtn != null)
         {
            this.selectedResultBtn.dispose();
            this.selectedResultBtn = null;
         }
         if(this._rangeRoster != null)
         {
            this._rangeRoster.removeEventListener(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this.onRangeRosterChangedHandler);
            this._rangeRoster = null;
         }
         if(this._vehicleSelector != null)
         {
            this._vehicleSelector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onVehicleSelectorSelectionChangedHandler);
            this._vehicleSelector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onVehicleSelectorChangeHandler);
            this._vehicleSelector = null;
         }
         this.tryClearRangeModel();
         this._listData = null;
         this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         if(this.buttonBar != null)
         {
            this.buttonBar.dispose();
            this.buttonBar = null;
         }
         super.onDispose();
      }
      
      override protected function updateVehicleFilters(param1:VehicleSelectorFilterVO) : void
      {
         this._vehicleSelector.setFiltersData(param1);
      }
      
      override protected function setListData(param1:DataProvider) : void
      {
         var _loc2_:Array = null;
         var _loc3_:INations = null;
         var _loc4_:VehicleSelectorItemVO = null;
         if(param1 != null)
         {
            _loc2_ = App.utils.getGUINationsS();
            _loc3_ = App.utils.nations;
            for each(_loc4_ in param1)
            {
               _loc4_.nationOrderIdx = _loc2_.indexOf(_loc3_.getNationName(_loc4_.nationID));
            }
            this._listData = param1;
            if(initialized)
            {
               this.updateWindowVisibility(true);
            }
         }
         if(this._vehicleSelector != null)
         {
            this._vehicleSelector.setListItems(this._listData);
         }
      }
      
      public function as_resetSelection() : void
      {
         this.resetSelectionResult();
         this.setDefaultRange();
         if(this._rangeRoster != null)
         {
            this._rangeRoster.setDefaultState(false);
         }
      }
      
      public function as_selectTab(param1:int) : void
      {
         this._selectTabIndex = param1;
         invalidate(TAB_SELECTION_INVALIDATION_TYPE);
      }
      
      private function tryRemoveWindowListeners() : void
      {
         if(window != null)
         {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED,this.onWindowScaleChangedHandler);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleChangedHandler);
         }
      }
      
      private function setVehicleSelectionResult(param1:VehicleVO) : void
      {
         this.setSelectionResultBtnVisible(true);
         this.selectedResultBtn.setVehicle(param1);
      }
      
      private function resetSelectionResult() : void
      {
         this.selectedResultBtn.reset();
         this.setSelectionResultBtnVisible(false);
      }
      
      private function updateWindowVisibility(param1:Boolean) : void
      {
         if(window.visible != param1)
         {
            window.visible = param1;
         }
      }
      
      private function updateRangeModel(param1:SettingRosterVO) : void
      {
         if(param1 != this._rangeModel)
         {
            this.tryClearRangeModel();
            this._rangeModel = param1;
         }
      }
      
      private function tryClearRangeModel() : void
      {
         if(this._rangeModel != null)
         {
            this._rangeModel.dispose();
            this._rangeModel = null;
         }
      }
      
      private function setDefaultRange() : void
      {
         if(this._rangeModel != null)
         {
            this._rangeModel.clearRange();
            this._rangeModel.vLevelRange = [];
            this._rangeModel.nationIDRange = [];
            this._rangeModel.vTypeRange = [];
         }
      }
      
      private function isDefaultRange() : Boolean
      {
         if(this._rangeModel == null)
         {
            return true;
         }
         return this.isArrayEmpty(this._rangeModel.nationIDRange) && this.isArrayEmpty(this._rangeModel.vTypeRange) && this.isArrayEmpty(this._rangeModel.vLevelRange);
      }
      
      private function isArrayEmpty(param1:Array) : Boolean
      {
         return param1 == null || param1.length == 0;
      }
      
      private function setSelectionResultBtnVisible(param1:Boolean) : void
      {
         if(this.selectedResultBtn.visible != param1)
         {
            this.selectedResultBtn.visible = param1;
         }
      }
      
      private function submitResult() : void
      {
         var _loc1_:CSVehicleButtonSelectionVO = this.selectedResultBtn.getModel();
         submitButtonHandlerS(_loc1_);
         _loc1_.dispose();
      }
      
      private function onHeaderTextRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._staticData != null ? this._staticData.headerTextTooltip : null;
         if(StringUtils.isNotEmpty(_loc2_))
         {
            App.toolTipMgr.showComplex(_loc2_,null);
         }
      }
      
      private function onHeaderTextRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onWindowScaleChangedHandler(param1:WindowEvent) : void
      {
         if(param1.type == WindowEvent.SCALE_X_CHANGED)
         {
            window.width = param1.prevValue;
         }
         else
         {
            window.height = param1.prevValue;
         }
      }
      
      private function onViewStackNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         if(param1.viewId == CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW)
         {
            this._rangeRoster = RangeRosterSettingsView(param1.view);
            this._rangeRoster.setLevelLimits(this._rangeLimits.minLevel,this._rangeLimits.maxLevel);
            this._rangeRoster.update(this._rangeModel);
            this._rangeRoster.addEventListener(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this.onRangeRosterChangedHandler);
         }
         else if(param1.viewId == CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW)
         {
            if(this._vehicleSelector)
            {
               return;
            }
            this._vehicleSelector = VehicleSelector(param1.view);
            this._vehicleSelector.listHeight = VEHICLE_SELECTOR_LIST_HEIGHT;
            this._vehicleSelector.validateNow();
            requestVehicleFiltersS();
            this._vehicleSelector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onVehicleSelectorSelectionChangedHandler);
            this._vehicleSelector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onVehicleSelectorChangeHandler);
            if(this._listData != null)
            {
               this._vehicleSelector.setListItems(this._listData);
            }
         }
      }
      
      private function onVehicleSelectorChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         onFiltersUpdateS(param1.nation,param1.vehicleType,param1.isMain,param1.level,param1.compatibleOnly);
      }
      
      private function onRangeRosterChangedHandler(param1:RosterSettingsEvent) : void
      {
         this.updateRangeModel(SettingRosterVO(param1.data));
         this.setSelectionResultBtnVisible(!this.isDefaultRange());
         this.selectedResultBtn.setRangeData(this._rangeModel);
         this.updateWindowVisibility(true);
      }
      
      private function onRefreshBtnClickHandler(param1:ButtonEvent) : void
      {
         this.resetSelectionResult();
         this.setDefaultRange();
         if(this._rangeRoster != null)
         {
            this._rangeRoster.update(this._rangeModel);
         }
      }
      
      private function onVehicleSelectorSelectionChangedHandler(param1:VehicleSelectorEvent) : void
      {
         if(param1.selectedDescriptors && param1.selectedDescriptors.length > 0)
         {
            if(this._rangeRoster != null)
            {
               this.setDefaultRange();
               this._rangeRoster.setDefaultState(false);
            }
            this.setVehicleSelectionResult(VehicleVO(param1.selectedObjects[0]));
            if(param1.forceSelect)
            {
               setFocus(this);
               this.submitResult();
            }
         }
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         this.submitResult();
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         cancelButtonHandlerS();
      }
   }
}
