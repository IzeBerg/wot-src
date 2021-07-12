package net.wg.gui.lobby.linkedSet.popups
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.controls.VehicleSelectorNavigator;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.infrastructure.base.meta.IVehicleListPopupMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleListPopupMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.utils.Padding;
   
   public class VehicleListPopup extends VehicleListPopupMeta implements IVehicleListPopupMeta
   {
      
      private static const INVALID_INFO:String = "invalidInfo";
      
      private static const INVALID_LIST:String = "invalidList";
      
      private static const INVALID_FILTERS_DATA:String = "invalidFiltersData";
       
      
      public var infoTF:TextField;
      
      public var selectButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      public var list:ScrollingListWithDisRenderers;
      
      public var nationDD:DropDownImageText;
      
      public var vehicleTypeDD:DropDownImageText;
      
      private var _selectedItemVO:VehicleSelectorItemVO;
      
      private var _dp:DataProvider = null;
      
      private var _filtersData:VehicleSelectorFilterVO = null;
      
      private var _changeHandlersInited:Boolean = false;
      
      public function VehicleListPopup()
      {
         super();
      }
      
      private static function onControllOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoTF.mouseEnabled = false;
         this.infoTF.visible = false;
         this.selectButton.enabled = false;
         this.selectButton.addEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.list.visible = true;
         this.list.smartScrollBar = true;
         this.list.setSelectionNavigator(new VehicleSelectorNavigator());
         this.list.addEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.onListSelectVehicleHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = CYBERSPORT.WINDOW_VEHICLESELECTOR_TITLE;
      }
      
      private function initChangeHandlers() : void
      {
         this.nationDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChangedHandler);
         this.vehicleTypeDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChangedHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OVER,this.onControllOverHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OVER,this.onControllOverHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OUT,onControllOutHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OUT,onControllOutHandler);
      }
      
      private function updateSelectedIndex(param1:DropDownImageText, param2:Object) : void
      {
         param1.selectedIndex = 0;
         var _loc3_:uint = param1.dataProvider.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.dataProvider[_loc4_].data == param2)
            {
               param1.selectedIndex = _loc4_;
               return;
            }
            _loc4_++;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_INFO))
         {
            this.list.visible = false;
            this.infoTF.visible = true;
         }
         if(this._dp && isInvalid(INVALID_LIST))
         {
            this.list.dataProvider = this._dp;
            this.list.dataProvider.invalidate();
            this.list.visible = true;
            this.infoTF.visible = false;
         }
         if(this._filtersData && isInvalid(INVALID_FILTERS_DATA))
         {
            this.nationDD.dataProvider = this._filtersData.nationDP;
            this.vehicleTypeDD.dataProvider = this._filtersData.vehicleTypesDP;
            this.updateSelectedIndex(this.nationDD,this._filtersData.nation);
            this.updateSelectedIndex(this.vehicleTypeDD,this._filtersData.vehicleType);
            if(!this._changeHandlersInited)
            {
               this._changeHandlersInited = true;
               this.initChangeHandlers();
            }
         }
      }
      
      public function as_setInfoText(param1:String) : void
      {
         this.infoTF.text = param1;
         invalidate(INVALID_INFO);
      }
      
      override protected function setListData(param1:DataProvider, param2:Array) : void
      {
         if(this.list.dataProvider)
         {
            this._selectedItemVO = null;
         }
         this._dp = param1;
         invalidate(INVALID_LIST);
      }
      
      override protected function setFiltersData(param1:VehicleSelectorFilterVO) : void
      {
         this._filtersData = param1;
         invalidate(INVALID_FILTERS_DATA);
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1)
         {
            param1.formBgPadding = new Padding(33,11,13,10);
            param1.contentPadding = new Padding(43,14,17,15);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.selectButton.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChangedHandler);
         this.vehicleTypeDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChangedHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OVER,this.onControllOverHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OVER,this.onControllOverHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OUT,onControllOutHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OUT,onControllOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.selectButton.dispose();
         this.cancelButton.dispose();
         this.selectButton = null;
         this.cancelButton = null;
         this.nationDD.dispose();
         this.vehicleTypeDD.dispose();
         this.nationDD = null;
         this.vehicleTypeDD = null;
         this.list.removeEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.onListSelectVehicleHandler);
         this.list.dispose();
         this.list = null;
         this.infoTF = null;
         this._selectedItemVO = null;
         if(this._dp)
         {
            this._dp.cleanUp();
            this._dp = null;
         }
         this._filtersData = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.list);
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onSelectButtonClickHandler(param1:ButtonEvent) : void
      {
         onSelectVehiclesS(this._selectedItemVO.intCD);
      }
      
      private function onListSelectVehicleHandler(param1:VehicleSelectorItemEvent) : void
      {
         var _loc3_:VehicleSelectorItemVO = null;
         var _loc2_:VehicleSelectorItemVO = param1.data;
         if(_loc2_)
         {
            this._selectedItemVO = _loc2_;
            for each(_loc3_ in this.list.dataProvider)
            {
               if(_loc3_ != _loc2_)
               {
                  _loc3_.selected = false;
               }
            }
         }
         this.selectButton.enabled = true;
      }
      
      private function onFiltersChangedHandler(param1:Event = null) : void
      {
         this.list.selectedIndex = -1;
         this.selectButton.enabled = false;
         var _loc2_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
         var _loc3_:Object = this.vehicleTypeDD.dataProvider.requestItemAt(this.vehicleTypeDD.selectedIndex);
         var _loc4_:int = Boolean(_loc2_) ? int(_loc2_.data) : int(-1);
         var _loc5_:String = Boolean(_loc3_) ? _loc3_.data : null;
         applyFiltersS(_loc4_,_loc5_);
      }
      
      private function onControllOverHandler(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.nationDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_NATION);
               break;
            case this.vehicleTypeDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHTYPE);
         }
      }
   }
}
