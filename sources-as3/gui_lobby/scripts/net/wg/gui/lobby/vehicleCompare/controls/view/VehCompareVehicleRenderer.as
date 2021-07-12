package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehCompareVehicleRenderer extends ListItemRenderer implements IScrollerItemRenderer, IPopOverCaller
   {
      
      private static const INVALIATE_RENDERER_DATA:String = "invaliate_renderer_data";
      
      private static const TANK_NAME_Y_OFFSET:int = -6;
      
      private static const ADD_BTN_ALPHA:Number = 0.25;
      
      private static const BTN_GAP:int = 5;
       
      
      public var closeBtn:ISoundButtonEx = null;
      
      public var moduleBtn:ISoundButtonEx = null;
      
      public var revertBtn:ISoundButtonEx = null;
      
      public var addVehicleBtn:Sprite = null;
      
      public var btnHover:Sprite = null;
      
      public var vehicleIcon:TankIcon = null;
      
      public var separator:Sprite = null;
      
      public var noVehicleTf:TextField = null;
      
      public var addVehicleTF:TextField = null;
      
      public var configTypeTF:TextField = null;
      
      public var attentionIcon:Sprite;
      
      private var _commons:ICommons = null;
      
      private var _rendererData:VehCompareVehicleVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function VehCompareVehicleRenderer()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         cacheAsBitmap = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         mouseEnabled = true;
         buttonMode = false;
         this.noVehicleTf.mouseWheelEnabled = false;
         this.noVehicleTf.mouseEnabled = false;
         this.noVehicleTf.text = VEH_COMPARE.VEHICLECOMPAREVIEW_TOPPANEL_NOVEHICLE;
         this.closeBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_REMOVEFROMCOMPARE;
         this.addVehicleTF.text = VEH_COMPARE.VEHICLECOMPAREVIEW_BTNADDVEHICLES;
         this.addVehicleTF.visible = false;
         this.revertBtn.addEventListener(ButtonEvent.CLICK,this.onRevertBtnClickHandler);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.moduleBtn.addEventListener(ButtonEvent.CLICK,this.onModuleBtnClickHandler);
         this.vehicleIcon.addEventListener(MouseEvent.CLICK,this.onVehicleIconClickHandler);
         this.vehicleIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onVehicleIconMouseOverHandler);
         this.vehicleIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onVehicleIconMouseOutHandler);
         this.addVehicleBtn.addEventListener(MouseEvent.CLICK,this.onAddVehicleBtnClickHandler);
         this.addVehicleBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onAddVehicleBtnMouseOverHandler);
         this.addVehicleBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onAddVehicleBtnMouseOutHandler);
         this.addVehicleBtn.buttonMode = true;
         this.addVehicleBtn.alpha = ADD_BTN_ALPHA;
         this.moduleBtn.tooltip = VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_CONFIGURE;
         this.moduleBtn.label = VEH_COMPARE.VEHICLECOMPAREVIEW_CONFIGURE;
         this.vehicleIcon.tankNameField.y += TANK_NAME_Y_OFFSET;
         this.vehicleIcon.mouseChildren = false;
         this.vehicleIcon.buttonMode = true;
         this.vehicleIcon.hitArea = this.btnHover;
         this.vehicleIcon.isForCompare = true;
         this.btnHover.mouseEnabled = this.btnHover.mouseChildren = false;
         this.revertBtn.visible = false;
         this.revertBtn.tooltip = VEH_COMPARE.VEHCONF_TOOLTIPS_REVERTBTN;
         this.addVehicleBtn.visible = false;
         this.attentionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAttentionIconRollOverHandler);
         this.attentionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onAttentionIconRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(INVALIATE_RENDERER_DATA))
         {
            _loc1_ = this._rendererData != null;
            if(_loc1_)
            {
               _loc1_ = !this._rendererData.isFirstEmptySlot;
            }
            this.btnHover.visible = false;
            this.vehicleIcon.visible = _loc1_;
            this.moduleBtn.visible = _loc1_;
            this.closeBtn.visible = _loc1_;
            this.configTypeTF.visible = _loc1_;
            this.noVehicleTf.visible = !_loc1_ && !(this._rendererData && this._rendererData.isFirstEmptySlot);
            this.addVehicleBtn.visible = this._rendererData && this._rendererData.isFirstEmptySlot;
            this.attentionIcon.visible = false;
            this.revertBtn.visible = false;
            mouseEnabled = mouseChildren = !this.noVehicleTf.visible;
            this.vehicleIcon.hitArea = !!_loc1_ ? this.btnHover : null;
            if(_loc1_)
            {
               this.vehicleIcon.nation = this._rendererData.nation;
               this.vehicleIcon.image = this._rendererData.image;
               this.vehicleIcon.showName = true;
               this.vehicleIcon.tankName = this._rendererData.label;
               this.vehicleIcon.level = this._rendererData.level;
               this.vehicleIcon.isElite = this._rendererData.premium;
               this.vehicleIcon.isPremium = this._rendererData.premium;
               this.vehicleIcon.tankType = this._rendererData.tankType;
               this.vehicleIcon.validateNow();
               this.moduleBtn.visible = true;
               this.configTypeTF.visible = true;
               this.configTypeTF.htmlText = this._rendererData.moduleType;
               this.attentionIcon.visible = this._rendererData.isAttention;
               this.revertBtn.visible = this._rendererData.showRevertBtn;
               App.utils.commons.updateTextFieldSize(this.configTypeTF);
               _loc2_ = !!this.revertBtn.visible ? int(this.revertBtn.width + BTN_GAP) : int(0);
               this.configTypeTF.x = width - (this.configTypeTF.width + _loc2_) >> 1;
               this.revertBtn.x = this.configTypeTF.x + this.configTypeTF.width + BTN_GAP;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleIcon.removeEventListener(MouseEvent.CLICK,this.onVehicleIconClickHandler);
         this.vehicleIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onVehicleIconMouseOverHandler);
         this.vehicleIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onVehicleIconMouseOutHandler);
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.moduleBtn.removeEventListener(ButtonEvent.CLICK,this.onModuleBtnClickHandler);
         this.moduleBtn.dispose();
         this.moduleBtn = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.addVehicleBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onAddVehicleBtnMouseOverHandler);
         this.addVehicleBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onAddVehicleBtnMouseOutHandler);
         this.addVehicleBtn.removeEventListener(MouseEvent.CLICK,this.onAddVehicleBtnClickHandler);
         this.addVehicleBtn = null;
         if(this._rendererData)
         {
            this._rendererData.removeEventListener(Event.CHANGE,this.onDataChangeHandler);
            this._rendererData = null;
         }
         this.attentionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAttentionIconRollOverHandler);
         this.attentionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAttentionIconRollOutHandler);
         this.attentionIcon = null;
         this.revertBtn.removeEventListener(ButtonEvent.CLICK,this.onRevertBtnClickHandler);
         this.revertBtn.dispose();
         this.revertBtn = null;
         this.separator = null;
         this.noVehicleTf = null;
         this.addVehicleTF = null;
         this.configTypeTF = null;
         this._tooltipMgr = null;
         this.btnHover = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      override public function set data(param1:Object) : void
      {
         if(super.data == param1)
         {
            return;
         }
         if(this._rendererData)
         {
            this._rendererData.removeEventListener(Event.CHANGE,this.onDataChangeHandler);
         }
         super.data = param1;
         this._rendererData = VehCompareVehicleVO(param1);
         if(this._rendererData)
         {
            this._rendererData.addEventListener(Event.CHANGE,this.onDataChangeHandler);
         }
         invalidate(INVALIATE_RENDERER_DATA);
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      private function onRevertBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.REVERT_CLICK,true);
         _loc2_.index = this._rendererData.index;
         dispatchEvent(_loc2_);
      }
      
      private function onDataChangeHandler(param1:Event) : void
      {
         invalidate(INVALIATE_RENDERER_DATA);
      }
      
      private function onVehicleIconMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this._rendererData && !this._rendererData.isFirstEmptySlot)
         {
            _loc2_ = !!this._rendererData.isInHangar ? VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOHANGAR : VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_TOPREVIEW;
            this._tooltipMgr.showComplex(_loc2_);
            this.btnHover.visible = true;
         }
      }
      
      private function onAddVehicleBtnMouseOutHandler(param1:MouseEvent) : void
      {
         this.addVehicleBtn.alpha = ADD_BTN_ALPHA;
         this.addVehicleTF.visible = false;
      }
      
      private function onAddVehicleBtnMouseOverHandler(param1:MouseEvent) : void
      {
         this.addVehicleBtn.alpha = 1;
         this.addVehicleTF.visible = true;
      }
      
      private function onAddVehicleBtnClickHandler(param1:MouseEvent) : void
      {
         App.popoverMgr.show(this,VEHICLE_COMPARE_CONSTANTS.VEHICLE_CMP_ADD_VEHICLE_POPOVER);
      }
      
      private function onVehicleIconClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehCompareVehicleRendererEvent = null;
         var _loc3_:String = null;
         var _loc4_:VehCompareVehicleRendererEvent = null;
         if(this._rendererData && !this._rendererData.isFirstEmptySlot)
         {
            if(this._commons.isRightButton(param1))
            {
               _loc2_ = new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.RIGHT_CLICK,true);
               _loc2_.index = this._rendererData.index;
               dispatchEvent(_loc2_);
            }
            else if(this._commons.isLeftButton(param1))
            {
               _loc3_ = !!this._rendererData.isInHangar ? VehCompareVehicleRendererEvent.GO_TO_HANGAR_CLICK : VehCompareVehicleRendererEvent.GO_TO_PREVIEW_CLICK;
               _loc4_ = new VehCompareVehicleRendererEvent(this._rendererData.id,_loc3_,true);
               _loc4_.index = this._rendererData.index;
               dispatchEvent(_loc4_);
            }
         }
      }
      
      private function onVehicleIconMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
         this.btnHover.visible = false;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.REMOVE_CLICK,true);
         _loc2_.index = this._rendererData.index;
         dispatchEvent(_loc2_);
      }
      
      private function onModuleBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:VehCompareVehicleRendererEvent = new VehCompareVehicleRendererEvent(this._rendererData.id,VehCompareVehicleRendererEvent.MODULES_CLICK,true);
         _loc2_.index = this._rendererData.index;
         dispatchEvent(_loc2_);
      }
      
      private function onAttentionIconRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(VEH_COMPARE.VEHICLECOMPAREVIEW_TOOLTIPS_ATTENTIONEQUIPMENT);
      }
      
      private function onAttentionIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
