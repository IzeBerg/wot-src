package net.wg.gui.lobby.vehicleCompare
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
   import net.wg.gui.components.controls.VO.ShellButtonVO;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
   import net.wg.gui.lobby.vehicleCompare.configurator.ClosableEquipmentSlot;
   import net.wg.gui.lobby.vehicleCompare.configurator.EquipmentWidget;
   import net.wg.gui.lobby.vehicleCompare.configurator.VehConfCrew;
   import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModules;
   import net.wg.gui.lobby.vehicleCompare.data.VehConfSkillVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorVO;
   import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillDropDownEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillEvent;
   import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
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
      
      private static const BLUR_XY:int = 20;
       
      
      public var crew:VehConfCrew;
      
      public var modules:VehConfModules;
      
      public var equipmentWidget:EquipmentWidget;
      
      public var vehParams:IVehicleParameters;
      
      public function VehicleCompareConfiguratorView()
      {
         super();
         bottomPanel.separator.visible = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         offsets[this.crew] = new Offsets(15,55);
         offsets[this.modules] = new Offsets(12,42);
         offsets[this.equipmentWidget] = new Offsets(2,47);
         offsets[bottomPanel] = new Offsets(3,60);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.modules.addEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
         this.modules.addEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
         this.modules.addEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
         this.crew.addEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
         this.crew.addEventListener(VehConfSkillDropDownEvent.CREW_LEVEL_CHANGED,this.onCrewCrewLevelChangedHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ClosableEquipmentSlotEvent.REMOVE_CLICK,this.onDeviceSlotRemoveClickHandler);
         this.crew.removeEventListener(VehConfSkillEvent.SKILL_SELECT,this.onCrewSkillSelectHandler);
         this.crew.removeEventListener(VehConfSkillDropDownEvent.CREW_LEVEL_CHANGED,this.onCrewCrewLevelChangedHandler);
         this.modules.removeEventListener(VehConfEvent.MODULES_CLICK,this.onModulesModulesClickHandler);
         this.modules.removeEventListener(VehConfEvent.TOP_MODULES_ON,this.onModulesTopModulesOnHandler);
         this.modules.removeEventListener(VehConfEvent.TOP_MODULES_OFF,this.onModulesTopModulesOffHandler);
         this.modules.dispose();
         this.modules = null;
         this.crew.dispose();
         this.crew = null;
         this.vehParams = null;
         super.onDispose();
      }
      
      override protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
      {
         return new VehicleCompareConfiguratorVO(param1);
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:int = 0;
         super.updateLayout();
         _loc1_ = (width - MIN_SCREEN_WIDTH >> 1) + BORDER_OFFSET;
         this.modules.x = _loc1_;
         this.equipmentWidget.x = _loc1_ + EQUIPMENT_WIDGET_X_OFFSET;
         bottomPanel.x = _loc1_;
         this.crew.x = _loc1_;
         var _loc2_:Number = (App.appWidth - MIN_SCREEN_WIDTH) / (MAX_SCREEN_WIDTH - MIN_SCREEN_WIDTH);
         this.vehParams.x = this.modules.x + this.modules.width + VEH_PARAMS_MIN_X_OFFSET + (VEH_PARAMS_MAX_X_OFFSET - VEH_PARAMS_MIN_X_OFFSET) * _loc2_;
         this.vehParams.y = this.crew.y + VEH_PARAMS_Y_OFFSET;
         this.vehParams.height = bottomPanel.y + bottomPanel.height - this.vehParams.y + VEH_PARAMS_BOTTOM_OFFSET;
      }
      
      override protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
      {
         super.setInitData(param1);
         var _loc2_:VehicleCompareConfiguratorVO = VehicleCompareConfiguratorVO(param1);
         this.crew.setStaticData(_loc2_);
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
      }
      
      override protected function setSkills(param1:Vector.<VehConfSkillVO>) : void
      {
         this.crew.setSkills(param1);
      }
      
      override protected function get itemsToLayoutList() : Vector.<DisplayObject>
      {
         return new <DisplayObject>[titleTf,this.crew,this.modules,this.equipmentWidget,bottomPanel];
      }
      
      public function as_disableCamo() : void
      {
      }
      
      public function as_setCamo(param1:Boolean) : void
      {
      }
      
      public function as_setCrewAttentionIconVisible(param1:Boolean) : void
      {
         this.crew.setCrewAttentionIconVisible(param1);
      }
      
      public function as_setCrewLevelIndex(param1:int) : void
      {
         this.crew.crewLevelIndex = param1;
      }
      
      public function as_setSelectedAmmoIndex(param1:int) : void
      {
      }
      
      public function as_setSkillsBlocked(param1:Boolean) : void
      {
         this.crew.setSkillsFadeVisible(param1);
      }
      
      public function as_setTopModulesSelected(param1:Boolean) : void
      {
         this.modules.setTopModulesSelected(param1);
      }
      
      private function onCrewCrewLevelChangedHandler(param1:VehConfSkillDropDownEvent) : void
      {
         changeCrewLevelS(param1.crewLevel);
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
      
      public function as_blur() : void
      {
      }
      
      public function as_unblur() : void
      {
      }
   }
}
