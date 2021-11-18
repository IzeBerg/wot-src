package net.wg.gui.lobby.dialogs
{
   import flash.events.Event;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.interfaces.ISoundButton;
   import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
   import net.wg.infrastructure.base.meta.ICrewSkinsCompensationDialogMeta;
   import net.wg.infrastructure.base.meta.impl.CrewSkinsCompensationDialogMeta;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class CrewSkinsCompensationDialog extends CrewSkinsCompensationDialogMeta implements ICrewSkinsCompensationDialogMeta
   {
      
      private static const PRICE_BOTTOM_OFFSET:int = 14;
      
      private static const PRICE_TEXT_OFFSET:int = 13;
      
      private static const SCROLL_ENABLE_ITEMS_COUNT:int = 3;
      
      private static const CONTENT_SHIFT_ITEMS_COUNT:int = 2;
      
      private static const SHIFT_ENABLE_OFFSET:int = 26;
      
      private static const UPDATE_DATA_PROVIDER:String = "updateDataProvider";
       
      
      public var priceMc:PriceMc;
      
      public var crewSkinScroll:ScrollingListEx;
      
      public var upButton:ISoundButton;
      
      public var downButton:ISoundButton;
      
      private var _scrollEnableFlag:Boolean = false;
      
      private var _contentShiftFlag:Boolean = false;
      
      public function CrewSkinsCompensationDialog()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.upButton.visible = false;
         this.downButton.visible = false;
         this.priceMc.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._scrollEnableFlag)
         {
            this.upButton.visible = true;
            this.downButton.visible = true;
         }
         if(this._contentShiftFlag)
         {
            textField.y += SHIFT_ENABLE_OFFSET;
            this.crewSkinScroll.y += SHIFT_ENABLE_OFFSET;
         }
         this.crewSkinScroll.addEventListener(Event.SCROLL,this.onScrollChangeHandler);
         this.upButton.addEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.downButton.addEventListener(ButtonEvent.CLICK,this.onDownButtonClickHandler);
         this.onScrollChangeHandler(new Event(Event.SCROLL));
      }
      
      private function onScrollChangeHandler(param1:Event) : void
      {
         this.upButton.enabled = this.crewSkinScroll.scrollPosition != 0;
         this.downButton.enabled = this.crewSkinScroll.dataProvider.length - this.crewSkinScroll.rowCount > this.crewSkinScroll.scrollPosition;
      }
      
      private function onDownButtonClickHandler(param1:ButtonEvent) : void
      {
         this.crewSkinScroll.scrollPosition += 1;
      }
      
      private function onUpButtonClickHandler(param1:ButtonEvent) : void
      {
         this.crewSkinScroll.scrollPosition -= 1;
      }
      
      override protected function applyLayout() : void
      {
         super.applyLayout();
         this.priceMc.y = this.getBackgroundActualHeight() - this.priceMc.height - PRICE_BOTTOM_OFFSET | 0;
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         return Math.max(this.getScrollHeight(),this.getTextAreaCurrentHeight());
      }
      
      override protected function getTextAreaCurrentHeight() : Number
      {
         var _loc1_:Number = super.getTextAreaCurrentHeight();
         if(this.priceMc.visible)
         {
            _loc1_ += PRICE_TEXT_OFFSET + this.priceMc.height + PRICE_BOTTOM_OFFSET;
         }
         return _loc1_;
      }
      
      protected function getScrollHeight() : Number
      {
         var _loc1_:Number = NaN;
         if(this._contentShiftFlag)
         {
            _loc1_ = this.downButton.y + this.downButton.height;
         }
         else
         {
            _loc1_ = this.crewSkinScroll.y + this.crewSkinScroll.rowHeight * this.crewSkinScroll.dataProvider.length + this.crewSkinScroll.margin + PRICE_BOTTOM_OFFSET;
         }
         return _loc1_;
      }
      
      override protected function setList(param1:DataProvider) : void
      {
         this.crewSkinScroll.dataProvider.cleanUp();
         this.crewSkinScroll.dataProvider = new DataProvider(param1);
         if(this.crewSkinScroll.dataProvider.length >= SCROLL_ENABLE_ITEMS_COUNT)
         {
            this._scrollEnableFlag = true;
         }
         if(this.crewSkinScroll.dataProvider.length >= CONTENT_SHIFT_ITEMS_COUNT)
         {
            this._contentShiftFlag = true;
         }
         invalidate(UPDATE_DATA_PROVIDER);
      }
      
      public function as_setOperationAllowed(param1:Boolean) : void
      {
         this.priceMc.allowed = param1;
      }
      
      override protected function setMessagePrice(param1:IconPriceDialogVO) : void
      {
         this.priceMc.setPriceData(param1);
         this.priceMc.visible = true;
      }
      
      public function as_setPriceLabel(param1:String) : void
      {
         this.priceMc.textField.text = param1;
      }
      
      override protected function onDispose() : void
      {
         this.priceMc.dispose();
         this.priceMc = null;
         this.crewSkinScroll.removeEventListener(Event.SCROLL,this.onScrollChangeHandler);
         this.crewSkinScroll.dispose();
         this.crewSkinScroll = null;
         this.downButton.removeEventListener(ButtonEvent.CLICK,this.onDownButtonClickHandler);
         this.downButton.dispose();
         this.downButton = null;
         this.upButton.removeEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.upButton.dispose();
         this.upButton = null;
         super.onDispose();
      }
   }
}
