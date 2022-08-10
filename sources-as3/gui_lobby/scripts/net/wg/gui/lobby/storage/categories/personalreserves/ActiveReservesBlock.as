package net.wg.gui.lobby.storage.categories.personalreserves
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.events.SlotsPanelEvent;
   import net.wg.gui.lobby.components.BoostersPanel;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class ActiveReservesBlock extends BaseDAAPIComponent
   {
      
      private static const TITLE_HORIZONTAL_OFFSET_SMALL:int = 65;
      
      private static const TITLE_HORIZONTAL_OFFSET_TALL:int = 125;
      
      private static const BOOSTER_PANEL_Y_SHIFT:int = 9;
      
      private static const NAVIGATE_BUTTON_OFFSET_SMALL:int = 20;
      
      private static const NAVIGATE_BUTTON_OFFSET_TALL:int = 40;
      
      private static const BOOSTER_PANEL_OFFSET:int = 15;
       
      
      public var img:Sprite;
      
      public var title:TextField;
      
      public var boostersPanel:BoostersPanel;
      
      public var navigateToShopButton:IconTextBigButton;
      
      private var _imgSizeKoeff:Number = 0;
      
      private var _isSmall:Boolean = false;
      
      public function ActiveReservesBlock()
      {
         super();
         this._imgSizeKoeff = this.img.width / this.img.height;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.navigateToShopButton.autoSize = TextFieldAutoSize.LEFT;
         this.navigateToShopButton.label = STORAGE.PERSONALRESERVES_NAVIGATETOSHOPLABEL;
         this.boostersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
      }
      
      override protected function onDispose() : void
      {
         this.boostersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
         this.boostersPanel = null;
         this.title = null;
         this.img = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Graphics = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.img.height = height;
            this.img.width = this._imgSizeKoeff * height;
            this.title.x = !!this._isSmall ? Number(TITLE_HORIZONTAL_OFFSET_SMALL) : Number(TITLE_HORIZONTAL_OFFSET_TALL);
            this.title.y = height - this.title.height >> 1;
            this.navigateToShopButton.validateNow();
            _loc1_ = !!this._isSmall ? int(NAVIGATE_BUTTON_OFFSET_SMALL) : int(NAVIGATE_BUTTON_OFFSET_TALL);
            this.navigateToShopButton.x = width - this.navigateToShopButton.width - _loc1_;
            this.navigateToShopButton.y = height - this.navigateToShopButton.height >> 1;
            this.updatePanelPos();
            _loc2_ = graphics;
            _loc2_.clear();
            _loc2_.lineStyle(1,16777215,0.15);
            _loc2_.beginFill(0,0.25);
            _loc2_.drawRect(0,0,width,height);
            _loc2_.endFill();
         }
      }
      
      public function setData(param1:StorageCategoryPersonalReservesVO) : void
      {
         this.title.htmlText = param1.activeText;
      }
      
      private function updatePanelPos() : void
      {
         this.boostersPanel.x = this.title.x + this.title.width + BOOSTER_PANEL_OFFSET >> 0;
         this.boostersPanel.y = (height - this.boostersPanel.height >> 1) + BOOSTER_PANEL_Y_SHIFT;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall == param1)
         {
            return;
         }
         this._isSmall = param1;
         invalidateSize();
      }
      
      private function onBoostersPanelNeedRepositionHandler(param1:SlotsPanelEvent = null) : void
      {
         this.updatePanelPos();
      }
   }
}
