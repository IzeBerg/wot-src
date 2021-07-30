package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.MovieClip;
   import net.wg.data.VO.SellDialogElementVO;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleOptionalDeviceVo;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SellDevicesComponent extends UIComponentEx
   {
      
      private static const PADDING_FOR_NEXT_ELEMENT:uint = 5;
      
      private static const SCROLL_RENDERER_HEIGHT:uint = 30;
      
      private static const SCROLL_RENDERER_HEAD_HEIGHT:uint = 35;
      
      private static const MAX_SCROLL_ITEMS:uint = 3;
      
      private static const MAX_SCROLL_HEIGHT:uint = MAX_SCROLL_ITEMS * SCROLL_RENDERER_HEIGHT + SCROLL_RENDERER_HEAD_HEIGHT;
      
      private static const SCROLL_WIDTH:int = 477;
       
      
      public var sellDevicesScrollPane:ResizableScrollPane = null;
      
      public var sellDevicesBottomDivider:MovieClip = null;
      
      public var complDevBg:MovieClip = null;
      
      private var _content:SellDevicesContentContainer;
      
      private var _complexDevicesArr:SellDialogItem = null;
      
      private var _sellData:Array;
      
      private var _isExtended:Boolean = false;
      
      private var _devicesCount:uint;
      
      public function SellDevicesComponent()
      {
         this._sellData = [];
         super();
         this._content = SellDevicesContentContainer(this.sellDevicesScrollPane.target);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.sellDevicesScrollPane.isSmoothScroll = false;
         this.sellDevicesBottomDivider.mouseEnabled = false;
         this.sellDevicesScrollPane.addEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawnHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._complexDevicesArr)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               visible = this.complDevBg.visible = this.isActive;
               this._content.updateData(this._complexDevicesArr);
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.sellDevicesScrollPane.setSize(SCROLL_WIDTH,this.getScrollHeight());
               this.sellDevicesBottomDivider.y = this.sellDevicesScrollPane.y + this.sellDevicesScrollPane.height - this.sellDevicesBottomDivider.height;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:SellDialogElementVO = null;
         this.sellDevicesScrollPane.removeEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawnHandler);
         this.sellDevicesScrollPane.dispose();
         this.sellDevicesScrollPane = null;
         this.sellDevicesBottomDivider = null;
         this.complDevBg = null;
         this._content = null;
         var _loc1_:Vector.<SellDialogElementVO> = this._complexDevicesArr.elements;
         for each(_loc2_ in _loc1_)
         {
            _loc2_.dispose();
         }
         if(this._complexDevicesArr != null)
         {
            this._complexDevicesArr.dispose();
         }
         this._complexDevicesArr = null;
         this._sellData.length = 0;
         this._sellData = null;
         super.onDispose();
      }
      
      public function getNextPosition(param1:Boolean = true) : int
      {
         var _loc2_:Number = this.sellDevicesScrollPane.y + this.sellDevicesScrollPane.height;
         return Number(_loc2_ + (!!param1 ? PADDING_FOR_NEXT_ELEMENT : -PADDING_FOR_NEXT_ELEMENT));
      }
      
      public function setData(param1:Vector.<SellOnVehicleOptionalDeviceVo>) : void
      {
         var _loc6_:SellDialogElementVO = null;
         if(this._complexDevicesArr != null)
         {
            this._complexDevicesArr.dispose();
         }
         this._complexDevicesArr = new SellDialogItem();
         var _loc2_:SellDialogItem = new SellDialogItem();
         var _loc3_:Number = param1.length;
         var _loc4_:SellOnVehicleOptionalDeviceVo = null;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1[_loc5_];
            _loc6_ = new SellDialogElementVO();
            _loc6_.id = _loc4_.userName;
            _loc6_.type = FITTING_TYPES.OPTIONAL_DEVICE;
            _loc6_.itemIDList = [_loc4_.itemID];
            _loc6_.count = _loc4_.count;
            _loc6_.moneyValue = _loc4_.sellPrice[0];
            _loc6_.sellActionPriceVo = _loc4_.actionVo;
            _loc6_.removePrice = _loc4_.removePrice;
            _loc6_.removeCurrency = _loc4_.removeCurrency;
            _loc6_.isRemovable = _loc4_.isRemovable;
            _loc6_.toInventory = _loc4_.toInventory;
            _loc6_.onlyToInventory = _loc4_.onlyToInventory;
            _loc6_.removeActionPriceVo = _loc4_.removeActionPrice;
            if(_loc4_.isRemovable)
            {
               _loc2_.elements.push(_loc6_);
            }
            else
            {
               this._complexDevicesArr.elements.push(_loc6_);
            }
            _loc5_++;
         }
         this._devicesCount = this._complexDevicesArr.elements.length;
         if(_loc2_.elements.length != 0)
         {
            _loc2_.header = DIALOGS.VEHICLESELLDIALOG_OPTIONALDEVICE;
            this._sellData.push(_loc2_);
         }
         if(this.isActive)
         {
            this._complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_OPTIONALDEVICE;
         }
         invalidateData();
      }
      
      private function getScrollHeight() : Number
      {
         var _loc1_:Number = !!this.isActive ? Number(this._devicesCount * SCROLL_RENDERER_HEIGHT + SCROLL_RENDERER_HEAD_HEIGHT) : Number(0);
         if(this._isExtended)
         {
            return _loc1_;
         }
         return Math.min(MAX_SCROLL_HEIGHT,_loc1_);
      }
      
      public function set isExtended(param1:Boolean) : void
      {
         if(this._isExtended != param1)
         {
            this._isExtended = param1;
            invalidateLayout();
         }
      }
      
      public function get extraHeight() : uint
      {
         if(this._devicesCount > MAX_SCROLL_ITEMS)
         {
            return (this._devicesCount - MAX_SCROLL_ITEMS) * SCROLL_RENDERER_HEIGHT;
         }
         return 0;
      }
      
      public function get isActive() : Boolean
      {
         return this._devicesCount != 0;
      }
      
      public function get sellData() : Array
      {
         return this._sellData;
      }
      
      private function onSellDialogListItemRendererWasDrawnHandler(param1:VehicleSellDialogEvent) : void
      {
         this.sellDevicesScrollPane.invalidateSize();
      }
   }
}
