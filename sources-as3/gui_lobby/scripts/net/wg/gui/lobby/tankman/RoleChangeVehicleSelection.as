package net.wg.gui.lobby.tankman
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.tankman.vo.VehicleSelectionItemVO;
   import net.wg.gui.lobby.tankman.vo.VehicleSelectionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class RoleChangeVehicleSelection extends UIComponentEx implements ISpriteEx
   {
       
      
      public var lightTankBtn:VehicleTypeButton;
      
      public var mediumTankBtn:VehicleTypeButton;
      
      public var heavyTankBtn:VehicleTypeButton;
      
      public var at_spgBtn:VehicleTypeButton;
      
      public var spgBtn:VehicleTypeButton;
      
      public var btnReset:SoundButtonEx;
      
      public var vehiclesDropdown:DropdownMenu;
      
      private var _data:VehicleSelectionVO;
      
      private var _currentVehicleType:String;
      
      private var _buttons:Vector.<VehicleTypeButton>;
      
      private var _currentVehicleId:int = -1;
      
      public function RoleChangeVehicleSelection()
      {
         super();
         this._buttons = new <VehicleTypeButton>[this.lightTankBtn,this.mediumTankBtn,this.heavyTankBtn,this.at_spgBtn,this.spgBtn];
      }
      
      override protected function configUI() : void
      {
         var _loc3_:VehicleTypeButton = null;
         super.configUI();
         this.lightTankBtn.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_LIGHT_TANK_BTN;
         this.mediumTankBtn.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_MEDIUM_TANK_BTN;
         this.heavyTankBtn.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_HEAVY_TANK_BTN;
         this.at_spgBtn.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_AT_SPG_BTN;
         this.spgBtn.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_SPG_BTN;
         this.btnReset.tooltip = TOOLTIPS.PERSONAL_CASE_TRAINING_CURRENT_TANK;
         this.vehiclesDropdown.disposeDataProvider = false;
         this.vehiclesDropdown.labelField = "name";
         this.vehiclesDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onDropdownSelectionIndexChange);
         this.vehiclesDropdown.addEventListener(MouseEvent.ROLL_OVER,this.onDropdownSelectionMouseOver);
         this.vehiclesDropdown.addEventListener(MouseEvent.ROLL_OUT,this.onDropdownSelectionMouseOut);
         this.btnReset.addEventListener(ButtonEvent.CLICK,this.onBtnResetClick);
         var _loc1_:int = this._buttons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._buttons[_loc2_];
            _loc3_.addEventListener(ButtonEvent.CLICK,this.onVehicleTypeButtonClick);
            _loc2_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc3_:VehicleTypeButton = null;
         this.vehiclesDropdown.removeEventListener(ListEvent.ITEM_CLICK,this.onDropdownSelectionIndexChange);
         this.vehiclesDropdown.removeEventListener(MouseEvent.ROLL_OVER,this.onDropdownSelectionMouseOver);
         this.vehiclesDropdown.removeEventListener(MouseEvent.ROLL_OUT,this.onDropdownSelectionMouseOut);
         this.btnReset.removeEventListener(ButtonEvent.CLICK,this.onBtnResetClick);
         var _loc1_:int = this._buttons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._buttons[_loc2_];
            _loc3_.removeEventListener(ButtonEvent.CLICK,this.onVehicleTypeButtonClick);
            _loc2_++;
         }
         this.lightTankBtn.dispose();
         this.lightTankBtn = null;
         this.mediumTankBtn.dispose();
         this.mediumTankBtn = null;
         this.heavyTankBtn.dispose();
         this.heavyTankBtn = null;
         this.at_spgBtn.dispose();
         this.at_spgBtn = null;
         this.spgBtn.dispose();
         this.spgBtn = null;
         this.vehiclesDropdown.dispose();
         this.vehiclesDropdown = null;
         this._buttons.splice(0,this._buttons.length);
         this._buttons = null;
         this.btnReset.dispose();
         this.btnReset = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc4_:VehicleTypeButton = null;
         this._data = VehicleSelectionVO(param1);
         this.applyVehicleType(this._data.nativeVehicleType,this._data.nativeVehicleId);
         var _loc2_:int = this._buttons.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._buttons[_loc3_];
            _loc4_.enabled = this._data.getVehiclesForType(_loc4_.type).length > 0;
            _loc3_++;
         }
      }
      
      private function applyVehicleType(param1:String, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._currentVehicleType != param1)
         {
            this._currentVehicleType = param1;
            _loc3_ = this._buttons.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._buttons[_loc4_].selected = this._buttons[_loc4_]._type == this._currentVehicleType;
               _loc4_++;
            }
            this.vehiclesDropdown.dataProvider = this._data.getVehiclesForType(this._currentVehicleType);
            if(param2 != Values.DEFAULT_INT)
            {
               this.selectVehicleById(param2);
            }
            else if(this._currentVehicleType == this._data.currentVehicleType)
            {
               this.selectVehicleById(this._data.currentVehicleId);
            }
            else
            {
               this.vehiclesDropdown.selectedIndex = 0;
               this.updateCurrentVehicle();
            }
         }
      }
      
      private function selectVehicleById(param1:int) : void
      {
         var _loc5_:VehicleSelectionItemVO = null;
         var _loc2_:Array = this._data.getVehiclesForType(this._currentVehicleType);
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = VehicleSelectionItemVO(_loc2_[_loc4_]);
            if(_loc5_.id == param1)
            {
               this.vehiclesDropdown.selectedIndex = _loc4_;
               this.updateCurrentVehicle();
            }
            _loc4_++;
         }
      }
      
      private function updateCurrentVehicle(param1:Boolean = false) : void
      {
         var _loc2_:VehicleSelectionItemVO = VehicleSelectionItemVO(this.vehiclesDropdown.dataProvider.requestItemAt(this.vehiclesDropdown.selectedIndex));
         this._currentVehicleId = _loc2_.id;
         this.btnReset.enabled = this._data.currentVehicleId != Values.DEFAULT_INT && this._currentVehicleId != this._data.currentVehicleId;
         if(!param1)
         {
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
         }
      }
      
      public function get currentVehicleId() : int
      {
         return this._currentVehicleId;
      }
      
      private function onDropdownSelectionMouseOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onDropdownSelectionMouseOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.PERSONAL_CASE_TRAINING_TANK);
      }
      
      private function onDropdownSelectionIndexChange(param1:ListEvent) : void
      {
         this.updateCurrentVehicle(true);
      }
      
      private function onBtnResetClick(param1:ButtonEvent) : void
      {
         if(this._data.currentVehicleType != this._currentVehicleType)
         {
            this.applyVehicleType(this._data.currentVehicleType);
         }
         else
         {
            this.selectVehicleById(this._data.currentVehicleId);
         }
      }
      
      private function onVehicleTypeButtonClick(param1:ButtonEvent) : void
      {
         var _loc2_:VehicleTypeButton = VehicleTypeButton(param1.target);
         this.applyVehicleType(_loc2_.type);
      }
   }
}
