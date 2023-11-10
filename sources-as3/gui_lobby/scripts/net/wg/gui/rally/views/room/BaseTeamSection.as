package net.wg.gui.rally.views.room
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.rally.BaseRallyMainWindow;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IBaseTeamSection;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.gui.rally.vo.RallySlotVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class BaseTeamSection extends UIComponentEx implements IBaseTeamSection
   {
      
      private static const DISABLED_STATE:String = "disabled";
       
      
      public var lblTeamMembers:TextField;
      
      public var lblTeamVehicles:TextField;
      
      public var lblStatus:TextField;
      
      public var btnFight:SoundButtonEx;
      
      public var btnNotReady:SoundButtonEx;
      
      protected var _slotsUi:Vector.<IRallySimpleSlotRenderer>;
      
      private var _rallyData:IRallyVO;
      
      private var _actionButtonData:ActionButtonVO;
      
      private var _isFightBtnInCoolDown:Boolean = false;
      
      private var _vehiclesLabel:String = "";
      
      private var _teamLabel:String = "";
      
      private var _entireSelectArea:Boolean = false;
      
      public function BaseTeamSection()
      {
         super();
         this._slotsUi = this.getSlotsUI();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateTeamLabel();
         this.btnFight.addEventListener(ButtonEvent.CLICK,this.onReadyToggleClickHandler);
         if(this.btnNotReady)
         {
            this.btnNotReady.addEventListener(ButtonEvent.CLICK,this.onReadyToggleClickHandler);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
         {
            this.lblTeamVehicles.htmlText = this.vehiclesLabel;
         }
         if(isInvalid(RallyInvalidationType.TEAM_LABEL))
         {
            this.lblTeamMembers.htmlText = this._teamLabel;
         }
         if(isInvalid(RallyInvalidationType.RALLY_DATA) && this._rallyData)
         {
            this.updateDynamicSlots();
            this.updateComponents();
            this.updateTeamLabel();
         }
         if(isInvalid(RallyInvalidationType.ACTION_BUTTON_DATA))
         {
            if(this._actionButtonData)
            {
               this.lblStatus.htmlText = this._actionButtonData.stateString;
               this.btnFight.visible = !this._actionButtonData.isReady;
               this.btnFight.enabled = this._actionButtonData.isEnabled && !this._isFightBtnInCoolDown;
               this.btnFight.label = this._actionButtonData.label;
               if(!this.btnFight.enabled && this.btnFight.state != DISABLED_STATE)
               {
                  this.btnFight.setDisabled();
               }
               if(this._actionButtonData.toolTipData && StringUtils.isNotEmpty(this.actionButtonData.toolTipData))
               {
                  this.btnFight.tooltip = this._actionButtonData.toolTipData;
               }
               this.btnFight.mouseEnabledOnDisabled = true;
               this.btnFight.invalidateState();
               if(this.btnNotReady)
               {
                  this.btnNotReady.visible = this._actionButtonData.isReady;
                  this.btnNotReady.enabled = this._actionButtonData.isEnabled && !this._isFightBtnInCoolDown;
                  this.btnNotReady.label = this._actionButtonData.label;
                  if(!this.btnNotReady.enabled && this.btnNotReady.state != DISABLED_STATE)
                  {
                     this.btnNotReady.setDisabled();
                  }
                  if(this._actionButtonData.toolTipData && StringUtils.isNotEmpty(this.actionButtonData.toolTipData))
                  {
                     this.btnNotReady.tooltip = this._actionButtonData.toolTipData;
                  }
                  this.btnNotReady.invalidateState();
               }
            }
            else
            {
               this.lblStatus.htmlText = Values.EMPTY_STR;
               this.btnFight.enabled = false;
               this.btnFight.label = Values.EMPTY_STR;
               if(this.btnNotReady)
               {
                  this.btnNotReady.enabled = false;
                  this.btnNotReady.label = Values.EMPTY_STR;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IRallySimpleSlotRenderer = null;
         this.btnFight.removeEventListener(ButtonEvent.CLICK,this.onReadyToggleClickHandler);
         this.btnFight.dispose();
         this.btnFight = null;
         if(this.btnNotReady)
         {
            this.btnNotReady.removeEventListener(ButtonEvent.CLICK,this.onReadyToggleClickHandler);
            this.btnNotReady.dispose();
            this.btnNotReady = null;
         }
         this.assertSlotsNotNull();
         while(this._slotsUi.length)
         {
            _loc1_ = this._slotsUi.pop();
            _loc1_.dispose();
         }
         this._slotsUi = null;
         this.lblTeamMembers = null;
         this.lblTeamVehicles = null;
         this.lblStatus = null;
         this._rallyData = null;
         this._actionButtonData = null;
         super.onDispose();
      }
      
      public function cooldownSlots(param1:Boolean) : void
      {
      }
      
      public function enableFightButton(param1:Boolean) : void
      {
         this._isFightBtnInCoolDown = !param1;
         if(this.btnFight)
         {
            this.btnFight.enabled = param1 && (Boolean(this._actionButtonData) ? Boolean(this._actionButtonData.isEnabled) : Boolean(true));
         }
         if(this.btnNotReady)
         {
            this.btnNotReady.enabled = param1 && (Boolean(this._actionButtonData) ? Boolean(this._actionButtonData.isEnabled) : Boolean(true));
         }
      }
      
      public function highlightSlots(param1:Array) : void
      {
      }
      
      public function setMemberStatus(param1:uint, param2:uint) : void
      {
         var _loc3_:IRallySlotVO = this.getSlotModel(param1);
         _loc3_.playerStatus = param2;
         this.setSlotModel(param1,_loc3_);
      }
      
      public function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void
      {
         var _loc4_:IRallySlotVO = this.getSlotModel(param1);
         _loc4_.selectedVehicle = param3;
         _loc4_.selectedVehicleLevel = param2;
         this.setSlotModel(param1,_loc4_);
      }
      
      public function setOfflineStatus(param1:uint, param2:Boolean) : void
      {
         var _loc3_:IRallySlotVO = this.getSlotModel(param1);
         _loc3_.player.isOffline = param2;
         this.setSlotModel(param1,_loc3_);
      }
      
      public function setVehiclesInfoTooltipId(param1:String, param2:Object, param3:Object) : void
      {
      }
      
      public function updateMembers(param1:Boolean, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc5_:IRallySlotVO = null;
         var _loc4_:int = param2.length;
         this._rallyData.clearSlots();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.getSlotVO(param2[_loc3_]);
            this._rallyData.addSlot(_loc5_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.setSlotModel(_loc3_,IRallySlotVO(this._rallyData.slotsArray[_loc3_]));
            _loc3_++;
         }
         this.updateTeamLabel();
      }
      
      protected function updateTeamLabel() : void
      {
         this.teamLabel = BaseRallyMainWindow.getTeamHeader(this.getMembersStr(),this._rallyData);
      }
      
      protected function getSlotVO(param1:Object) : IRallySlotVO
      {
         return new RallySlotVO(param1);
      }
      
      protected function getMembersStr() : String
      {
         return null;
      }
      
      protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
      {
         return new Vector.<IRallySimpleSlotRenderer>();
      }
      
      protected function updateDynamicSlots() : void
      {
      }
      
      protected function updateComponents() : void
      {
         var _loc6_:Number = NaN;
         var _loc1_:Array = Boolean(this._rallyData) ? this._rallyData.slotsArray : null;
         var _loc2_:RallySimpleSlotRenderer = null;
         var _loc3_:IRallySlotVO = null;
         this.assertSlotsNotNull();
         var _loc4_:int = _loc1_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = RallySimpleSlotRenderer(this._slotsUi[_loc5_]);
            _loc6_ = this._slotsUi.indexOf(_loc2_);
            if(_loc1_ != null)
            {
               _loc3_ = IRallySlotVO(_loc1_[_loc6_]);
            }
            _loc2_.slotData = _loc3_;
            _loc5_++;
         }
      }
      
      protected function updateRenderIcon(param1:ISlotDropIndicator) : void
      {
      }
      
      protected function tooltipSubscribe(param1:Array, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = null;
         for each(_loc3_ in param1)
         {
            if(param2)
            {
               _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
               _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            }
            else
            {
               _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
               _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            }
         }
      }
      
      protected function getSlotModel(param1:uint) : IRallySlotVO
      {
         return IRallySlotVO(this._rallyData.slotsArray[param1]);
      }
      
      protected function setSlotModel(param1:uint, param2:IRallySlotVO) : void
      {
         IRallySimpleSlotRenderer(this._slotsUi[param1]).slotData = param2;
      }
      
      private function assertSlotsNotNull() : void
      {
         App.utils.asserter.assertNotNull(this._slotsUi,"_slotsUi" + Errors.CANT_NULL);
      }
      
      public function get actionButtonData() : ActionButtonVO
      {
         return this._actionButtonData;
      }
      
      public function set actionButtonData(param1:ActionButtonVO) : void
      {
         this._actionButtonData = param1;
         invalidate(RallyInvalidationType.ACTION_BUTTON_DATA);
      }
      
      public function set teamLabel(param1:String) : void
      {
         if(this._teamLabel == param1)
         {
            return;
         }
         this._teamLabel = param1;
         invalidate(RallyInvalidationType.TEAM_LABEL);
         validateNow();
      }
      
      public function get vehiclesLabel() : String
      {
         return this._vehiclesLabel;
      }
      
      public function set vehiclesLabel(param1:String) : void
      {
         this._vehiclesLabel = param1;
         invalidate(RallyInvalidationType.VEHICLE_LABEL);
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get rallyData() : IRallyVO
      {
         return this._rallyData;
      }
      
      public function set rallyData(param1:IRallyVO) : void
      {
         this._rallyData = param1;
         invalidate(RallyInvalidationType.RALLY_DATA);
      }
      
      public function get entireSelectArea() : Boolean
      {
         return this._entireSelectArea;
      }
      
      public function set entireSelectArea(param1:Boolean) : void
      {
         this._entireSelectArea = param1;
      }
      
      protected function onControlRollOver(param1:MouseEvent) : void
      {
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         this.onControlRollOver(param1);
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onReadyToggleClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Object = {
            "uiid":param1.target.UIID,
            "arg":(!!this._rallyData.isCommander ? 0 : 1)
         };
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.TOGGLE_READY_STATE_REQUEST,_loc2_));
      }
   }
}
