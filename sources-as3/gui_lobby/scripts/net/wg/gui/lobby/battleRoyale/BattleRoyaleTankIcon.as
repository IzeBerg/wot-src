package net.wg.gui.lobby.battleRoyale
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.lobby.hangar.tcarousel.TankIcon;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BattleRoyaleTankIcon extends TankIcon
   {
      
      private static const CLOCK_ICON_LEFT_OFFSET:int = -28;
      
      private static const RENT_TEXT_LEFT_OFFSET:int = -8;
      
      private static const INFO_IMG_OFFSET_H:int = 6;
      
      private static const INFO_IMG_OFFSET_V:int = 3;
      
      private static const TEXT_INFO_Y:int = 42;
      
      private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0,90,0,1,4,4,1.6,2);
       
      
      public var bgGlow:Sprite = null;
      
      public var clockIcon:Sprite = null;
      
      public var giftIcon:Sprite = null;
      
      public var shamrockFactor:Sprite = null;
      
      public function BattleRoyaleTankIcon()
      {
         super();
      }
      
      override protected function updateBaseData(param1:VehicleCarouselVO) : void
      {
         super.updateBaseData(param1);
         this.shamrockFactor.visible = param1.hasShamrockFactor;
         txtTankName.filters = [DEF_FILTER];
      }
      
      override protected function onDispose() : void
      {
         this.bgGlow = null;
         this.clockIcon = null;
         this.giftIcon = null;
         this.shamrockFactor = null;
         super.onDispose();
      }
      
      override protected function updateData(param1:VehicleCarouselVO) : void
      {
         super.updateData(param1);
         this.clockIcon.visible = StringUtils.isNotEmpty(param1.rentLeft);
         this.giftIcon.visible = param1.isTestDriveEnabled;
         this.bgGlow.visible = !param1.lockBackground;
      }
      
      override protected function setVisibleVehicleInfo(param1:Boolean) : void
      {
         super.setVisibleVehicleInfo(param1);
         this.bgGlow.visible = param1 && !lockedBG.visible;
      }
      
      override protected function validateLayout() : void
      {
         super.validateLayout();
         App.utils.commons.updateTextFieldSize(txtRentInfo);
         txtRentInfo.x = maxIconBounds.width - txtRentInfo.width + RENT_TEXT_LEFT_OFFSET;
         this.clockIcon.x = txtRentInfo.x + CLOCK_ICON_LEFT_OFFSET;
      }
      
      override protected function updateTextInfo(param1:VehicleCarouselVO, param2:Boolean) : void
      {
         super.updateTextInfo(param1,param2);
         txtInfo.y = TEXT_INFO_Y;
         if(infoImg.visible)
         {
            txtInfo.x = (width - txtInfo.width + infoImgOffset >> 1) - INFO_IMG_OFFSET_H;
            infoImg.x = txtInfo.x - infoImgOffset;
            infoImg.y = txtInfo.y - INFO_IMG_OFFSET_V;
         }
      }
   }
}
