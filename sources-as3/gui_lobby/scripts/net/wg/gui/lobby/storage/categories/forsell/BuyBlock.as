package net.wg.gui.lobby.storage.categories.forsell
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.price.Price;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   [Event(name="sell",type="net.wg.gui.lobby.storage.categories.forsell.BuyBlockEvent")]
   [Event(name="deselectAll",type="net.wg.gui.lobby.storage.categories.forsell.BuyBlockEvent")]
   [Event(name="selectAll",type="net.wg.gui.lobby.storage.categories.forsell.BuyBlockEvent")]
   public class BuyBlock extends UIComponentEx
   {
      
      private static const CONTROLS_GAP:int = 20;
      
      private static const SELL_BUTTON_OFFSET:int = 2;
      
      private static const BORDER_OFFSET:Number = 0.5;
      
      private static const BORDER_CORNER_RADIUS:int = 2;
       
      
      public var sellButton:IconTextBigButton;
      
      public var markAllTitle:TextField;
      
      public var price:Price;
      
      public var checkbox:SoundButtonEx;
      
      private var _data:StorageCategoryForSellVO;
      
      private var _checkboxHitArea:Sprite;
      
      public function BuyBlock()
      {
         super();
      }
      
      public function setData(param1:StorageCategoryForSellVO) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         this.price.setData(this._data.price);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.sellButton.removeEventListener(ButtonEvent.CLICK,this.onSellButtonClickHandler);
         this.sellButton.dispose();
         this.sellButton = null;
         this.price.dispose();
         this.price = null;
         this.checkbox.dispose();
         this.checkbox = null;
         this._data = null;
         this._checkboxHitArea.removeEventListener(MouseEvent.CLICK,this.onCheckboxClickHandler);
         this._checkboxHitArea = null;
         this.markAllTitle = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.checkbox.mouseEnabled = this.checkbox.mouseChildren = false;
         this.markAllTitle.autoSize = TextFieldAutoSize.LEFT;
         this.markAllTitle.text = STORAGE.MARKEVERYTHING;
         this.markAllTitle.mouseWheelEnabled = this.markAllTitle.mouseEnabled = false;
         this.price.iconOffset.y = 0;
         this.price.bigFonts = true;
         this.price.mouseEnabled = this.price.mouseChildren = false;
         this.sellButton.label = STORAGE.BUTTONLABEL_SELL;
         this.sellButton.addEventListener(ButtonEvent.CLICK,this.onSellButtonClickHandler);
         this._checkboxHitArea = new Sprite();
         this._checkboxHitArea.buttonMode = true;
         this._checkboxHitArea.addEventListener(MouseEvent.CLICK,this.onCheckboxClickHandler);
         addChild(this._checkboxHitArea);
         var _loc1_:int = this.checkbox.x >> 1;
         var _loc2_:int = this.checkbox.y >> 1;
         var _loc3_:Graphics = this._checkboxHitArea.graphics;
         _loc3_.clear();
         _loc3_.beginFill(52479,0);
         _loc3_.drawRect(_loc1_,_loc2_,this.markAllTitle.x + this.markAllTitle.width,height - _loc2_ * 2);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.sellButton.enabled = this._data.sellButtonEnabled;
            this.checkbox.selected = this._data.allItemsSelected;
            this.price.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = graphics;
            _loc1_.clear();
            _loc1_.lineStyle(1,16777215,0.15);
            _loc1_.beginFill(0,0.25);
            _loc1_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_OFFSET * 3,height - BORDER_OFFSET * 3,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc1_.endFill();
            this.sellButton.x = width - this.sellButton.width - CONTROLS_GAP - SELL_BUTTON_OFFSET;
            this.sellButton.y = (height - this.sellButton.height >> 1) + SELL_BUTTON_OFFSET;
            this.price.x = this.sellButton.x - this.price.contentWidth - CONTROLS_GAP;
            this.price.y = height - this.price.contentHeight >> 1;
            this.markAllTitle.y = height - this.markAllTitle.height >> 1;
         }
      }
      
      private function onSellButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BuyBlockEvent(BuyBlockEvent.SELL));
      }
      
      private function onCheckboxClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new BuyBlockEvent(!this.checkbox.selected ? BuyBlockEvent.SELECT_ALL : BuyBlockEvent.DESELECT_ALL));
         }
      }
   }
}
