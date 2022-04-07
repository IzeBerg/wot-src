package net.wg.gui.cyberSport.views.unit
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.cyberSport.CSInvalidationType;
   import net.wg.gui.cyberSport.controls.SettingsIcons;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.vo.RallySlotVO;
   import scaleform.clik.events.ButtonEvent;
   
   public class TeamSection extends CyberSportTeamSectionBase
   {
      
      private static const LABEL_ICON_GAP:Number = 20;
       
      
      public var btnFreeze:BlackButton = null;
      
      public var btnConfigure:IButtonIconLoader = null;
      
      public var settingsIcons:SettingsIcons = null;
      
      public function TeamSection()
      {
         super();
      }
      
      override public function closeSlot(param1:uint, param2:Boolean, param3:uint, param4:String, param5:Boolean, param6:int) : void
      {
         super.closeSlot(param1,param2,param3,param4,param5,param6);
         this.updateSettingsIcon();
      }
      
      override public function updateMembers(param1:Boolean, param2:Array) : void
      {
         super.updateMembers(param1,param2);
         unitData.hasRestrictions = param1;
         this.updateSettingsIcon();
      }
      
      override protected function getSlotHelper() : ISlotRendererHelper
      {
         return new UnitSlotHelper();
      }
      
      override protected function onDispose() : void
      {
         this.settingsIcons.dispose();
         this.settingsIcons = null;
         this.btnFreeze.removeEventListener(ButtonEvent.CLICK,this.onBtnFreezeClickHandler);
         tooltipSubscribe([this.btnFreeze,this.btnConfigure],false);
         this.btnFreeze.dispose();
         this.btnFreeze = null;
         this.btnConfigure.removeEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
         this.btnConfigure.dispose();
         this.btnConfigure = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         lblTeamHeader.text = CYBERSPORT.WINDOW_UNIT_TEAM;
         this.settingsIcons.x = lblTeamHeader.x + lblTeamHeader.width + LABEL_ICON_GAP;
         this.btnConfigure.addEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
         this.btnFreeze.addEventListener(ButtonEvent.CLICK,this.onBtnFreezeClickHandler);
         tooltipSubscribe([this.btnFreeze,this.btnConfigure]);
         this.btnFreeze.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_FLAKE;
         this.btnFreeze.toggleEnable = true;
         this.btnConfigure.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_GEAR;
         invalidate([CSInvalidationType.VEHICLE_LABEL,RallyInvalidationType.VEHICLE_LABEL]);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(CSInvalidationType.VEHICLE_LABEL))
         {
            this.btnConfigure.x = Math.floor(lblTeamVehicles.x + lblTeamVehicles.textWidth + LABEL_ICON_GAP);
         }
         if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
         {
            this.btnFreeze.x = Math.floor(lblTeamMembers.x + lblTeamMembers.textWidth + LABEL_ICON_GAP);
         }
      }
      
      override protected function updateComponents() : void
      {
         super.updateComponents();
         var _loc1_:Boolean = Boolean(unitData) ? Boolean(unitData.isCommander) : Boolean(false);
         this.btnConfigure.visible = this.btnFreeze.visible = _loc1_;
         this.btnFreeze.selected = unitData.isFreezed;
         this.updateSettingsIcon();
      }
      
      override protected function updateTeamLabel() : void
      {
      }
      
      public function enableFreezeButton(param1:Boolean) : void
      {
         if(this.btnFreeze)
         {
            this.btnFreeze.enabled = param1;
         }
      }
      
      public function updateLockedUnit(param1:Boolean, param2:Array) : void
      {
         var _loc5_:RallySlotVO = null;
         var _loc3_:int = unitData.slots.length;
         unitData.isFreezed = param1;
         this.updateSettingsIcon();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getSlotModel(_loc4_) as RallySlotVO;
            App.utils.asserter.assertNotNull(_loc5_,"unitSlot " + Errors.CANT_NULL);
            _loc5_.isFreezed = param1;
            _loc5_.slotLabel = param2[_loc4_];
            setSlotModel(_loc4_,_loc5_);
            _loc4_++;
         }
      }
      
      private function updateSettingsIcon() : void
      {
         if(unitData && !unitData.isCommander)
         {
            this.settingsIcons.visible = true;
            this.settingsIcons.flakeVisible = Boolean(unitData) ? Boolean(unitData.isFreezed) : Boolean(false);
            this.settingsIcons.gearVisible = Boolean(unitData) ? Boolean(unitData.hasRestrictions) : Boolean(false);
         }
         else
         {
            this.settingsIcons.visible = false;
         }
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void
      {
         super.onControlRollOver(param1);
         var _loc2_:String = "";
         var _loc3_:String = "";
         switch(param1.currentTarget)
         {
            case this.btnFreeze:
               _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_FREEZE_HEADER;
               _loc3_ = rallyData && unitData.isFreezed ? TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYON : TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYOFF;
               showTooltip(_loc2_,_loc3_);
               break;
            case this.btnConfigure:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_CONFIGURE);
         }
      }
      
      private function onBtnFreezeClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_FREEZE_REQUEST));
      }
      
      private function onBtnConfigureClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.CLICK_CONFIGURE_BUTTON));
      }
   }
}
