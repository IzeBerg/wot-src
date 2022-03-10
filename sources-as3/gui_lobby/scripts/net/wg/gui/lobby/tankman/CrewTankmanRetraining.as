package net.wg.gui.lobby.tankman
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class CrewTankmanRetraining extends UIComponentEx implements IViewStackContent
   {
      
      private static const UPDATE_DATA:String = "updateData";
      
      private static const RETRAINING_BTNS_GROUP_NAME:String = "retrainingButtonGroup";
      
      private static const VEHICLE_GROUP_NAME:String = "vehicleGroup";
      
      private static const VEHICLE_DD_LABELFIELD:String = "userName";
      
      private static const BTN_LIGHT_TANK:String = "lightTankBtn";
      
      private static const BTN_MEDIUM_TANK:String = "mediumTankBtn";
      
      private static const BTN_HEAVY_TANK:String = "heavyTankBtn";
      
      private static const BTN_AT_SPG:String = "at_spgBtn";
      
      private static const BTN_SPG:String = "spgBtn";
      
      private static const VEHICLE_DD:String = "vehiclesDropdown";
      
      private static const BTN_RESET:String = "btnReset";
      
      private static const NO_VEHICLE_ID:int = -1;
       
      
      public var btnRetraining:SoundButtonEx;
      
      public var lightTankBtn:VehicleTypeButton = null;
      
      public var mediumTankBtn:VehicleTypeButton = null;
      
      public var heavyTankBtn:VehicleTypeButton = null;
      
      public var at_spgBtn:VehicleTypeButton = null;
      
      public var spgBtn:VehicleTypeButton = null;
      
      public var btnAcademy:TankmanTrainingSmallButton = null;
      
      public var btnScool:TankmanTrainingSmallButton = null;
      
      public var btnCourses:TankmanTrainingSmallButton = null;
      
      public var vehiclesDropdown:DropdownMenu = null;
      
      public var btnReset:SoundButtonEx = null;
      
      private var _vehicleGroup:ButtonGroup = null;
      
      private var _retrainingButtonGroup:ButtonGroup = null;
      
      private var _currentSelectedVehicleType:String = null;
      
      private var _currentSelectedCostIndex:int = -1;
      
      private var _retrainingButtons:Vector.<TankmanTrainingSmallButton> = null;
      
      private var _vehicleButtons:Vector.<VehicleTypeButton> = null;
      
      private var _toolTipBindHash:Object;
      
      private var _model:PersonalCaseRetrainingModel = null;
      
      private var _retrainVehicleCD:int = -1;
      
      public function CrewTankmanRetraining()
      {
         this._toolTipBindHash = {};
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleTypeButton = null;
         var _loc2_:TankmanTrainingSmallButton = null;
         this._model = null;
         if(this._vehicleGroup != null)
         {
            this._vehicleGroup.dispose();
         }
         if(this._vehicleButtons != null)
         {
            _loc1_ = null;
            while(this._vehicleButtons.length)
            {
               _loc1_ = this._vehicleButtons.pop();
               this.setToolTipListeners(_loc1_,false);
               _loc1_.removeEventListener(ButtonEvent.CLICK,this.onVehicleTypeButtonClickHandler);
               _loc1_.dispose();
            }
            _loc1_ = null;
            this._vehicleButtons = null;
         }
         if(this._retrainingButtonGroup != null)
         {
            this._retrainingButtonGroup.removeEventListener(Event.CHANGE,this.onRetrainingButtonGroupChangeHandler);
            this._retrainingButtonGroup.dispose();
         }
         if(this._retrainingButtons != null)
         {
            _loc2_ = null;
            while(this._retrainingButtons.length)
            {
               _loc2_ = this._retrainingButtons.pop();
               _loc2_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onRetrainingButtonDoubleClickHandler);
               _loc2_.dispose();
            }
            _loc2_ = null;
            this._retrainingButtons = null;
         }
         this.btnReset.removeEventListener(ButtonEvent.CLICK,this.onBtnResetClickHandler);
         this.btnReset.dispose();
         this.vehiclesDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onVehiclesDropdownIndexChangeHandler);
         this.vehiclesDropdown.dispose();
         this.btnRetraining.removeEventListener(ButtonEvent.CLICK,this.onApplyRetrainingButtonClickHandler);
         this.btnRetraining.dispose();
         this.setToolTipListeners(this.vehiclesDropdown,false);
         this.setToolTipListeners(this.btnReset,false);
         App.utils.data.cleanupDynamicObject(this._toolTipBindHash);
         this._toolTipBindHash = null;
         this.btnRetraining = null;
         this._vehicleGroup = null;
         this.lightTankBtn = null;
         this.mediumTankBtn = null;
         this.heavyTankBtn = null;
         this.at_spgBtn = null;
         this.spgBtn = null;
         this._retrainingButtonGroup = null;
         this.btnAcademy = null;
         this.btnScool = null;
         this.btnCourses = null;
         this.vehiclesDropdown = null;
         this.btnReset = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(UPDATE_DATA))
         {
            this.enableVehicleTypeButton();
            if(!this.isAvailableForRetraining(this._retrainVehicleCD))
            {
               this.autoSelectVehicleType(this._model.nativeVehicle.type);
               this.autoSelectVehicle(this._currentSelectedVehicleType,this._model.nativeVehicle.intCD);
            }
            this.updateResetButton();
            this.updateRetrainingButtons();
         }
      }
      
      private function isAvailableForRetraining(param1:int) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == NO_VEHICLE_ID)
         {
            return false;
         }
         for each(_loc2_ in this._model.vehicles)
         {
            if(_loc2_.intCD == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function configUI() : void
      {
         this.vehiclesDropdown.buttonMode = true;
         this.vehiclesDropdown.disposeDataProvider = false;
         this.setToolTipListeners(this.vehiclesDropdown);
         this.setToolTipListeners(this.btnReset);
         super.configUI();
         this.btnReset.addEventListener(ButtonEvent.CLICK,this.onBtnResetClickHandler);
         this.vehiclesDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onVehiclesDropdownIndexChangeHandler);
         this.btnRetraining.addEventListener(ButtonEvent.CLICK,this.onApplyRetrainingButtonClickHandler);
         this._toolTipBindHash[BTN_LIGHT_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_LIGHT_TANK_BTN;
         this._toolTipBindHash[BTN_MEDIUM_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_MEDIUM_TANK_BTN;
         this._toolTipBindHash[BTN_HEAVY_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_HEAVY_TANK_BTN;
         this._toolTipBindHash[BTN_AT_SPG] = TOOLTIPS.PERSONAL_CASE_TRAINING_AT_SPG_BTN;
         this._toolTipBindHash[BTN_SPG] = TOOLTIPS.PERSONAL_CASE_TRAINING_SPG_BTN;
         this._toolTipBindHash[VEHICLE_DD] = TOOLTIPS.PERSONAL_CASE_TRAINING_TANK;
         this._toolTipBindHash[BTN_RESET] = TOOLTIPS.PERSONAL_CASE_TRAINING_CURRENT_TANK;
         this._vehicleButtons = new <VehicleTypeButton>[this.lightTankBtn,this.mediumTankBtn,this.heavyTankBtn,this.at_spgBtn,this.spgBtn];
         this._retrainingButtonGroup = ButtonGroup.getGroup(RETRAINING_BTNS_GROUP_NAME,this);
         this._retrainingButtonGroup.addEventListener(Event.CHANGE,this.onRetrainingButtonGroupChangeHandler);
         this._retrainingButtons = new <TankmanTrainingSmallButton>[this.btnCourses,this.btnScool,this.btnAcademy];
         var _loc1_:Number = this._retrainingButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._retrainingButtons[_loc2_].groupName = RETRAINING_BTNS_GROUP_NAME;
            this._retrainingButtons[_loc2_].addEventListener(MouseEvent.DOUBLE_CLICK,this.onRetrainingButtonDoubleClickHandler);
            this._retrainingButtons[_loc2_].allowDeselect = false;
            this._retrainingButtons[_loc2_].doubleClickEnabled = true;
            _loc2_++;
         }
         this.initVehicleTypes();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
         this._model = param1 as PersonalCaseRetrainingModel;
         if(!this._model)
         {
            return;
         }
         invalidate(UPDATE_DATA);
      }
      
      private function setToolTipListeners(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
         }
         else
         {
            param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
         }
      }
      
      private function enableVehicleTypeButton() : void
      {
         this.lightTankBtn.enabled = this._model.lightTanks.length > 0;
         this.mediumTankBtn.enabled = this._model.mediumTanks.length > 0;
         this.heavyTankBtn.enabled = this._model.heavyTanks.length > 0;
         this.at_spgBtn.enabled = this._model.AT_SPG.length > 0;
         this.spgBtn.enabled = this._model.SPG.length > 0;
      }
      
      private function updateRetrainingButtons() : void
      {
         var _loc1_:Number = this._retrainingButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._retrainingButtons[_loc2_].setData(this._model.retrainButtonsData[_loc2_]);
            _loc2_++;
         }
         this.autoSelectRetrainingButtons();
      }
      
      private function autoSelectRetrainingButtons() : void
      {
         var _loc1_:Number = this._retrainingButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._retrainingButtons[_loc2_].enabled)
            {
               this._retrainingButtons[_loc2_].selected = true;
               this._currentSelectedCostIndex = _loc2_;
               this.btnRetraining.enabled = true;
               return;
            }
            _loc2_++;
         }
         this.btnRetraining.enabled = false;
      }
      
      private function initVehicleTypes() : void
      {
         this._vehicleGroup = ButtonGroup.getGroup(VEHICLE_GROUP_NAME,this);
         var _loc1_:Number = this._vehicleButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._vehicleButtons[_loc2_].addEventListener(ButtonEvent.CLICK,this.onVehicleTypeButtonClickHandler);
            this.setToolTipListeners(this._vehicleButtons[_loc2_]);
            this._vehicleButtons[_loc2_].groupName = VEHICLE_GROUP_NAME;
            this._vehicleButtons[_loc2_].allowDeselect = false;
            this._vehicleButtons[_loc2_].validateNow();
            _loc2_++;
         }
      }
      
      private function autoSelectVehicleType(param1:String) : void
      {
         if(this._currentSelectedVehicleType == param1)
         {
            return;
         }
         this._currentSelectedVehicleType = param1;
         this.selectCurrentVehicleType();
      }
      
      private function selectCurrentVehicleType() : void
      {
         var _loc1_:Number = this._vehicleButtons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._currentSelectedVehicleType == this._vehicleButtons[_loc2_].type)
            {
               this._vehicleButtons[_loc2_].selected = true;
            }
            _loc2_++;
         }
      }
      
      private function autoSelectVehicle(param1:String, param2:int) : void
      {
         var _loc3_:DataProvider = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         switch(param1)
         {
            case VehicleTypes.LIGHT_TANK:
               _loc3_ = this._model.lightTanks;
               break;
            case VehicleTypes.MEDIUM_TANK:
               _loc3_ = this._model.mediumTanks;
               break;
            case VehicleTypes.HEAVY_TANK:
               _loc3_ = this._model.heavyTanks;
               break;
            case VehicleTypes.AT_SPG:
               _loc3_ = this._model.AT_SPG;
               break;
            case VehicleTypes.SPG:
               _loc3_ = this._model.SPG;
               break;
            default:
               DebugUtils.LOG_DEBUG("ERROR unknown tank type: " + param1);
         }
         this.vehiclesDropdown.labelField = VEHICLE_DD_LABELFIELD;
         this.vehiclesDropdown.dataProvider = _loc3_;
         this.vehiclesDropdown.selectedIndex = -1;
         if(param2 != NO_VEHICLE_ID)
         {
            _loc4_ = false;
            _loc5_ = this.vehiclesDropdown.dataProvider.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(this.vehiclesDropdown.dataProvider[_loc6_].intCD == param2)
               {
                  this.vehiclesDropdown.selectedIndex = _loc6_;
                  _loc4_ = true;
                  break;
               }
               _loc6_++;
            }
            if(!_loc4_)
            {
               this.vehiclesDropdown.selectedIndex = 0;
            }
         }
         else
         {
            this.vehiclesDropdown.selectedIndex = 0;
         }
         this._currentSelectedCostIndex = -1;
         this._retrainVehicleCD = this.vehiclesDropdown.dataProvider[this.vehiclesDropdown.selectedIndex].intCD;
         this.updateResetButton();
         this.vehiclesDropdown.validateNow();
      }
      
      private function updateResetButton() : void
      {
         this.btnReset.enabled = this._model.currentVehicle != null && this.vehiclesDropdown != null && this._retrainVehicleCD != this._model.currentVehicle.intCD;
      }
      
      private function applyRetraining() : void
      {
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.APPLY_RETRAINING);
         var _loc2_:Object = {
            "inventoryID":this._model.tankmanID,
            "tankmanCostTypeIndex":this._currentSelectedCostIndex
         };
         _loc1_.retrainingTankmanData = _loc2_;
         dispatchEvent(_loc1_);
      }
      
      private function onRetrainingButtonDoubleClickHandler(param1:MouseEvent) : void
      {
         IEventDispatcher(param1.target).dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
         if(App.utils.commons.isLeftButton(param1))
         {
            this.applyRetraining();
         }
      }
      
      private function onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this._toolTipBindHash[param1.currentTarget.name] != null)
         {
            _loc2_ = this._toolTipBindHash[param1.currentTarget.name];
         }
         App.toolTipMgr.showComplex(_loc2_);
      }
      
      private function onItemMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onVehicleTypeButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = VehicleTypeButton(param1.currentTarget).type;
         if(this._currentSelectedVehicleType != _loc2_)
         {
            this._currentSelectedVehicleType = _loc2_;
            _loc3_ = NO_VEHICLE_ID;
            if(this._model.currentVehicle != null && this._currentSelectedVehicleType == this._model.currentVehicle.type)
            {
               _loc3_ = this._model.currentVehicle.intCD;
            }
            else if(this._currentSelectedVehicleType == this._model.nativeVehicle.type)
            {
               _loc3_ = this._model.nativeVehicle.intCD;
            }
            this.selectCurrentVehicleType();
            this.autoSelectVehicle(this._currentSelectedVehicleType,_loc3_);
         }
      }
      
      private function onBtnResetClickHandler(param1:ButtonEvent) : void
      {
         this.autoSelectVehicleType(this._model.currentVehicle.type);
         this.autoSelectVehicle(this._model.currentVehicle.type,this._model.currentVehicle.intCD);
      }
      
      private function onVehiclesDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:PersonalCaseEvent = null;
         if(param1.itemData)
         {
            this._retrainVehicleCD = this.vehiclesDropdown.dataProvider[this.vehiclesDropdown.selectedIndex].intCD;
            _loc2_ = new PersonalCaseEvent(PersonalCaseEvent.CHANGE_RETRAIN_VEHICLE);
            _loc2_.vehicleId = param1.itemData.intCD;
            dispatchEvent(_loc2_);
         }
      }
      
      private function onRetrainingButtonGroupChangeHandler(param1:Event) : void
      {
         this._currentSelectedCostIndex = this._retrainingButtonGroup.selectedIndex;
      }
      
      private function onApplyRetrainingButtonClickHandler(param1:ButtonEvent) : void
      {
         this.applyRetraining();
      }
   }
}
