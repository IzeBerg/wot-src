package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehConfBottomPanel extends UIComponentEx implements IFocusChainContainer
   {
       
      
      public var resetBtn:ISoundButtonEx;
      
      public var cancelBtn:ISoundButtonEx;
      
      public var applyBtn:ISoundButtonEx;
      
      public var separator:ISeparatorAsset;
      
      public function VehConfBottomPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.resetBtn.label = VEH_COMPARE.VEHCONF_RESETBTNLABEL;
         this.cancelBtn.label = VEH_COMPARE.VEHCONF_CANCELBTNLABEL;
         this.applyBtn.label = VEH_COMPARE.VEHCONF_APPLYBTNLABEL;
         this.resetBtn.addEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.separator.mouseEnabled = false;
         this.cancelBtn.mouseEnabledOnDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this.resetBtn.removeEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.resetBtn.dispose();
         this.resetBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.applyBtn.dispose();
         this.applyBtn = null;
         this.separator.dispose();
         this.separator = null;
         super.onDispose();
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[InteractiveObject(this.applyBtn),InteractiveObject(this.cancelBtn),InteractiveObject(this.resetBtn)];
      }
      
      public function setApplyEnabled(param1:Boolean) : void
      {
         this.applyBtn.enabled = param1;
      }
      
      public function setResetEnabled(param1:Boolean) : void
      {
         this.resetBtn.enabled = param1;
      }
      
      public function setTexts(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this.resetBtn.label = param1;
         this.resetBtn.tooltip = param2;
         this.cancelBtn.label = param3;
         this.cancelBtn.tooltip = param4;
         this.applyBtn.label = param5;
         this.applyBtn.tooltip = param6;
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfEvent(VehConfEvent.APPLY_CLICK));
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfEvent(VehConfEvent.CLOSE_CLICK));
      }
      
      private function onResetBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfEvent(VehConfEvent.RESET_CLICK));
      }
   }
}
