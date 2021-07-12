package net.wg.gui.lobby.tankman
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.DashLineTextItem;
   import net.wg.gui.components.advanced.TankmanCard;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
   import net.wg.infrastructure.base.meta.IRoleChangeMeta;
   import net.wg.infrastructure.base.meta.impl.RoleChangeMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class RoleChangeWindow extends RoleChangeMeta implements IRoleChangeMeta
   {
      
      private static const TOTAL_PRICE_NORMAL:int = 367;
      
      private static const TOTAL_PRICE_WIDTH_DISCOUNT:int = 362;
       
      
      public var tankmanCard:TankmanCard;
      
      public var vehicleSelection:RoleChangeVehicleSelection;
      
      public var roleItems:RoleChangeItems;
      
      public var totalPrice:DashLineTextItem;
      
      public var cancelBtn:SoundButtonEx;
      
      public var acceptBtn:SoundButtonEx;
      
      public var vehicleSelectLabel:TextField;
      
      public var roleSelectLabel:TextField;
      
      public var footerInfo:TextField;
      
      public var infoIcon:InfoIcon;
      
      public var changeRoleDiscountIcon:ActionPriceBg;
      
      private var _totalPriceWidth:int = 367;
      
      private var _currentVehicleId:int = -1;
      
      private var _currentRoleId:String;
      
      private var _actionChangeRoleData:ActionPriceVO;
      
      public function RoleChangeWindow()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.acceptBtn.addEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.vehicleSelection.addEventListener(ListEvent.INDEX_CHANGE,this.onVehicleSelectionIndexChangeHandler);
         this.roleItems.addEventListener(Event.CHANGE,this.onRoleItemsChangeHandler);
         this.vehicleSelectLabel.text = CREW_OPERATIONS.ROLECHANGE_VEHICLESELECTLABEL;
         this.roleSelectLabel.text = CREW_OPERATIONS.ROLECHANGE_ROLESELECTLABEL;
         this.footerInfo.text = CREW_OPERATIONS.ROLECHANGE_FOOTERINFO;
         this.totalPrice.label = RETRAIN_CREW.LABEL_RESULT;
         this.acceptBtn.label = CREW_OPERATIONS.ROLECHANGE_ACCEPTBUTTON;
         this.cancelBtn.label = MENU.TANKMANTRAININGWINDOW_CLOSEBTN;
         this.infoIcon.tooltip = TOOLTIPS.ROLECHANGE_FOOTERINFO;
         this.totalPrice.width = this._totalPriceWidth;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.title = CREW_OPERATIONS.ROLECHANGE_WINDOWTITLE;
         window.useBottomBtns = true;
         setFocus(this.acceptBtn);
      }
      
      override protected function onDispose() : void
      {
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.acceptBtn.removeEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.vehicleSelection.removeEventListener(ListEvent.INDEX_CHANGE,this.onVehicleSelectionIndexChangeHandler);
         this.roleItems.removeEventListener(Event.CHANGE,this.onRoleItemsChangeHandler);
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onChangeRoleDiscountIconRollOverHandler);
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onChangeRoleDiscountIconRollOutHandler);
         this.tankmanCard.dispose();
         this.tankmanCard = null;
         this.vehicleSelection.dispose();
         this.vehicleSelection = null;
         this.roleItems.dispose();
         this.roleItems = null;
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.totalPrice.dispose();
         this.totalPrice = null;
         this.acceptBtn.dispose();
         this.acceptBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.changeRoleDiscountIcon = null;
         this._actionChangeRoleData = null;
         this.vehicleSelectLabel = null;
         this.roleSelectLabel = null;
         this.footerInfo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateAcceptButtonState();
         }
      }
      
      override protected function setCommonData(param1:RoleChangeVO) : void
      {
         this.tankmanCard.model = param1.tankmanModel;
         this.vehicleSelection.update(param1.vehicles);
         this._currentVehicleId = this.vehicleSelection.currentVehicleId;
      }
      
      override protected function setPrice(param1:String, param2:ActionPriceVO) : void
      {
         this.changeRoleDiscountIcon.state = ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP;
         this.changeRoleDiscountIcon.visible = param2.useAction;
         if(this.changeRoleDiscountIcon.visible)
         {
            this._totalPriceWidth = TOTAL_PRICE_WIDTH_DISCOUNT;
            this._actionChangeRoleData = param2;
            this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OVER,this.onChangeRoleDiscountIconRollOverHandler);
            this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OUT,this.onChangeRoleDiscountIconRollOutHandler);
         }
         else
         {
            this._totalPriceWidth = TOTAL_PRICE_NORMAL;
            this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onChangeRoleDiscountIconRollOverHandler);
            this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onChangeRoleDiscountIconRollOutHandler);
         }
         this.totalPrice.value = param1;
         invalidateData();
      }
      
      override protected function setRoles(param1:Array) : void
      {
         this.roleItems.update(param1);
      }
      
      private function updateAcceptButtonState() : void
      {
         this.acceptBtn.enabled = this._currentRoleId != null && this._currentVehicleId != Values.DEFAULT_INT;
         if(this.acceptBtn.focused && this.acceptBtn.enabled)
         {
            setFocus(this.cancelBtn);
         }
      }
      
      private function onChangeRoleDiscountIconRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onChangeRoleDiscountIconRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,this._actionChangeRoleData.type,this._actionChangeRoleData.key,this._actionChangeRoleData.newPrices,this._actionChangeRoleData.oldPrices,this._actionChangeRoleData.isBuying,this._actionChangeRoleData.forCredits,this._actionChangeRoleData.rentPackage);
      }
      
      private function onRoleItemsChangeHandler(param1:Event) : void
      {
         if(param1.target == this.roleItems)
         {
            if(this._currentRoleId != this.roleItems.currentRoleId)
            {
               this._currentRoleId = this.roleItems.currentRoleId;
               invalidate(InvalidationType.DATA);
            }
         }
      }
      
      private function onAcceptBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this.roleItems.currentRoleId != null && this.vehicleSelection.currentVehicleId != Values.DEFAULT_INT)
         {
            changeRoleS(this.roleItems.currentRoleId,this.vehicleSelection.currentVehicleId);
         }
      }
      
      private function onVehicleSelectionIndexChangeHandler(param1:ListEvent) : void
      {
         if(this._currentVehicleId != this.vehicleSelection.currentVehicleId)
         {
            this._currentVehicleId = this.vehicleSelection.currentVehicleId;
            onVehicleSelectedS(this._currentVehicleId);
            invalidate(InvalidationType.DATA);
         }
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
   }
}
