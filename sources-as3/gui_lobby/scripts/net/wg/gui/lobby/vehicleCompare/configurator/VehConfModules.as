package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehConfModules extends UIComponentEx implements IFocusChainContainer
   {
       
      
      public var topModulesCb:CheckBox;
      
      public var titleTf:TextField;
      
      public var topModulesTf:TextField;
      
      public var modulesButton:VehConfModulesButton;
      
      public function VehConfModules()
      {
         super();
         this.topModulesCb.visible = false;
         this.topModulesTf.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         focusable = true;
         this.titleTf.text = VEH_COMPARE.VEHCONF_MODULES;
         this.topModulesTf.text = VEH_COMPARE.VEHCONF_TOPMODULESLABEL;
         this.topModulesCb.addEventListener(ButtonEvent.CLICK,this.onTopModulesBtnClickHandler);
         this.updateCbTooltip();
         this.topModulesCb.label = VEH_COMPARE.VEHCONF_TOPMODULESBTNLABEL;
         this.topModulesCb.validateNow();
         this.topModulesCb.autoSize = TextFieldAutoSize.RIGHT;
         this.topModulesTf.addEventListener(MouseEvent.ROLL_OVER,this.onTopModulesTfRollOverHandler);
         this.topModulesTf.addEventListener(MouseEvent.ROLL_OUT,this.onTopModulesTfRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.topModulesCb.removeEventListener(ButtonEvent.CLICK,this.onTopModulesBtnClickHandler);
         this.topModulesCb.dispose();
         this.topModulesCb = null;
         this.modulesButton.dispose();
         this.modulesButton = null;
         this.titleTf = null;
         this.topModulesTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTopModulesTfRollOverHandler);
         this.topModulesTf.removeEventListener(MouseEvent.ROLL_OUT,this.onTopModulesTfRollOutHandler);
         this.topModulesTf = null;
         super.onDispose();
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.topModulesCb,this.modulesButton];
      }
      
      public function setData(param1:Vector.<DeviceSlotVO>) : void
      {
         this.modulesButton.setData(param1);
      }
      
      public function setTopModulesEnabled(param1:Boolean) : void
      {
         this.topModulesCb.visible = param1;
         this.topModulesTf.visible = !param1;
         this.modulesButton.enabled = param1;
      }
      
      public function setTopModulesSelected(param1:Boolean) : void
      {
         this.topModulesCb.selected = param1;
         this.updateCbTooltip();
      }
      
      private function onTopModulesTfRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onTopModulesTfRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(VEH_COMPARE.VEHCONF_TOOLTIPS_TOPMODULESLABEL);
      }
      
      private function onTopModulesBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfEvent(!!this.topModulesCb.selected ? VehConfEvent.TOP_MODULES_ON : VehConfEvent.TOP_MODULES_OFF,true));
         this.updateCbTooltip();
      }
      
      private function updateCbTooltip() : void
      {
         this.topModulesCb.toolTip = !!this.topModulesCb.selected ? VEH_COMPARE.VEHCONF_TOOLTIPS_TOPMODULESON : VEH_COMPARE.VEHCONF_TOOLTIPS_TOPMODULESOFF;
      }
   }
}
