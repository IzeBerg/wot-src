package net.wg.gui.lobby.battleRoyale
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.lobby.hangar.tcarousel.TankIcon;
   
   public class BattleRoyaleTankIcon extends TankIcon
   {
      
      private static const INFO_IMG_OFFSET_H:int = 6;
      
      private static const INFO_IMG_OFFSET_V:int = 3;
      
      private static const TEXT_INFO_Y:int = 42;
      
      private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0,90,0,1,4,4,1.6,2);
       
      
      public var bgGlow:Sprite = null;
      
      public function BattleRoyaleTankIcon()
      {
         super();
      }
      
      override protected function updateBaseData(param1:VehicleCarouselVO) : void
      {
         super.updateBaseData(param1);
         txtTankName.filters = [DEF_FILTER];
      }
      
      override protected function onDispose() : void
      {
         this.bgGlow = null;
         super.onDispose();
      }
      
      override protected function updateData(param1:VehicleCarouselVO) : void
      {
         super.updateData(param1);
         this.bgGlow.visible = !param1.lockBackground;
      }
      
      override protected function setVisibleVehicleInfo(param1:Boolean) : void
      {
         super.setVisibleVehicleInfo(param1);
         this.bgGlow.visible = param1 && !lockedBG.visible;
         txtRentInfo.visible = false;
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
