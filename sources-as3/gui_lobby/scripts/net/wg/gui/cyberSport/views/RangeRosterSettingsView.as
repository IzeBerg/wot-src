package net.wg.gui.cyberSport.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.RangeSlider;
   import net.wg.gui.components.controls.events.RangeSliderEvent;
   import net.wg.gui.cyberSport.controls.RosterButtonGroup;
   import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.events.SliderEvent;
   
   public class RangeRosterSettingsView extends UIComponentEx implements IViewStackContent
   {
      
      private static const NATION_TYPE_GROUP:String = "rosterGroup";
      
      private static const VEHICLE_TYPE_GROUP:String = "vehicleTypeGroup";
      
      private static const UPDATE_ROSTER_DATA:String = "updateRosterData";
      
      private static const LEVEL_RANGE_MINIMUM_INDEX:int = 0;
      
      private static const LEVEL_RANGE_MAXIMUM_INDEX:int = 1;
      
      private static const NUM_LEVELS_DATA_ITEMS:int = 1;
      
      private static const LEVEL_RANGE_MIN:Number = 1;
      
      private static const LEVEL_RANGE_MAX:Number = 10;
       
      
      public var flagsField:FieldSet;
      
      public var vTypeField:FieldSet;
      
      public var sliderField:FieldSet;
      
      public var flag1:BlackButton = null;
      
      public var flag2:BlackButton = null;
      
      public var flag3:BlackButton = null;
      
      public var flag4:BlackButton = null;
      
      public var flag5:BlackButton = null;
      
      public var flag6:BlackButton = null;
      
      public var flag7:BlackButton = null;
      
      public var flag8:BlackButton = null;
      
      public var flag9:BlackButton = null;
      
      public var flag10:BlackButton = null;
      
      public var flag11:BlackButton = null;
      
      public var heavyBtn:BlackButton = null;
      
      public var mediumBtn:BlackButton = null;
      
      public var lightBtn:BlackButton = null;
      
      public var atSpgBtn:BlackButton = null;
      
      public var spgBtn:BlackButton = null;
      
      public var rangeSlider:RangeSlider;
      
      private var _nationButtonGroup:RosterButtonGroup;
      
      private var _vTypeButtonGroup:RosterButtonGroup;
      
      private var _model:SettingRosterVO;
      
      private var _guiNations:Array;
      
      private var _vTypesButtons:Vector.<BlackButton> = null;
      
      private var _flagsButtons:Vector.<BlackButton> = null;
      
      public function RangeRosterSettingsView()
      {
         this._guiNations = [];
         super();
         this._guiNations = App.utils.nations.getNations();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._flagsButtons = new Vector.<BlackButton>();
         this._vTypesButtons = new Vector.<BlackButton>();
         this._nationButtonGroup = RosterButtonGroup.getGroup(NATION_TYPE_GROUP,this);
         this._vTypeButtonGroup = RosterButtonGroup.getGroup(VEHICLE_TYPE_GROUP,this);
         this.flagsField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_NATIONFIELDSET;
         this.vTypeField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_VEHICLETYPE;
         this.sliderField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_VEHICLELEVEL;
         this.rangeSlider.rangeMin = LEVEL_RANGE_MIN;
         this.rangeSlider.rangeMax = LEVEL_RANGE_MAX;
         this.rangeSlider.clickableRenderer = true;
         this._flagsButtons.push(this.flag1,this.flag2,this.flag3,this.flag4,this.flag5,this.flag6,this.flag7,this.flag8,this.flag9,this.flag10,this.flag11);
         this.updateGroupName(this._flagsButtons,NATION_TYPE_GROUP);
         this.updateNationFlags(this._flagsButtons);
         this._vTypesButtons.push(this.heavyBtn,this.mediumBtn,this.lightBtn,this.atSpgBtn,this.spgBtn);
         this.updateGroupName(this._vTypesButtons,VEHICLE_TYPE_GROUP);
         this.updateVehicleTypes();
         this.updateToggle(this._flagsButtons,true);
         this.updateToggle(this._vTypesButtons,true);
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.rangeSlider.dispose();
         this.rangeSlider = null;
         this._nationButtonGroup.dispose();
         this._nationButtonGroup = null;
         this._vTypeButtonGroup.dispose();
         this._vTypeButtonGroup = null;
         this._model = null;
         this.disposeItems(this._flagsButtons);
         this._flagsButtons.splice(0,this._flagsButtons.length);
         this._flagsButtons = null;
         this.disposeItems(this._vTypesButtons);
         this._vTypesButtons.splice(0,this._vTypesButtons.length);
         this._vTypesButtons = null;
         this._guiNations.splice(0,this._guiNations.length);
         this._guiNations = null;
         this.flagsField.dispose();
         this.flagsField = null;
         this.vTypeField.dispose();
         this.vTypeField = null;
         this.sliderField.dispose();
         this.sliderField = null;
         this.flag1 = null;
         this.flag2 = null;
         this.flag3 = null;
         this.flag4 = null;
         this.flag5 = null;
         this.flag6 = null;
         this.flag7 = null;
         this.flag8 = null;
         this.flag9 = null;
         this.flag10 = null;
         this.heavyBtn = null;
         this.mediumBtn = null;
         this.lightBtn = null;
         this.atSpgBtn = null;
         this.spgBtn = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_ROSTER_DATA) && this._model)
         {
            this.autoSelect();
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setDefaultState(param1:Boolean = true) : void
      {
         this.removeListeners();
         this.setItemsSelected(this._flagsButtons,false);
         this.setItemsSelected(this._vTypesButtons,false);
         this.rangeSlider.leftValue = this.rangeSlider.minimum;
         this.rangeSlider.rightValue = this.rangeSlider.maximum;
         this.addListeners();
         if(param1)
         {
            this.dispatchChangeRoster();
         }
      }
      
      public function setLevelLimits(param1:int, param2:int) : void
      {
         this.rangeSlider.minimum = param1;
         this.rangeSlider.maximum = param2;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._model = SettingRosterVO(param1);
         invalidate(UPDATE_ROSTER_DATA);
      }
      
      private function setItemsSelected(param1:Vector.<BlackButton>, param2:Boolean) : void
      {
         var _loc3_:BlackButton = null;
         for each(_loc3_ in param1)
         {
            _loc3_.selected = param2;
         }
      }
      
      private function removeListeners() : void
      {
         this._nationButtonGroup.removeEventListener(Event.CHANGE,this.onNationButtonGroupChangeHandler);
         this.rangeSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderValueChangeHandler);
         this._vTypeButtonGroup.removeEventListener(Event.CHANGE,this.onVTypeButtonGroupChangeHandler);
      }
      
      private function addListeners() : void
      {
         this._nationButtonGroup.addEventListener(Event.CHANGE,this.onNationButtonGroupChangeHandler);
         this.rangeSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderValueChangeHandler);
         this._vTypeButtonGroup.addEventListener(Event.CHANGE,this.onVTypeButtonGroupChangeHandler);
      }
      
      private function disposeItems(param1:Vector.<BlackButton>) : void
      {
         var _loc2_:IDisposable = null;
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
         }
      }
      
      private function updateToggle(param1:Vector.<BlackButton>, param2:Boolean) : void
      {
         var _loc3_:BlackButton = null;
         for each(_loc3_ in param1)
         {
            _loc3_.toggleEnable = param2;
         }
      }
      
      private function updateGroupName(param1:Vector.<BlackButton>, param2:String) : void
      {
         var _loc3_:BlackButton = null;
         for each(_loc3_ in param1)
         {
            _loc3_.groupName = param2;
         }
      }
      
      private function updateNationFlags(param1:Vector.<BlackButton>) : void
      {
         var _loc3_:String = null;
         var _loc4_:BlackButton = null;
         var _loc2_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this._guiNations[_loc5_];
            _loc4_ = param1[_loc5_];
            _loc4_.iconSource = RES_ICONS.getFilterNation(_loc3_);
            _loc4_.data = _loc3_;
            _loc5_++;
         }
      }
      
      private function updateVehicleTypes() : void
      {
         this.heavyBtn.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_HEAVYTANK;
         this.heavyBtn.data = VehicleTypes.HEAVY_TANK;
         this.mediumBtn.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_MEDIUMTANK;
         this.mediumBtn.data = VehicleTypes.MEDIUM_TANK;
         this.lightBtn.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_LIGHTTANK;
         this.lightBtn.data = VehicleTypes.LIGHT_TANK;
         this.atSpgBtn.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_AT_SPG;
         this.atSpgBtn.data = VehicleTypes.AT_SPG;
         this.spgBtn.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_SPG;
         this.spgBtn.data = VehicleTypes.SPG;
      }
      
      private function updateSelection(param1:Vector.<BlackButton>, param2:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BlackButton = null;
         for each(_loc3_ in param2)
         {
            for each(_loc4_ in param1)
            {
               if(_loc4_.data == _loc3_)
               {
                  _loc4_.selected = true;
               }
            }
         }
      }
      
      private function autoSelect() : void
      {
         var _loc1_:Array = this._model.nationIDRange;
         var _loc2_:Array = this._model.vTypeRange;
         var _loc3_:Array = this._model.vLevelRange;
         if(_loc1_.length == 0 && _loc2_.length == 0 && _loc3_.length == 0)
         {
            this.setDefaultState();
            return;
         }
         this.removeListeners();
         this.updateSelection(this._flagsButtons,_loc1_);
         this.updateSelection(this._vTypesButtons,_loc2_);
         if(_loc3_.length > NUM_LEVELS_DATA_ITEMS)
         {
            this.rangeSlider.leftValue = _loc3_[LEVEL_RANGE_MINIMUM_INDEX];
            this.rangeSlider.rightValue = _loc3_[LEVEL_RANGE_MAXIMUM_INDEX];
         }
         this.addListeners();
         this.dispatchChangeRoster();
      }
      
      private function dispatchChangeRoster() : void
      {
         dispatchEvent(new RosterSettingsEvent(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this._model));
      }
      
      private function onNationButtonGroupChangeHandler(param1:Event) : void
      {
         this._model.nationIDRange = this._nationButtonGroup.rangeData;
         this.dispatchChangeRoster();
      }
      
      private function onVTypeButtonGroupChangeHandler(param1:Event) : void
      {
         this._model.vTypeRange = this._vTypeButtonGroup.rangeData;
         this.dispatchChangeRoster();
      }
      
      private function onRangeSliderValueChangeHandler(param1:RangeSliderEvent) : void
      {
         this._model.vLevelRange[LEVEL_RANGE_MINIMUM_INDEX] = param1.leftValue;
         this._model.vLevelRange[LEVEL_RANGE_MAXIMUM_INDEX] = param1.rightValue;
         this.dispatchChangeRoster();
      }
   }
}
