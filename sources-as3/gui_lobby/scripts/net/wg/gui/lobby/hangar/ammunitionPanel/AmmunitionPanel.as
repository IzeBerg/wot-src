package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleStatusVO;
   import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
   import net.wg.infrastructure.base.meta.impl.AmmunitionPanelMeta;
   import net.wg.infrastructure.events.ChildVisibilityEvent;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.IUniversalBtn;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IUtils;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import scaleform.clik.events.ButtonEvent;
   
   public class AmmunitionPanel extends AmmunitionPanelMeta implements IAmmunitionPanel
   {
      
      public static const SLOTS_HEIGHT_AND_OFFSET:int = 30;
      
      private static const INV_BUTTONS_ENABLED:String = "InvButtonsEnabled";
      
      private static const VEHICLE_STATUS_INVALID:String = "vehicleStatusInvalid";
      
      private static const TO_RENT_LEFT_MARGIN:int = 5;
      
      private static const INV_MAINTENANCE_STATE:String = "InvMaintenanceState";
      
      private static const INV_TUNING_BUTTON_STATE:String = "InvTuningState";
      
      private static const INV_NATION_CHANGE_BUTTON_STATE:String = "invNationChangeState";
      
      private static const OFFSET_BTN_TO_RENT:int = 3;
      
      private static const INDENT_BETWEEN_BUTTONS:int = 11;
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(3,-1);
      
      private static const VEHICLE_STATUS_TO_BUTTONS_OFFSET_Y:int = -6;
      
      private static const SOUND_MAINTENANCE_BTN:String = "maitenanceBtn";
      
      private static const SOUND_TUNING_BTN:String = "tuningBtn";
      
      private static const SOUND_BTN_TYPE:String = "iconTextButton";
      
      private static const BTN_TEXT_FIELD_PADDING:int = 10;
       
      
      public var vehicleStatus:VehicleStatus = null;
      
      public var maintenanceBtn:UniversalBtn = null;
      
      public var tuningBtn:UniversalBtn = null;
      
      public var changeNationBtn:UniversalBtn = null;
      
      public var toRent:SoundButtonEx = null;
      
      private var _panelEnabled:Boolean = true;
      
      private var _maintenanceTooltip:String = "";
      
      private var _tuningTooltip:String = "";
      
      private var _maintenanceStateWarning:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _utils:IUtils;
      
      private var _statusVo:VehicleStatusVO = null;
      
      private var _screenWidth:int = 0;
      
      private var _counterManager:ICounterManager;
      
      private var _tuningBtnEnabled:Boolean = true;
      
      private var _changeNationBtnEnabled:Boolean;
      
      private var _changeNationTooltip:String;
      
      private var _changeNationBtnVisible:Boolean;
      
      private var _changeNationIsNew:Boolean;
      
      private var _animationEquipmentSlot:EquipmentSlot;
      
      private var _buttonWidth:int = 131;
      
      private var _buttonsList:Vector.<IUniversalBtn>;
      
      public function AmmunitionPanel()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._utils = App.utils;
         super();
         this._buttonsList = new <IUniversalBtn>[this.maintenanceBtn,this.tuningBtn,this.changeNationBtn];
         this._counterManager = App.utils.counterManager;
         this._animationEquipmentSlot = App.utils.classFactory.getComponent(Linkages.EQUIPMENT_SLOT_UI,EquipmentSlot);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.tuningBtn.enabled = false;
         App.waiting.addEventListener(ChildVisibilityEvent.CHILD_SHOWN,this.onChildShownHandler);
         App.waiting.addEventListener(ChildVisibilityEvent.CHILD_HIDDEN,this.onChildHiddenHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:IUniversalBtn = null;
         for each(_loc1_ in this._buttonsList)
         {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
            _loc1_.removeEventListener(Event.RESIZE,this.onResizeHandler);
         }
         this.maintenanceBtn.removeEventListener(ButtonEvent.CLICK,this.onMaintenanceBtnClickHandler);
         this.tuningBtn.removeEventListener(ButtonEvent.CLICK,this.onTuningBtnClickHandler);
         this.changeNationBtn.removeEventListener(ButtonEvent.CLICK,this.onChangeNationBtnClickHandler);
         App.waiting.removeEventListener(ChildVisibilityEvent.CHILD_SHOWN,this.onChildShownHandler);
         App.waiting.removeEventListener(ChildVisibilityEvent.CHILD_HIDDEN,this.onChildHiddenHandler);
         removeEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE,this.onAmmunitionPanelVehicleStateMsgResizeHandler);
         this.toRent.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         this.toRent.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
         this.toRent.removeEventListener(ButtonEvent.CLICK,this.onToRentClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this.tuningBtn);
         this._counterManager.removeCounter(this.changeNationBtn);
         this._counterManager = null;
         this.maintenanceBtn.dispose();
         this.maintenanceBtn = null;
         this.tuningBtn.dispose();
         this.tuningBtn = null;
         this.changeNationBtn.dispose();
         this.changeNationBtn = null;
         this.vehicleStatus.dispose();
         this.vehicleStatus = null;
         this.toRent.dispose();
         this.toRent = null;
         this._statusVo = null;
         this._toolTipMgr = null;
         this._utils = null;
         this._buttonsList.splice(0,this._buttonsList.length);
         this._buttonsList = null;
         this._animationEquipmentSlot.dispose();
         this._animationEquipmentSlot = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(INV_BUTTONS_ENABLED))
         {
            this.updateButtonsEnabled();
         }
         if(isInvalid(VEHICLE_STATUS_INVALID) && this._statusVo != null)
         {
            this.setVehicleStatus();
         }
         if(isInvalid(INV_MAINTENANCE_STATE))
         {
            this.maintenanceBtn.switchAlertIndicatorVisible(this._maintenanceStateWarning);
         }
         if(isInvalid(INV_TUNING_BUTTON_STATE))
         {
            if(App.waiting)
            {
               this.tuningBtn.enabled = this._tuningBtnEnabled && !App.waiting.isOnStage;
            }
            else
            {
               this.tuningBtn.enabled = this._tuningBtnEnabled;
            }
         }
         if(isInvalid(INV_NATION_CHANGE_BUTTON_STATE))
         {
            _loc1_ = this._changeNationBtnVisible != this.changeNationBtn.visible;
            this.changeNationBtn.visible = this._changeNationBtnVisible;
            if(this._changeNationIsNew && this._changeNationBtnVisible)
            {
               this._counterManager.setCounter(this.changeNationBtn,CounterManager.EXCLAMATION_COUNTER_VALUE,null,COUNTER_PROPS);
            }
            else
            {
               this._counterManager.removeCounter(this.changeNationBtn);
            }
            if(App.waiting)
            {
               this.changeNationBtn.enabled = this._changeNationBtnEnabled && !App.waiting.isOnStage;
            }
            else
            {
               this.changeNationBtn.enabled = this._changeNationBtnEnabled;
            }
            if(_loc1_)
            {
               this.centerPanel();
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.configButton(this.maintenanceBtn,MENU.HANGAR_AMMUNITIONPANEL_MAITENANCEBTN,this.onMaintenanceBtnClickHandler,SOUND_MAINTENANCE_BTN);
         this.configButton(this.tuningBtn,MENU.HANGAR_AMMUNITIONPANEL_TUNINGBTN,this.onTuningBtnClickHandler,SOUND_TUNING_BTN);
         this.configButton(this.changeNationBtn,MENU.HANGAR_AMMUNITIONPANEL_NATIONCHANGEBTN,this.onChangeNationBtnClickHandler,SOUND_TUNING_BTN);
         this.toRent.addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         this.toRent.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
         this.toRent.addEventListener(ButtonEvent.CLICK,this.onToRentClickHandler);
         addEventListener(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE,this.onAmmunitionPanelVehicleStateMsgResizeHandler);
         this._utils.helpLayout.registerComponent(this);
         _deferredDispose = true;
      }
      
      override protected function updateVehicleStatus(param1:VehicleStatusVO) : void
      {
         this._statusVo = param1;
         invalidate(VEHICLE_STATUS_INVALID);
      }
      
      public function as_setCustomizationBtnCounter(param1:int) : void
      {
         if(param1 > 0)
         {
            this._counterManager.setCounter(this.tuningBtn,param1.toString());
         }
         else
         {
            this._counterManager.removeCounter(this.tuningBtn);
         }
      }
      
      public function as_setWarningState(param1:Boolean) : void
      {
         this._maintenanceStateWarning = param1;
         invalidate(INV_MAINTENANCE_STATE);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.toRent;
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         return new <HelpLayoutVO>[this.vehicleStatus.createHelpLayoutData()];
      }
      
      public function updateAmmunitionPanel(param1:Boolean, param2:String) : void
      {
         this._panelEnabled = param1;
         this._maintenanceTooltip = param2;
         invalidate(INV_BUTTONS_ENABLED);
      }
      
      public function updateChangeNationButton(param1:Boolean, param2:Boolean, param3:String, param4:Boolean) : void
      {
         this._changeNationBtnVisible = param1;
         this._changeNationBtnEnabled = param2;
         this._changeNationIsNew = param4;
         this._changeNationTooltip = param3;
         invalidate(INV_NATION_CHANGE_BUTTON_STATE);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.vehicleStatus.updateStage(param1,param2);
         this._screenWidth = param1;
         this.centerPanel();
      }
      
      public function updateTuningButton(param1:Boolean, param2:String) : void
      {
         this._tuningBtnEnabled = param1;
         this._tuningTooltip = param2;
         invalidate(INV_TUNING_BUTTON_STATE);
      }
      
      private function updateButtonsEnabled() : void
      {
         this.maintenanceBtn.enabled = this._panelEnabled;
      }
      
      private function centerPanel() : void
      {
         this.x = this._screenWidth - this.width >> 1;
         this.maintenanceBtn.x = 0;
         this.tuningBtn.x = this.maintenanceBtn.x + this._buttonWidth + INDENT_BETWEEN_BUTTONS;
         this.changeNationBtn.x = this.tuningBtn.x + this._buttonWidth + INDENT_BETWEEN_BUTTONS;
         this.placeVehicleStatus();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function placeVehicleStatus() : void
      {
         this.vehicleStatus.x = this.width >> 1;
         this.vehicleStatus.y = this.maintenanceBtn.y - this.vehicleStatus.height + VEHICLE_STATUS_TO_BUTTONS_OFFSET_Y | 0;
      }
      
      private function configButton(param1:UniversalBtn, param2:String, param3:Function, param4:String) : void
      {
         param1.label = param2;
         param1.mouseEnabledOnDisabled = true;
         param1.soundType = SOUND_BTN_TYPE;
         param1.soundId = param4;
         param1.changeSizeOnlyUpwards = true;
         param1.width = this._buttonWidth;
         param1.paddingHorizontal = BTN_TEXT_FIELD_PADDING;
         param1.addEventListener(ButtonEvent.CLICK,param3);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
         param1.addEventListener(Event.RESIZE,this.onResizeHandler);
         App.utils.universalBtnStyles.setStyle(param1,UniversalBtnStylesConst.STYLE_SLIM_GREEN);
      }
      
      private function setVehicleStatus() : void
      {
         this.vehicleStatus.setData(this._statusVo);
         if(this._statusVo.rentAvailable)
         {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         }
      }
      
      override public function get width() : Number
      {
         var _loc1_:int = 2 * this._buttonWidth + INDENT_BETWEEN_BUTTONS;
         if(this._changeNationBtnVisible)
         {
            _loc1_ += this._buttonWidth + INDENT_BETWEEN_BUTTONS;
         }
         return _loc1_;
      }
      
      private function onAmmunitionPanelVehicleStateMsgResizeHandler(param1:AmmunitionPanelEvents) : void
      {
         if(this._statusVo != null)
         {
            this.placeVehicleStatus();
            this.toRent.x = this.vehicleStatus.statusEndX + TO_RENT_LEFT_MARGIN;
            this.toRent.y = this.vehicleStatus.statusStartY + OFFSET_BTN_TO_RENT;
            this.toRent.visible = this._statusVo.rentAvailable;
         }
      }
      
      private function onMaintenanceBtnClickHandler(param1:ButtonEvent) : void
      {
         showRepairDialogS();
      }
      
      private function onTuningBtnClickHandler(param1:ButtonEvent) : void
      {
         showCustomizationS();
      }
      
      private function onChangeNationBtnClickHandler(param1:ButtonEvent) : void
      {
         showChangeNationS();
      }
      
      private function onBtnRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ITooltipFormatter = null;
         if(param1.target == this.toRent)
         {
            _loc3_ = this._toolTipMgr.getNewFormatter();
            _loc3_.addBody(TOOLTIPS.HANGAR_STATUS_TORENT,true);
            _loc2_ = _loc3_.make();
         }
         else if(param1.target == this.maintenanceBtn)
         {
            _loc2_ = this._maintenanceTooltip;
         }
         else if(param1.target == this.tuningBtn)
         {
            _loc2_ = this._tuningTooltip;
         }
         else if(param1.target == this.changeNationBtn)
         {
            _loc2_ = this._changeNationTooltip;
         }
         this._toolTipMgr.showComplex(_loc2_);
      }
      
      private function onBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onToRentClickHandler(param1:ButtonEvent) : void
      {
         if(this._statusVo.rentAvailable)
         {
            toRentContinueS();
         }
      }
      
      private function onChildShownHandler(param1:ChildVisibilityEvent) : void
      {
         if(this.tuningBtn)
         {
            this.tuningBtn.enabled = false;
         }
      }
      
      private function onChildHiddenHandler(param1:ChildVisibilityEvent) : void
      {
         this.updateTuningButton(this._tuningBtnEnabled,this._tuningTooltip);
         this.updateChangeNationButton(this._changeNationBtnVisible,this._changeNationBtnEnabled,this._changeNationTooltip,this._changeNationIsNew);
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         var _loc2_:IUniversalBtn = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.currentTarget.width > this._buttonWidth)
         {
            this._buttonWidth = param1.currentTarget.width;
            _loc3_ = this._buttonsList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = this._buttonsList[_loc4_];
               if(_loc2_.width != this._buttonWidth)
               {
                  _loc2_.setSize(this._buttonWidth,_loc2_.height);
               }
               _loc4_++;
            }
            this.centerPanel();
         }
      }
   }
}
