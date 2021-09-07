package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.assets.SeparatorAsset;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelBillVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationBill extends UIComponentEx
   {
      
      private static const PRICE_OFFSET:int = 6;
      
      private static const BTN_ALPHA:Number = 0.6;
      
      private static const DOTS_OFFSET:Number = 5;
      
      private static const BTN_ICON_OFFSET:Number = -3;
      
      private static const PRICE_ICON_OFFSET:Point = new Point(0,2);
      
      private static const GOLD_PRICE:String = "gold";
      
      private static const MIN_DOTS_WIDTH:int = 30;
       
      
      public var title:TextField = null;
      
      public var priceLbl:TextField = null;
      
      public var fromStorageLbl:TextField = null;
      
      public var dotsPrice:SeparatorAsset = null;
      
      public var dotsStorage:SeparatorAsset = null;
      
      public var fromStorage:Image = null;
      
      public var background:Sprite = null;
      
      public var clearBtn:BlackButton = null;
      
      public var totalPrice:CompoundPrice = null;
      
      private var _data:BottomPanelBillVO;
      
      public function CustomizationBill()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this.priceLbl.htmlText = this._data.priceLbl;
            this.fromStorageLbl.htmlText = this._data.fromStorageLbl;
            this.totalPrice.setData(this._data.pricePanel);
            this.totalPrice.updateEnoughStatuses(this._data.isEnoughStatuses);
            this.totalPrice.validateNow();
            this.totalPrice.actionTooltip = this._data.pricePanel.action;
            if(this.fromStorage.ready)
            {
               this.drawLayout();
            }
            else
            {
               this.fromStorage.addEventListener(Event.CHANGE,this.onImageChangeHandler);
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.background.mouseEnabled = false;
         this.totalPrice.priceIconOffset = PRICE_ICON_OFFSET;
         this.totalPrice.itemsDirection = CompoundPrice.DIRECTION_UP;
         this.totalPrice.itemsAnchor = CompoundPrice.ANCHOR_BOTTOM_RIGHT;
         this.clearBtn.label = VEHICLE_CUSTOMIZATION.BUYPOPOVER_BTN;
         this.clearBtn.addEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.title.autoSize = TextFieldAutoSize.RIGHT;
         this.priceLbl.autoSize = TextFieldAutoSize.LEFT;
         this.fromStorageLbl.autoSize = TextFieldAutoSize.LEFT;
         this.clearBtn.backgroundAlpha = BTN_ALPHA;
         this.clearBtn.iconOffsetText = BTN_ICON_OFFSET;
         this.clearBtn.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
         this.clearBtn.focusable = false;
         this.dotsPrice.setMode(SeparatorConstants.TILE_MODE);
         this.dotsPrice.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
         this.dotsStorage.setMode(SeparatorConstants.TILE_MODE);
         this.dotsStorage.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
         this.fromStorage.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_STORAGE_ICON;
      }
      
      override protected function onDispose() : void
      {
         this.clearBtn.removeEventListener(ButtonEvent.CLICK,this.onClearBtnClickHandler);
         this.clearBtn.dispose();
         this.clearBtn = null;
         this.totalPrice.dispose();
         this.totalPrice = null;
         this.dotsPrice.dispose();
         this.dotsPrice = null;
         this.dotsStorage.dispose();
         this.dotsStorage = null;
         this.fromStorage.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.fromStorage.dispose();
         this.fromStorage = null;
         this.background = null;
         this.fromStorageLbl = null;
         this.priceLbl = null;
         this.title = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:BottomPanelBillVO) : void
      {
         this._data = param1;
         if(this._data.pricePanel.price.items.length == 0)
         {
            this._data.pricePanel.price.items.push(new PriceVO([GOLD_PRICE,0]));
         }
         invalidateData();
      }
      
      private function drawLayout() : void
      {
         var _loc2_:int = 0;
         this.totalPrice.x = width - this.totalPrice.width + PRICE_OFFSET ^ 0;
         this.fromStorage.x = width - this.fromStorage.width - PRICE_OFFSET ^ 0;
         this.dotsPrice.x = DOTS_OFFSET + this.priceLbl.x + this.priceLbl.width;
         this.dotsStorage.x = DOTS_OFFSET + this.fromStorageLbl.x + this.fromStorageLbl.width;
         this.dotsPrice.width = this.totalPrice.x - this.dotsPrice.x - this.totalPrice.hit.width - DOTS_OFFSET;
         this.dotsStorage.width = this.fromStorage.x - this.dotsStorage.x;
         var _loc1_:int = this.dotsPrice.width < this.dotsStorage.width ? int(this.dotsPrice.width) : int(this.dotsStorage.width);
         if(_loc1_ < MIN_DOTS_WIDTH)
         {
            _loc2_ = MIN_DOTS_WIDTH - _loc1_;
            width += _loc2_;
            x -= _loc2_;
            this.background.width = width;
            this.clearBtn.x = width * 0.5 - this.clearBtn.width * 0.5;
            this.drawLayout();
         }
      }
      
      private function onClearBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationEvent(CustomizationEvent.CLEAR_BTN_PRESS));
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.fromStorage.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.drawLayout();
      }
   }
}
