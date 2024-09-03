package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ListItemRendererWithFocusOnDis;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.MouseEventEx;
   
   public class VehicleSelectorItemRenderer extends ListItemRendererWithFocusOnDis
   {
      
      private static const MODE_MULTI:String = "multiSelection";
      
      private static const MODE_SINGLE:String = "singleSelection";
      
      private static const LAYOUT_CONFIG:Object = {
         "multiSelection":{
            "flagX":40,
            "vTypeX":78,
            "vLevelX":110,
            "vImageX":148,
            "vNameX":222
         },
         "singleSelection":{
            "flagX":7,
            "vTypeX":46,
            "vLevelX":78,
            "vImageX":116,
            "vNameX":192
         }
      };
       
      
      public var checkBox:CheckBox;
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:MovieClip;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      public var notReadyAlert:MovieClip;
      
      public var bg:MovieClip;
      
      public var disabledMC:MovieClip;
      
      public var settingsAlert:UILoaderAlt = null;
      
      protected var model:VehicleSelectorItemVO;
      
      protected var statesSelectedNotReady:Vector.<String>;
      
      protected var statesNotReady:Vector.<String>;
      
      private var _multiSelectionMode:Boolean = false;
      
      private var _userVehiclesMode:Boolean = false;
      
      private var _isVehicleReady:Boolean = true;
      
      private var _mouseOverAlert:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function VehicleSelectorItemRenderer()
      {
         this.statesSelectedNotReady = Vector.<String>(["notReady_selected_",""]);
         this.statesNotReady = Vector.<String>(["notReady_",""]);
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.notReadyAlert.visible = false;
         preventAutosizing = true;
         mouseEnabledOnDisabled = true;
         this.settingsAlert.autoSize = false;
         this.notReadyAlert.addEventListener(MouseEvent.ROLL_OVER,this.onNotReadyAlertRollOverHandler);
         this.notReadyAlert.addEventListener(MouseEvent.ROLL_OUT,this.onNotReadyAlertRollOutHandler);
         this.notReadyAlert.addEventListener(MouseEvent.CLICK,this.onNotReadyAlertClickHandler);
      }
      
      override public function getData() : Object
      {
         return this.model;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.model = param1 as VehicleSelectorItemVO;
         if(this.model)
         {
            visible = true;
            invalidateData();
         }
         else
         {
            visible = false;
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         var _loc1_:Boolean = Boolean(this.model) ? Boolean(this.model.selected) : Boolean(false);
         return !!_loc1_ ? (!!this._isVehicleReady ? statesSelected : this.statesSelectedNotReady) : (!!this._isVehicleReady ? statesDefault : this.statesNotReady);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this.checkBox.label = Values.EMPTY_STR;
         addEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onRendererDoubleClickHandler);
         this.updateModeLayout();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(this.model && isInvalid(InvalidationType.DATA))
         {
            if(selected)
            {
               this.dispatchVehicleSelector(false);
            }
            else
            {
               setState(state);
            }
            this.settingsAlert.visible = this.model.showAlert;
            if(this.model.showAlert)
            {
               this.settingsAlert.source = this.model.alertSource;
            }
            this._isVehicleReady = !!this._userVehiclesMode ? Boolean(this.model.isReadyToFight) : Boolean(true);
            this.updateAlertState(!this._isVehicleReady);
            _loc1_ = new Point(mouseX,mouseY);
            _loc1_ = localToGlobal(_loc1_);
            _loc2_ = this.notReadyAlert.visible && this.notReadyAlert.hitTestPoint(_loc1_.x,_loc1_.y,true);
            if(_loc2_)
            {
               this.showAlertTooltip();
            }
            else if(!enabled && !this._mouseOverAlert && this.model.tooltip && this.hitTestPoint(_loc1_.x,_loc1_.y,true))
            {
               this._toolTipMgr.showComplex(this.model.tooltip);
            }
            this.checkBox.selected = this.model.selected;
            this.vehicleNameTF.htmlText = this.model.shortUserName;
            this.vehicleTypeIcon.gotoAndStop(this.model.type);
            this.levelIcon.gotoAndStop(this.model.level);
            this.flagLoader.source = App.utils.nations.getNationIcon(this.model.nationID);
            this.tankIcon.source = this.model.smallIconPath;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(this.bg)
            {
               this.bg.mouseEnabled = false;
            }
            if(this.disabledMC)
            {
               this.disabledMC.mouseEnabled = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.statesSelectedNotReady.splice(0,this.statesSelectedNotReady.length);
         this.statesSelectedNotReady = null;
         this.statesNotReady.splice(0,this.statesNotReady.length);
         this.statesNotReady = null;
         removeEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onRendererDoubleClickHandler);
         this.model = null;
         this.notReadyAlert.removeEventListener(MouseEvent.ROLL_OVER,this.onNotReadyAlertRollOverHandler);
         this.notReadyAlert.removeEventListener(MouseEvent.ROLL_OUT,this.onNotReadyAlertRollOutHandler);
         this.notReadyAlert.removeEventListener(MouseEvent.CLICK,this.onNotReadyAlertClickHandler);
         this.checkBox.dispose();
         this.flagLoader.dispose();
         this.tankIcon.dispose();
         this.settingsAlert.dispose();
         this.disabledMC = null;
         this.bg = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon = null;
         this.checkBox = null;
         this.flagLoader = null;
         this.tankIcon = null;
         this.settingsAlert = null;
         this.notReadyAlert = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      protected function getLayoutConfig(param1:String) : Object
      {
         return LAYOUT_CONFIG[param1];
      }
      
      private function updateAlertState(param1:Boolean) : void
      {
         this.notReadyAlert.visible = param1;
         this.notReadyAlert.buttonMode = param1 && enabled;
         this.notReadyAlert.mouseEnabled = param1;
      }
      
      private function showAlertTooltip() : void
      {
         var _loc1_:ITooltipFormatter = null;
         if(this.model.state && this.model.state != Values.EMPTY_STR)
         {
            _loc1_ = this._toolTipMgr.getNewFormatter();
            _loc1_.addHeader(this.model.state);
            _loc1_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
            this._toolTipMgr.showComplex(_loc1_.make());
         }
         else
         {
            this._toolTipMgr.show(TOOLTIPS.CYBERSPORT_VEHICLESELECTOR_NOTREADY);
         }
      }
      
      private function showDisabledToolTip() : void
      {
         if(this.model && this.model.tooltip && !enabled && !this._mouseOverAlert)
         {
            this._toolTipMgr.showComplex(this.model.tooltip);
         }
      }
      
      private function updateModeLayout() : void
      {
         var _loc3_:Object = null;
         var _loc1_:VehicleSelector = owner.parent as VehicleSelector;
         if(_loc1_)
         {
            this._multiSelectionMode = _loc1_.multiSelection;
            this._userVehiclesMode = _loc1_.isUserVehiclesMode;
         }
         else
         {
            this._multiSelectionMode = false;
         }
         var _loc2_:String = !!this._multiSelectionMode ? MODE_MULTI : MODE_SINGLE;
         _loc3_ = this.getLayoutConfig(_loc2_);
         this.flagLoader.x = _loc3_.flagX;
         this.vehicleTypeIcon.x = _loc3_.vTypeX;
         this.levelIcon.x = _loc3_.vLevelX;
         this.tankIcon.x = _loc3_.vImageX;
         this.vehicleNameTF.x = _loc3_.vNameX;
         this.checkBox.visible = this._multiSelectionMode;
      }
      
      private function dispatchVehicleSelector(param1:Boolean = false) : void
      {
         if(!this.model)
         {
            return;
         }
         this.model.selected = !!this._multiSelectionMode ? Boolean(!this.model.selected) : Boolean(true);
         setState(state);
         invalidate(InvalidationType.DATA);
         dispatchEvent(new VehicleSelectorItemEvent(VehicleSelectorItemEvent.SELECT_VEHICLE,this.model,true,false,param1));
         if(owner)
         {
            owner.invalidate(InvalidationType.STATE);
         }
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.checkBox.enabled = param1;
         mouseChildren = param1;
         buttonMode = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(!enabled)
         {
            return;
         }
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ENTER:
               if(_loc2_.value == InputValue.KEY_DOWN && !this._multiSelectionMode)
               {
                  this.dispatchVehicleSelector(true);
               }
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showDisabledToolTip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.hideTooltip();
      }
      
      private function onNotReadyAlertRollOverHandler(param1:MouseEvent) : void
      {
         this._mouseOverAlert = true;
         if(!enabled)
         {
            this.hideTooltip();
         }
         this.showAlertTooltip();
      }
      
      private function onNotReadyAlertClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onNotReadyAlertRollOutHandler(param1:MouseEvent) : void
      {
         this._mouseOverAlert = false;
         this.hideTooltip();
         this.showDisabledToolTip();
      }
      
      private function onRendererClickHandler(param1:ButtonEvent) : void
      {
         this.hideTooltip();
         if(!enabled)
         {
            return;
         }
         this.dispatchVehicleSelector(false);
      }
      
      private function onRendererDoubleClickHandler(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(!this._multiSelectionMode)
         {
            this.dispatchVehicleSelector(true);
         }
      }
   }
}
