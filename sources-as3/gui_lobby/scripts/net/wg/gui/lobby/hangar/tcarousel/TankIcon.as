package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TankIcon extends BaseTankIcon
   {
      
      private static const INFO_IMG_OFFSET_V:int = 3;
      
      private static const W_OFFSET:int = 7;
      
      private static const IMG_ICON_BOUNDS:Rectangle = new Rectangle(1,1,160,100);
      
      private static const EXTRA_IMAGE_POS:Object = {"wotPlus":{
         "x":5,
         "y":78
      }};
       
      
      public var txtRentInfo:TextField = null;
      
      public function TankIcon()
      {
         super();
      }
      
      override public function handleRollOut(param1:VehicleCarouselVO) : void
      {
         super.handleRollOut(param1);
         if(param1 != null)
         {
            this.updateTextInfo(param1,false);
         }
      }
      
      override public function handleRollOver(param1:VehicleCarouselVO) : void
      {
         super.handleRollOver(param1);
         if(param1 != null)
         {
            this.updateTextInfo(param1,true);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         imgFavorite.source = RES_ICONS.MAPS_ICONS_TOOLTIP_MAIN_TYPE;
      }
      
      override protected function onDispose() : void
      {
         this.txtRentInfo = null;
         super.onDispose();
      }
      
      override protected function validateLayout() : void
      {
         super.validateLayout();
         if(isWotPlusSlot)
         {
            extraImage.x = EXTRA_IMAGE_POS.wotPlus.x;
            extraImage.y = EXTRA_IMAGE_POS.wotPlus.y;
         }
      }
      
      override protected function updateData(param1:VehicleCarouselVO) : void
      {
         super.updateData(param1);
         txtInfo.visible = StringUtils.isNotEmpty(param1.infoText);
         if(txtInfo.visible)
         {
            this.updateTextInfo(param1,false);
         }
         this.txtRentInfo.htmlText = param1.rentLeft;
         imgIcon.source = param1.icon;
         imgIcon.sourceAlt = param1.iconAlt;
      }
      
      override protected function setVisibleVehicleInfo(param1:Boolean) : void
      {
         super.setVisibleVehicleInfo(param1);
         this.txtRentInfo.visible = param1;
      }
      
      protected function updateTextInfo(param1:VehicleCarouselVO, param2:Boolean) : void
      {
         var _loc4_:String = null;
         if(txtInfo.visible)
         {
            _loc4_ = param1.infoText;
            if(param2)
            {
               _loc4_ = param1.infoHoverText;
            }
         }
         txtInfo.width = width - W_OFFSET - infoImgOffset ^ 0;
         txtInfo.htmlText = _loc4_;
         App.utils.commons.updateTextFieldSize(txtInfo,true,true);
         txtInfo.x = width - txtInfo.width + infoImgOffset >> 1;
         txtInfo.y = height - txtInfo.height >> 1;
         var _loc3_:TextFormat = txtInfo.getTextFormat();
         _loc3_.align = !!infoImg.visible ? TEXT_ALIGN.LEFT : TEXT_ALIGN.CENTER;
         txtInfo.setTextFormat(_loc3_);
         if(infoImg.visible)
         {
            infoImg.x = txtInfo.x - infoImgOffset;
            infoImg.y = txtInfo.y - INFO_IMG_OFFSET_V;
         }
      }
      
      override protected function get maxIconBounds() : Rectangle
      {
         return IMG_ICON_BOUNDS;
      }
   }
}
