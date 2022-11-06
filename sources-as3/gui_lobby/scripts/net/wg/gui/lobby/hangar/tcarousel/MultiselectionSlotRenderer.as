package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.VehicleState;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionSlotVO;
   import net.wg.gui.lobby.hangar.tcarousel.event.SlotEvent;
   import net.wg.gui.lobby.hangar.tcarousel.helper.TankCarouselStatsFormatter;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.TextFieldEx;
   
   public class MultiselectionSlotRenderer extends SoundButtonEx implements IListItemRenderer
   {
      
      private static const ELITE_POSTFIX:String = "_elite";
      
      private static const INVALIDATE_SLOT_DATA:String = "slotDataInvalid";
       
      
      public var vehicleType:MovieClip;
      
      public var vehicleLevel:MovieClip;
      
      public var indexTxt:TextField;
      
      public var statusTxt:TextField;
      
      public var vehicleNameTxt:TextField;
      
      public var vehicleIcon:UILoaderAlt;
      
      public var deactivateBtn:SoundButtonEx;
      
      public var shiftBtn:SoundButtonEx;
      
      public var alert:AlertIco;
      
      public var activatedHover:Sprite;
      
      public var activatedBg:Sprite;
      
      public var statusBg:Sprite;
      
      public var hitMC:Sprite;
      
      private var _index:uint;
      
      private var _dataVO:MultiselectionSlotVO = null;
      
      public function MultiselectionSlotRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setupMouseHandlers();
         TextFieldEx.setVerticalAlign(this.statusTxt,TextFieldEx.VALIGN_CENTER);
         preventAutosizing = true;
      }
      
      override protected function onDispose() : void
      {
         this.clearMouseHandlers();
         if(this._dataVO != null)
         {
            this._dataVO.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
            this._dataVO = null;
         }
         this.vehicleType = null;
         this.vehicleLevel = null;
         this.indexTxt = null;
         this.statusTxt = null;
         this.vehicleNameTxt = null;
         this.alert.dispose();
         this.alert = null;
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.deactivateBtn.dispose();
         this.deactivateBtn = null;
         this.shiftBtn.dispose();
         this.shiftBtn = null;
         this.activatedHover = null;
         this.activatedBg = null;
         this.statusBg = null;
         this.hitMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(INVALIDATE_SLOT_DATA) && this._dataVO != null)
         {
            this.indexTxt.text = this._dataVO.indexStr;
            this.alert.visible = this._dataVO.showAlert;
            this.updateStatus(this._dataVO);
            this.statusBg.visible = this._dataVO.formattedStatusStr.length > 0;
            _loc1_ = this._dataVO.isActivated;
            this.vehicleNameTxt.visible = _loc1_;
            this.vehicleIcon.visible = _loc1_;
            this.vehicleLevel.visible = _loc1_;
            this.vehicleType.visible = _loc1_;
            this.activatedHover.visible = _loc1_;
            this.activatedBg.visible = _loc1_;
            this.hitMC.visible = _loc1_;
            if(_loc1_)
            {
               this.vehicleNameTxt.htmlText = this._dataVO.vehicleName;
               this.vehicleLevel.gotoAndStop(this._dataVO.vehicleLevel);
               _loc2_ = this._dataVO.vehicleType + (!!this._dataVO.isElite ? ELITE_POSTFIX : "");
               this.vehicleType.gotoAndStop(_loc2_);
            }
            this.deactivateBtn.visible = enabled;
            this.shiftBtn.visible = enabled;
         }
      }
      
      public function getData() : Object
      {
         return this._dataVO;
      }
      
      public function setData(param1:Object) : void
      {
         if(this._dataVO != param1)
         {
            if(this._dataVO != null)
            {
               this._dataVO.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
               this._dataVO = null;
            }
            if(param1 != null)
            {
               this._dataVO = MultiselectionSlotVO(param1);
               this.updateData();
            }
         }
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      private function updateData() : void
      {
         this._dataVO.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
         if(this._dataVO.isActivated)
         {
            this.vehicleIcon.source = this._dataVO.vehicleIcon;
         }
         var _loc1_:Boolean = this._dataVO.stat.length > 0 && this._dataVO.stat != VehicleState.IN_PREBATTLE;
         this.enabled = this._dataVO.isActivated && _loc1_;
         invalidate(INVALIDATE_SLOT_DATA);
      }
      
      private function setupMouseHandlers() : void
      {
         this.hitMC.buttonMode = true;
         mouseChildren = true;
         this.hitMC.addEventListener(MouseEvent.ROLL_OVER,this.onHitMCRollOverHandler,false);
         this.hitMC.addEventListener(MouseEvent.ROLL_OUT,this.onHitMCRollOutHandler,false);
         this.hitMC.addEventListener(MouseEvent.MOUSE_DOWN,this.onHitMCMouseDownHandler,false);
         this.hitMC.addEventListener(MouseEvent.CLICK,this.onHitMCClickHandler,false);
         this.hitMC.addEventListener(MouseEvent.DOUBLE_CLICK,this.onHitMCDoubleClickHandler,false);
         this.shiftBtn.addEventListener(ButtonEvent.CLICK,this.onShiftBtnClickHandler);
         this.deactivateBtn.addEventListener(ButtonEvent.CLICK,this.onDeactivateBtnClickHandler);
         this.alert.buttonMode = false;
         this.alert.addEventListener(MouseEvent.ROLL_OVER,this.onAlertRollOverHandler);
         this.alert.addEventListener(MouseEvent.ROLL_OUT,this.onAlertRollOutHandler);
      }
      
      private function clearMouseHandlers() : void
      {
         this.hitMC.removeEventListener(MouseEvent.ROLL_OVER,this.onHitMCRollOverHandler,false);
         this.hitMC.removeEventListener(MouseEvent.ROLL_OUT,this.onHitMCRollOutHandler,false);
         this.hitMC.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHitMCMouseDownHandler,false);
         this.hitMC.removeEventListener(MouseEvent.CLICK,this.onHitMCClickHandler,false);
         this.hitMC.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onHitMCDoubleClickHandler,false);
         this.shiftBtn.removeEventListener(ButtonEvent.CLICK,this.onShiftBtnClickHandler);
         this.deactivateBtn.removeEventListener(ButtonEvent.CLICK,this.onDeactivateBtnClickHandler);
         this.alert.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertRollOverHandler);
         this.alert.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertRollOutHandler);
      }
      
      private function dispatchSlotEvent(param1:String) : void
      {
         dispatchEvent(new SlotEvent(param1,this._dataVO.inventoryId));
      }
      
      private function updateStatus(param1:MultiselectionSlotVO) : void
      {
         var _loc2_:Object = null;
         if(param1.stateLevel.length > 0)
         {
            this.statusTxt.htmlText = param1.formattedStatusStr;
            _loc2_ = TankCarouselStatsFormatter.instance.getStatColor(param1.stateLevel);
            this.statusTxt.textColor = _loc2_.color;
            this.statusTxt.filters = _loc2_.filterArray;
         }
         else
         {
            this.statusTxt.htmlText = param1.formattedStatusStr;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         mouseChildren = true;
         invalidate(INVALIDATE_SLOT_DATA);
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = this.index;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
      }
      
      private function hitMcClick(param1:MouseEvent) : void
      {
         super.handleMouseRelease(param1);
         this.dispatchSlotEvent(SlotEvent.TYPE_SELECT);
      }
      
      private function onHitMCRollOverHandler(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
      }
      
      private function onHitMCRollOutHandler(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
      }
      
      private function onHitMCMouseDownHandler(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
      }
      
      private function onHitMCClickHandler(param1:MouseEvent) : void
      {
         this.hitMcClick(param1);
      }
      
      private function onHitMCDoubleClickHandler(param1:MouseEvent) : void
      {
         this.hitMcClick(param1);
      }
      
      private function onDeactivateBtnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchSlotEvent(SlotEvent.TYPE_DEACTIVATED);
      }
      
      private function onShiftBtnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchSlotEvent(SlotEvent.TYPE_SHIFT);
      }
      
      private function onAlertRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MultiselectionSlotVO = null;
         if(data != null)
         {
            _loc2_ = MultiselectionSlotVO(data);
            if(_loc2_.alertTooltip.length > 0)
            {
               App.toolTipMgr.showComplex(_loc2_.alertTooltip);
            }
         }
      }
      
      private function onAlertRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
   }
}
