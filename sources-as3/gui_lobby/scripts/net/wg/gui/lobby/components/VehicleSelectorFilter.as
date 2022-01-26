package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.VEHICLE_SELECTOR_CONSTANTS;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.interfaces.IVehicleSelectorFilter;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   
   public class VehicleSelectorFilter extends UIComponentEx implements IVehicleSelectorFilter
   {
      
      public static const MODE_USER_VEHICLES:String = "userVehicles";
      
      public static const MODE_ALL_VEHICLES:String = "allVehicles";
      
      private static const INVALID_MODE:String = "invalidMode";
      
      private static const CONTROLS_GAP:int = 2;
      
      private static const LENGTH_NOT_EQUAL:String = "Lengths of vectors are not equal";
       
      
      public var levelDD:DropDownImageText;
      
      public var nationDD:DropDownImageText;
      
      public var vehicleTypeDD:DropDownImageText;
      
      public var mainCheckBox:CheckBox;
      
      public var compatibleOnlyCheckBox:CheckBox;
      
      private var _model:IVehicleSelectorFilterVO;
      
      private var _mode:String = "allVehicles";
      
      private var _changeHandlersInited:Boolean = false;
      
      private var _controlsOrder:Vector.<DisplayObject> = null;
      
      private var _controlsOrderMask:Vector.<int> = null;
      
      public function VehicleSelectorFilter()
      {
         super();
         this._controlsOrder = new Vector.<DisplayObject>();
         this._controlsOrderMask = new Vector.<int>();
         this._controlsOrder.push(this.levelDD);
         this._controlsOrderMask.push(VEHICLE_SELECTOR_CONSTANTS.VISIBLE_LEVEL);
         this._controlsOrder.push(this.nationDD);
         this._controlsOrderMask.push(VEHICLE_SELECTOR_CONSTANTS.VISIBLE_NATION);
         this._controlsOrder.push(this.vehicleTypeDD);
         this._controlsOrderMask.push(VEHICLE_SELECTOR_CONSTANTS.VISIBLE_VEHICLE_TYPE);
         this._controlsOrder.push(this.mainCheckBox);
         this._controlsOrderMask.push(VEHICLE_SELECTOR_CONSTANTS.VISIBLE_IS_MAIN);
         App.utils.asserter.assert(this._controlsOrder.length == this._controlsOrderMask.length,LENGTH_NOT_EQUAL);
      }
      
      private static function onFiltersRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._mode && isInvalid(INVALID_MODE))
         {
            gotoAndStop(this._mode);
         }
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.vehicleTypeDD.dataProvider = this._model.vehicleTypesDP;
            this.vehicleTypeDD.selectedIndex = 0;
            this.levelDD.dataProvider = this._model.levelsDP;
            this.levelDD.selectedIndex = 0;
            this.nationDD.dataProvider = this._model.nationDP;
            this.nationDD.selectedIndex = 0;
            this.selectNation(this._model.nation);
            this.selectVehicleType(this._model.vehicleType);
            this.selectLevel(this._model.level);
            if(this._mode == MODE_USER_VEHICLES)
            {
               this.mainCheckBox.selected = this._model.isMain;
            }
            this.compatibleOnlyCheckBox.selected = this._model.compatibleOnly;
            this.compatibleOnlyCheckBox.label = this._model.compatibleOnlyLabel;
            if(!this._changeHandlersInited)
            {
               this.initChangeHandlers();
               this._changeHandlersInited = true;
               this.onFiltersIndexChangeHandler();
            }
            this.updateVisibility();
         }
      }
      
      override protected function onDispose() : void
      {
         this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.vehicleTypeDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.levelDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.mainCheckBox.removeEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.compatibleOnlyCheckBox.removeEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.levelDD.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.levelDD.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.vehicleTypeDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.levelDD.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.mainCheckBox.removeEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this._controlsOrder.splice(0,this._controlsOrder.length);
         this._controlsOrder = null;
         this._controlsOrderMask.splice(0,this._controlsOrderMask.length);
         this._controlsOrderMask = null;
         this.nationDD.dispose();
         this.vehicleTypeDD.dispose();
         this.levelDD.dispose();
         this.mainCheckBox.dispose();
         this.compatibleOnlyCheckBox.dispose();
         this.levelDD = null;
         this.nationDD = null;
         this.vehicleTypeDD = null;
         this.mainCheckBox = null;
         this.compatibleOnlyCheckBox = null;
         this._model = null;
         super.onDispose();
      }
      
      public function setData(param1:IVehicleSelectorFilterVO) : void
      {
         this._model = param1;
         invalidate(InvalidationType.DATA);
      }
      
      protected function updateVisibility() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:DisplayObject = null;
         var _loc1_:int = 0;
         _loc2_ = true;
         _loc3_ = null;
         var _loc4_:int = this._model.visibility;
         var _loc5_:int = this._controlsOrder.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = this._controlsOrder[_loc6_];
            _loc2_ = Boolean(this._controlsOrderMask[_loc6_] & _loc4_);
            _loc3_.x = _loc1_;
            _loc3_.visible = _loc2_;
            if(_loc2_)
            {
               _loc1_ += _loc3_.width + CONTROLS_GAP;
            }
            _loc6_++;
         }
         this.compatibleOnlyCheckBox.visible = Boolean(_loc4_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_COMPATIBLE_ONLY);
      }
      
      private function initChangeHandlers() : void
      {
         this.nationDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.vehicleTypeDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.levelDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersIndexChangeHandler);
         this.mainCheckBox.addEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.compatibleOnlyCheckBox.addEventListener(Event.SELECT,this.onFiltersIndexChangeHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.levelDD.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.mainCheckBox.addEventListener(MouseEvent.ROLL_OVER,this.onFiltersRollOverHandler);
         this.nationDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.levelDD.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.mainCheckBox.addEventListener(MouseEvent.ROLL_OUT,onFiltersRollOutHandler);
         this.nationDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.vehicleTypeDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.levelDD.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
         this.mainCheckBox.addEventListener(MouseEvent.CLICK,onFiltersRollOutHandler);
      }
      
      private function selectNation(param1:int) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.nationDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.nationDD.selectedIndex = this.nationDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      private function selectVehicleType(param1:String) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.vehicleTypeDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.vehicleTypeDD.selectedIndex = this.vehicleTypeDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      private function selectLevel(param1:int) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.levelDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.levelDD.selectedIndex = this.levelDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function set mode(param1:String) : void
      {
         this._mode = param1;
         invalidate(INVALID_MODE);
      }
      
      private function onFiltersIndexChangeHandler(param1:Event = null) : void
      {
         App.toolTipMgr.hide();
         var _loc2_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
         var _loc3_:Object = this.vehicleTypeDD.dataProvider.requestItemAt(this.vehicleTypeDD.selectedIndex);
         var _loc4_:Object = this.levelDD.dataProvider.requestItemAt(this.levelDD.selectedIndex);
         var _loc5_:VehicleSelectorFilterEvent = new VehicleSelectorFilterEvent(VehicleSelectorFilterEvent.CHANGE,true);
         _loc5_.nation = Boolean(_loc2_) ? int(_loc2_.data) : int(-1);
         _loc5_.vehicleType = Boolean(_loc3_) ? _loc3_.data : null;
         _loc5_.level = Boolean(_loc4_) ? int(_loc4_.data) : int(-1);
         _loc5_.isMain = this.mainCheckBox.selected;
         _loc5_.compatibleOnly = this.compatibleOnlyCheckBox.selected;
         dispatchEvent(_loc5_);
      }
      
      private function onFiltersRollOverHandler(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.nationDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_NATION);
               break;
            case this.vehicleTypeDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHTYPE);
               break;
            case this.levelDD:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHLVL);
               break;
            case this.mainCheckBox:
               App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_MAINVEHICLE);
         }
      }
   }
}
