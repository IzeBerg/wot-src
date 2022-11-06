package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.BuyBtnVO;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.StyleInfoVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationStyleInfoEvent;
   import net.wg.infrastructure.base.meta.ICustomizationStyleInfoMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationStyleInfoMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationStyleInfo extends CustomizationStyleInfoMeta implements ICustomizationStyleInfoMeta
   {
      
      private static const LOBBY_HEADER_HEIGHT:int = 54;
      
      private static const BOTTOM_GAP:int = 34;
      
      private static const MESSENGER_BAR_HEIGHT:int = 36;
      
      private static const BACK_BTN_SCREEN_HEIGHT_SMALL:int = 850;
      
      private static const BACK_BTN_Y_OFFSET:int = 50;
      
      private static const BACK_BTN_Y_OFFSET_SMALL:int = 30;
      
      private static const BACK_BTN_X_OFFSET:int = 20;
      
      private static const WIDTH_MIN:int = 1024;
      
      private static const WIDTH_MEDIUM:int = 1600;
      
      private static const WIDTH_BIG:int = 1920;
      
      private static const BLOCK_OFFSET_X_MIN:int = 40;
      
      private static const BLOCK_OFFSET_X_MAX:int = 70;
      
      private static const BLOCK_MARGIN_X_MIN:int = 20;
      
      private static const BLOCK_MARGIN_X_MAX:int = 60;
      
      private static const BLOCK_WIDTH_MIN:int = 380;
      
      private static const BLOCK_WIDTH_MAX:int = 600;
       
      
      public var closeBtn:ISoundButtonEx = null;
      
      public var infoBlock:CustomizationStyleInfoBlock = null;
      
      public var background:MovieClip = null;
      
      public function CustomizationStyleInfo()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.infoBlock.dispose();
         this.infoBlock = null;
         App.stage.removeEventListener(CustomizationStyleInfoEvent.APPLY_STYLE,this.onApplyHandler);
         App.stage.removeEventListener(CustomizationStyleInfoEvent.CLOSE_STYLE_INFO,this.onPressEscHandler);
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_BACK;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         App.stage.addEventListener(CustomizationStyleInfoEvent.APPLY_STYLE,this.onApplyHandler);
         App.stage.addEventListener(CustomizationStyleInfoEvent.CLOSE_STYLE_INFO,this.onPressEscHandler);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.closeBtn.x = BACK_BTN_X_OFFSET;
            this.closeBtn.y = App.appHeight <= BACK_BTN_SCREEN_HEIGHT_SMALL ? Number(BACK_BTN_Y_OFFSET_SMALL) : Number(BACK_BTN_Y_OFFSET);
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            if(App.appWidth < WIDTH_MEDIUM)
            {
               _loc4_ = (WIDTH_MEDIUM - App.appWidth) / (WIDTH_MEDIUM - WIDTH_MIN);
               _loc2_ = BLOCK_OFFSET_X_MIN;
               _loc1_ = BLOCK_WIDTH_MAX - (BLOCK_WIDTH_MAX - BLOCK_WIDTH_MIN) * _loc4_ | 0;
               _loc3_ = BLOCK_MARGIN_X_MIN;
            }
            else
            {
               _loc4_ = Math.max(0,(WIDTH_BIG - App.appWidth) / (WIDTH_BIG - WIDTH_MEDIUM));
               _loc2_ = BLOCK_OFFSET_X_MAX - (BLOCK_OFFSET_X_MAX - BLOCK_OFFSET_X_MIN) * _loc4_ | 0;
               _loc1_ = BLOCK_WIDTH_MAX;
               _loc3_ = BLOCK_MARGIN_X_MAX - (BLOCK_MARGIN_X_MAX - BLOCK_MARGIN_X_MIN) * _loc4_ | 0;
            }
            _loc5_ = App.appHeight - LOBBY_HEADER_HEIGHT - MESSENGER_BAR_HEIGHT;
            this.infoBlock.width = _loc1_;
            this.infoBlock.updateSize(_loc5_,_loc3_);
            this.background.width = _loc1_ + _loc2_ + _loc3_;
            this.background.height = App.appHeight - LOBBY_HEADER_HEIGHT - BOTTOM_GAP;
            this.background.x = App.appWidth - this.background.width;
            _loc6_ = App.appScale;
            onWidthUpdatedS(this.background.x * _loc6_,this.background.width * _loc6_,App.appHeight * _loc6_);
         }
      }
      
      public function as_hide() : void
      {
         visible = false;
         App.stage.dispatchEvent(new CustomizationStyleInfoEvent(CustomizationStyleInfoEvent.HIDE_STYLE_INFO));
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
      }
      
      public function as_show() : void
      {
         visible = true;
         App.stage.dispatchEvent(new CustomizationStyleInfoEvent(CustomizationStyleInfoEvent.SHOW_STYLE_INFO));
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         invalidateSize();
      }
      
      public function as_setBackgroundAlpha(param1:Number) : void
      {
         this.background.alpha = param1;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseS();
      }
      
      private function onPressEscHandler(param1:CustomizationStyleInfoEvent) : void
      {
         onCloseS();
      }
      
      private function onApplyHandler(param1:CustomizationStyleInfoEvent) : void
      {
         onApplyS();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      override protected function setData(param1:StyleInfoVO) : void
      {
         this.infoBlock.setData(param1);
      }
      
      override protected function buttonUpdate(param1:BuyBtnVO) : void
      {
         this.infoBlock.buttonUpdate(param1);
      }
   }
}
