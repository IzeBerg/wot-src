package net.wg.gui.lobby.modulesPanel
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import net.wg.data.Aliases;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
   import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
   import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
   import net.wg.gui.lobby.modulesPanel.interfaces.IDeviceSlot;
   import net.wg.gui.lobby.modulesPanel.interfaces.IModuleSlot;
   import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
   import net.wg.infrastructure.base.meta.impl.ModulesPanelMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IUtils;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class ModulesPanel extends ModulesPanelMeta implements IModulesPanel
   {
      
      private static const INV_BUTTONS_ENABLED:String = "InvButtonsEnabled";
      
      private static const INV_SELECTION:String = "InvSelection";
      
      private static const MODULES_PANEL_BTN_GROUP:String = "ModulesPanelBtnGroup";
       
      
      public var gun:IModuleSlot = null;
      
      public var turret:IModuleSlot = null;
      
      public var engine:IModuleSlot = null;
      
      public var chassis:IModuleSlot = null;
      
      public var radio:IModuleSlot = null;
      
      public var preferredLayout:int = 2;
      
      protected var _slots:Vector.<IDeviceSlot> = null;
      
      protected var _modules:Vector.<IModuleSlot> = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _utils:IUtils;
      
      public function ModulesPanel()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._utils = App.utils;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._slots = new Vector.<IDeviceSlot>(0);
         this.addSlots(this.gun,this.turret,this.chassis,this.engine,this.radio);
         this._modules = new <IModuleSlot>[this.gun,this.turret,this.chassis,this.engine,this.radio];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:IDeviceSlot = null;
         var _loc2_:IModuleSlot = null;
         super.configUI();
         _deferredDispose = true;
         for each(_loc1_ in this._slots)
         {
            this.configSlot(_loc1_.button);
         }
         for each(_loc2_ in this._modules)
         {
            _loc2_.type = FITTING_TYPES.MANDATORY_SLOTS[this._modules.indexOf(_loc2_)];
            _loc2_.addEventListener(ButtonEvent.CLICK,this.onModuleSlotClickHandler);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:IDeviceSlot = null;
         var _loc2_:IEventDispatcher = null;
         for each(_loc1_ in this._slots)
         {
            this.clearSlot(_loc1_);
            _loc1_.dispose();
         }
         this._slots.splice(0,this._slots.length);
         this._slots = null;
         for each(_loc2_ in this._modules)
         {
            _loc2_.removeEventListener(ButtonEvent.CLICK,this.onModuleSlotClickHandler);
         }
         this._modules.splice(0,this._modules.length);
         this._modules = null;
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         this._utils = null;
         this.gun = null;
         this.turret = null;
         this.chassis = null;
         this.engine = null;
         this.radio = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ButtonGroup = null;
         super.draw();
         if(isInvalid(INV_SELECTION))
         {
            _loc1_ = ButtonGroup.getGroup(MODULES_PANEL_BTN_GROUP,this);
            if(_loc1_ != null)
            {
               _loc1_.clearSelectedButton();
            }
         }
      }
      
      override protected function setData(param1:DevicesDataVO) : void
      {
         this.resetSelection();
         this.setupDevices(param1.devices);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function as_setVehicleHasTurret(param1:Boolean) : void
      {
         this.turret.enabled = param1;
      }
      
      protected function addToButtonGroup(param1:Button) : void
      {
         param1.groupName = MODULES_PANEL_BTN_GROUP;
      }
      
      protected function invalidateButtonsEnabled() : void
      {
         invalidate(INV_BUTTONS_ENABLED);
      }
      
      protected function addSlots(... rest) : void
      {
         this._slots.push.apply(this._slots,rest);
      }
      
      protected function configSlot(param1:Button) : void
      {
         param1.addEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
         this.addToButtonGroup(param1);
      }
      
      protected function clearSlot(param1:IDeviceSlot) : void
      {
         param1.removeEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
      }
      
      protected function trySetupDevice(param1:DeviceSlotVO) : Boolean
      {
         var _loc2_:int = DeviceIndexHelper.getDeviceIndex(param1.slotType);
         if(_loc2_ != -1)
         {
            this._slots[_loc2_].update(param1);
            return true;
         }
         return false;
      }
      
      protected function resetSelection() : void
      {
         invalidate(INV_SELECTION);
      }
      
      protected function showFittingPopover(param1:IDeviceSlot) : void
      {
         var _loc2_:String = Aliases.FITTING_SELECT_POPOVER;
         var _loc3_:Object = new FittingSelectPopoverParams(param1.type,param1.slotIndex,this.preferredLayout);
         if(param1.type == FITTING_TYPES.OPTIONAL_DEVICE)
         {
            _loc2_ = Aliases.OPT_DEVICES_SELECT_POPOVER;
         }
         else if(param1.type == FITTING_TYPES.BATTLE_ABILITY)
         {
            _loc2_ = Aliases.BATTLE_ABILITY_SELECT_POPOVER;
         }
         App.popoverMgr.show(param1,_loc2_,_loc3_);
      }
      
      private function setupDevices(param1:Vector.<DeviceSlotVO>) : void
      {
         var _loc2_:DeviceSlotVO = null;
         for each(_loc2_ in param1)
         {
            if(!this.trySetupDevice(_loc2_))
            {
               this._utils.asserter.assert(false,"Undefined slotType: " + _loc2_.slotType);
            }
         }
      }
      
      private function onModuleSlotClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            this.showFittingPopover(IDeviceSlot(param1.currentTarget));
         }
      }
      
      private function onSlotClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:DeviceSlot = null;
         var _loc3_:Number = NaN;
         this._toolTipMgr.hide();
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            _loc2_ = DeviceSlot(param1.currentTarget);
            _loc3_ = _loc2_.id;
            if(!isNaN(_loc3_))
            {
               if(_loc2_.type != FITTING_TYPES.BOOSTER)
               {
                  showModuleInfoS(String(_loc3_));
               }
            }
         }
      }
      
      public function playAnimation() : void
      {
      }
   }
}
