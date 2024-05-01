package net.wg.gui.lobby.fortifications.cmp.selector
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.lobby.eventBoards.components.VehicleSelectorItemRenderer;
   import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectorItemVO;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class FortVehicleSelectorRenderer extends VehicleSelectorItemRenderer
   {
      
      private static const MULTI_FLAG_X:int = 54;
      
      private static const DEF_FLAG_X:int = 11;
      
      private static const MULTI_MIDDLE_TYPE_X:int = 105;
      
      private static const DEF_MIDDLE_TYPE_X:int = 60;
      
      private static const MULTI_LEVEL_X:int = 137;
      
      private static const DEF_LEVEL_X:int = 92;
      
      private static const MULTI_IMAGE_X:int = 165;
      
      private static const DEF_IMAGE_X:int = 120;
      
      private static const MULTI_NAME_X:int = 237;
      
      private static const DEF_NAME_X:int = 195;
      
      private static const OVER_STATE:String = "over";
      
      private static const FROZEN_VEHICLE_STATE:String = "frozenVehicle";
       
      
      public var checkBox:CheckBox;
      
      public var notReadyAlert:MovieClip;
      
      public var vehicleFrozenIcon:Sprite;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _itemVO:FortVehicleSelectorItemVO = null;
      
      private var _multiSelectionMode:Boolean = false;
      
      private var _isVehicleReady:Boolean = true;
      
      private var _isMouseOver:Boolean;
      
      private var _vehicleFrozenIconOriginX:Number = 0;
      
      public function FortVehicleSelectorRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         var _loc2_:FortVehicleSelectorItemVO = FortVehicleSelectorItemVO(param1);
         if(_loc2_)
         {
            this._multiSelectionMode = _loc2_.isMultiSelect;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._vehicleFrozenIconOriginX = this.vehicleFrozenIcon.x;
         this.notReadyAlert.visible = false;
         this.vehicleFrozenIcon.visible = false;
         mouseEnabledOnDisabled = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onRendererDoubleClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onRendererDoubleClickHandler);
         this.notReadyAlert = null;
         this.vehicleFrozenIcon = null;
         this.checkBox.dispose();
         this.checkBox = null;
         this._tooltipMgr = null;
         this._itemVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         this._itemVO = FortVehicleSelectorItemVO(dataVO);
         if(this._itemVO && isInvalid(InvalidationType.DATA))
         {
            this.checkBox.selected = this._itemVO.selected;
            this._isVehicleReady = !this._multiSelectionMode ? Boolean(this._itemVO.isReadyToFight) : Boolean(true);
            this.notReadyAlert.visible = !this._isVehicleReady;
            this.vehicleFrozenIcon.visible = this._itemVO.isFrozen;
            if(this._isVehicleReady)
            {
               this.vehicleFrozenIcon.x = this._vehicleFrozenIconOriginX;
            }
            else
            {
               this.vehicleFrozenIcon.x = this.notReadyAlert.x + this.notReadyAlert.width;
            }
            if(!this._multiSelectionMode)
            {
               enabled = this._itemVO.enabled;
            }
            if(this._isMouseOver)
            {
               if(!enabled)
               {
                  this.showAlertTooltip();
               }
               else
               {
                  if(!selected)
                  {
                     gotoAndPlay(OVER_STATE);
                  }
                  if(this._itemVO.isFrozen)
                  {
                     this.showAlertTooltip();
                  }
                  else
                  {
                     this.hideTooltip();
                  }
               }
            }
            this.updateLayout();
         }
      }
      
      override protected function updateLayout() : void
      {
         this.checkBox.visible = this._multiSelectionMode;
         if(this._multiSelectionMode)
         {
            flagLoader.x = MULTI_FLAG_X;
            vehicleTypeIcon.x = MULTI_MIDDLE_TYPE_X - (vehicleTypeIcon.width >> 1);
            levelIcon.x = MULTI_LEVEL_X - (levelIcon.width >> 1);
            tankIcon.x = MULTI_IMAGE_X;
            vehicleNameTF.x = MULTI_NAME_X;
         }
         else
         {
            flagLoader.x = DEF_FLAG_X;
            vehicleTypeIcon.x = DEF_MIDDLE_TYPE_X - (vehicleTypeIcon.width >> 1);
            levelIcon.x = DEF_LEVEL_X - (levelIcon.width >> 1);
            tankIcon.x = DEF_IMAGE_X;
            vehicleNameTF.x = DEF_NAME_X;
         }
      }
      
      private function showAlertTooltip() : void
      {
         var _loc1_:ITooltipFormatter = null;
         if(this._itemVO.state && this._itemVO.state != Values.EMPTY_STR)
         {
            _loc1_ = this._tooltipMgr.getNewFormatter();
            if(this._itemVO.state == FROZEN_VEHICLE_STATE)
            {
               _loc1_.addBody(TOOLTIPS.VEHICLESTATUS_STRONGHOLDEVENTFROZEN_BODY,true);
            }
            else
            {
               _loc1_.addHeader(this._itemVO.state);
               _loc1_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
            }
            this._tooltipMgr.showComplex(_loc1_.make());
         }
         else
         {
            this._tooltipMgr.show(TOOLTIPS.CYBERSPORT_VEHICLESELECTOR_NOTREADY);
         }
      }
      
      private function hideTooltip() : void
      {
         this._tooltipMgr.hide();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         this._isMouseOver = true;
         if(this.vehicleFrozenIcon.visible && mouseX >= this.vehicleFrozenIcon.x)
         {
            this._tooltipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_VEHBROKENICON);
         }
         else if(this.notReadyAlert.visible)
         {
            this.showAlertTooltip();
         }
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         this._isMouseOver = false;
         this.hideTooltip();
         super.handleMouseRollOut(param1);
      }
      
      private function onRendererDoubleClickHandler(param1:MouseEvent) : void
      {
         if(!enabled || this._multiSelectionMode)
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new VehicleSelectRendererEvent(VehicleSelectRendererEvent.RENDERER_CLICK,dataVO.dbID,true,true));
         }
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
