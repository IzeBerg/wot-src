package net.wg.gui.lobby.vehicleCompare
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
   import net.wg.gui.components.controls.VO.ShellButtonVO;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
   import net.wg.gui.lobby.vehicleCompare.configurator.ClosableEquipmentSlot;
   import net.wg.gui.lobby.vehicleCompare.configurator.EquipmentWidget;
   import net.wg.gui.lobby.vehicleCompare.configurator.ModificationsWidget;
   import net.wg.gui.lobby.vehicleCompare.configurator.VehConfCrew;
   import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModules;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorVO;
   import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillEvent;
   import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleCompareConfiguratorView extends VehicleCompareConfiguratorViewMeta implements IVehicleCompareConfiguratorViewMeta, IViewStackContent
   {
      
      private static const BORDER_OFFSET:int = 10;
      
      private static const MIN_SCREEN_WIDTH:int = 1024;
      
      private static const MAX_SCREEN_WIDTH:int = 1920;
      
      private static const VEH_PARAMS_MAX_X_OFFSET:int = -4;
      
      private static const VEH_PARAMS_MIN_X_OFFSET:int = -20;
      
      private static const VEH_PARAMS_Y_OFFSET:int = -8;
      
      private static const VEH_PARAMS_BOTTOM_OFFSET:int = 13;
      
      private static const EQUIPMENT_WIDGET_WIDTH:int = 622;
      
      private static const EQUIPMENT_WIDGET_HEIGHT:int = 130;
      
      private static const EQUIPMENT_WIDGET_X_OFFSET:int = 2;
      
      private static const MODIFICATIONS_WIDGET_WIDTH:int = 630;
      
      private static const MODIFICATIONS_WIDGET_HEIGHT_SMALL:int = 116;
      
      private static const MODIFICATIONS_WIDGET_HEIGHT_BIG:int = 122;
       
      
      public var crew:VehConfCrew;
      
      public var modules:VehConfModules;
      
      public var modificationsWidget:ModificationsWidget;
      
      public var equipmentWidget:EquipmentWidget;
      
      public var vehParams:IVehicleParameters;
      
      private var _offsetsNoModifications:Dictionary;
      
      private var _isPostProgressionEnabled:Boolean = true;
      
      public function VehicleCompareConfiguratorView()
      {
         this._offsetsNoModifications = new Dictionary();
         super();
         bottomPanel.separator.visible = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _offsets[this.crew] = new Offsets(-1,55);
         _offsets[this.modules] = new Offsets(-2,14);
         _offsets[this.modificationsWidget] = new Offsets(12,22);
         _offsets[this.equipmentWidget] = new Offsets(7,17);
         _offsets[bottomPanel] = new Offsets(-40,-20);
         this._offsetsNoModifications[titleTf] = new Offsets(41,115);
         this._offsetsNoModifications[this.crew] = new Offsets(15,55);
         this._offsetsNoModifications[this.modules] = new Offsets(12,42);
         this._offsetsNoModifications[this.equipmentWidget] = new Offsets(22,47);
         this._offsetsNoModifications[bottomPanel] = new Offsets(3,60);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.modules.addEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
         this.modules.addEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
         this.modules.addEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
         this.crew.addEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ClosableEquipmentSlotEvent.REMOVE_CLICK,this.onDeviceSlotRemoveClickHandler);
         this.crew.removeEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
         this.modules.removeEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
         this.modules.removeEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
         this.modules.removeEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
         this.modules.dispose();
         this.modules = null;
         this.crew.dispose();
         this.crew = null;
         App.utils.data.cleanupDynamicObject(this._offsetsNoModifications);
         this._offsetsNoModifications = null;
         this.vehParams = null;
         super.onDispose();
      }
      
      override protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
      {
         return new VehicleCompareConfiguratorVO(param1);
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:Boolean = App.appHeight < StageSizeBoundaries.HEIGHT_900 && this._isPostProgressionEnabled;
         this.modules.setIsSmall(_loc1_);
         this.modificationsWidget.visible = this._isPostProgressionEnabled;
         if(this._isPostProgressionEnabled)
         {
            this.modificationsWidget.setSize(MODIFICATIONS_WIDGET_WIDTH,!!_loc1_ ? Number(MODIFICATIONS_WIDGET_HEIGHT_SMALL) : Number(MODIFICATIONS_WIDGET_HEIGHT_BIG));
            this.modificationsWidget.validateNow();
         }
         super.updateLayout();
         var _loc2_:int = (width - MIN_SCREEN_WIDTH >> 1) + BORDER_OFFSET;
         this.modules.x = _loc2_;
         this.modificationsWidget.x = this.equipmentWidget.x = _loc2_ + EQUIPMENT_WIDGET_X_OFFSET;
         bottomPanel.x = _loc2_;
         this.crew.x = _loc2_;
         var _loc3_:Number = (App.appWidth - MIN_SCREEN_WIDTH) / (MAX_SCREEN_WIDTH - MIN_SCREEN_WIDTH);
         this.vehParams.x = this.modules.x + this.modules.width + VEH_PARAMS_MIN_X_OFFSET + (VEH_PARAMS_MAX_X_OFFSET - VEH_PARAMS_MIN_X_OFFSET) * _loc3_ >> 0;
         this.vehParams.y = this.crew.y + VEH_PARAMS_Y_OFFSET;
         this.vehParams.height = bottomPanel.y + bottomPanel.height - this.vehParams.y + VEH_PARAMS_BOTTOM_OFFSET;
      }
      
      override protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
      {
         super.setInitData(param1);
         var _loc2_:VehicleCompareConfiguratorVO = VehicleCompareConfiguratorVO(param1);
         this.modules.setTopModulesEnabled(_loc2_.enableTopModules);
      }
      
      override protected function setDevicesData(param1:Vector.<DeviceSlotVO>) : void
      {
         this.modules.setData(param1);
      }
      
      override protected function setAmmo(param1:Vector.<ShellButtonVO>) : void
      {
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.vehParams,VEHICLE_COMPARE_CONSTANTS.VEHICLE_COMPARE_PARAMS);
         registerFlashComponentS(IDAAPIModule(this.equipmentWidget),VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_EQUIPMENT_WIDGET);
         this.equipmentWidget.setSize(EQUIPMENT_WIDGET_WIDTH,EQUIPMENT_WIDGET_HEIGHT);
         registerFlashComponentS(IDAAPIModule(this.modificationsWidget),VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_MODIFICATIONS_WIDGET);
         this.modificationsWidget.setSize(MODIFICATIONS_WIDGET_WIDTH,MODIFICATIONS_WIDGET_HEIGHT_SMALL);
      }
      
      override protected function setSkills(param1:DataProvider) : void
      {
         this.crew.setSkills(param1);
      }
      
      public function as_disableCamo() : void
      {
      }
      
      public function as_setCamo(param1:Boolean) : void
      {
      }
      
      public function as_setIsPostProgressionEnabled(param1:Boolean) : void
      {
         if(this._isPostProgressionEnabled != param1)
         {
            this._isPostProgressionEnabled = param1;
            invalidateSize();
         }
      }
      
      public function as_setSelectedAmmoIndex(param1:int) : void
      {
      }
      
      public function as_setTopModulesSelected(param1:Boolean) : void
      {
         this.modules.setTopModulesSelected(param1);
      }
      
      override protected function get offsets() : Dictionary
      {
         return !!this._isPostProgressionEnabled ? _offsets : this._offsetsNoModifications;
      }
      
      override protected function get itemsToLayoutList() : Vector.<DisplayObject>
      {
         if(this._isPostProgressionEnabled)
         {
            return new <DisplayObject>[titleTf,this.crew,this.modules,this.modificationsWidget,this.equipmentWidget,bottomPanel];
         }
         return new <DisplayObject>[titleTf,this.crew,this.modules,this.equipmentWidget,bottomPanel];
      }
      
      private function onCrewSkillSelectHandler(param1:VehConfSkillEvent) : void
      {
         skillSelectS(param1.skillType,param1.slotIndex,param1.selected);
      }
      
      private function onModulesTopModulesOffHandler(param1:VehConfEvent) : void
      {
         toggleTopModulesS(false);
      }
      
      private function onModulesTopModulesOnHandler(param1:VehConfEvent) : void
      {
         toggleTopModulesS(true);
      }
      
      private function onModulesModulesClickHandler(param1:VehConfEvent) : void
      {
         showModulesS();
      }
      
      private function onDeviceSlotRemoveClickHandler(param1:ClosableEquipmentSlotEvent) : void
      {
         var _loc2_:ClosableEquipmentSlot = ClosableEquipmentSlot(param1.target);
         removeDeviceS(_loc2_.type,_loc2_.slotIndex);
      }
   }
}
