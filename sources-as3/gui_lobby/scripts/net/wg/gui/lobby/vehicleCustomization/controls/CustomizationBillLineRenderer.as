package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.assets.SeparatorAsset;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBillLineVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationBillLineRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationBillLineRenderer extends UIComponentEx implements IUpdatable
   {
      
      private static const PRICE_OFFSET:int = 6;
      
      private static const DOTS_OFFSET:Number = 5;
      
      private static const PRICE_ICON_OFFSET:Point = new Point(0,2);
      
      private static const HEIGHT:int = 20;
      
      private static const MIN_DOTS_WIDTH:int = 30;
       
      
      public var label:TextField = null;
      
      public var dots:SeparatorAsset = null;
      
      public var icon:Image = null;
      
      public var compoundPrice:CompoundPrice = null;
      
      private var _data:CustomizationBillLineVO = null;
      
      public function CustomizationBillLineRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         height = HEIGHT;
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.dots.setMode(SeparatorConstants.TILE_MODE);
         this.dots.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
         this.compoundPrice.priceIconOffset = PRICE_ICON_OFFSET;
         this.compoundPrice.itemsDirection = CompoundPrice.DIRECTION_UP;
         this.compoundPrice.itemsAnchor = CompoundPrice.ANCHOR_BOTTOM_RIGHT;
         this.icon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         this.dots.dispose();
         this.dots = null;
         this.icon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.compoundPrice.dispose();
         this.compoundPrice = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.compoundPrice != null;
            if(_loc1_)
            {
               this.compoundPrice.setData(this._data.compoundPrice);
               this.compoundPrice.updateEnoughStatuses(this._data.isEnoughStatuses);
               this.compoundPrice.validateNow();
               this.compoundPrice.actionTooltip = this._data.compoundPrice.action;
            }
            this.icon.source = this._data.icon;
            this.label.htmlText = this._data.label;
            this.compoundPrice.visible = _loc1_;
            this.icon.visible = !_loc1_;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.dots.x = DOTS_OFFSET + this.label.x + this.label.width ^ 0;
            if(this._data.compoundPrice)
            {
               this.compoundPrice.x = width - this.compoundPrice.width + PRICE_OFFSET ^ 0;
               this.dots.width = this.compoundPrice.x - this.dots.x - this.compoundPrice.hit.width - DOTS_OFFSET;
            }
            else
            {
               this.icon.x = width - this.icon.width - PRICE_OFFSET ^ 0;
               this.dots.width = this.icon.x - this.dots.x;
            }
            if(this.dots.width < MIN_DOTS_WIDTH)
            {
               dispatchEvent(new CustomizationBillLineRendererEvent(CustomizationBillLineRendererEvent.UPDATE_MIN_WIDTH,MIN_DOTS_WIDTH - this.dots.width,true));
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = param1 as CustomizationBillLineVO;
         invalidateData();
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         invalidateSize();
      }
   }
}
