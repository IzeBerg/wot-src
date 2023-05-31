package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.components.controls.data.ActionPriceBgConstants;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SmallTankIcon extends BaseTankIcon
   {
      
      private static const ACTION_PRICE_BG_OFFSET_Y:int = 3;
      
      private static const IMG_ICON_BOUNDS:Rectangle = new Rectangle(1,1,160,35);
      
      private static const EXTRA_IMAGE_POS:Object = {"wotPlus":{
         "x":5,
         "y":16
      }};
       
      
      private var _commons:ICommons;
      
      public function SmallTankIcon()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override public function handleRollOut(param1:VehicleCarouselVO) : void
      {
         super.handleRollOut(param1);
         if(infoImg.visible)
         {
            txtInfo.visible = false;
         }
         addImg.visible = false;
         if(param1 != null && StringUtils.isNotEmpty(param1.additionalImgSrc))
         {
            addImg.visible = false;
            txtInfo.visible = !infoImg.visible;
         }
      }
      
      override public function handleRollOver(param1:VehicleCarouselVO) : void
      {
         if(infoImg.visible)
         {
            txtInfo.visible = true;
         }
         else
         {
            super.handleRollOver(param1);
         }
         addImg.visible = false;
         if(param1 != null && StringUtils.isNotEmpty(param1.additionalImgSrc))
         {
            addImg.visible = true;
            txtInfo.visible = false;
         }
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
      
      override protected function configUI() : void
      {
         super.configUI();
         imgIcon.horizontalAlign = AlignType.RIGHT;
         imgIcon.verticalAlign = AlignType.BOTTOM;
         imgFavorite.source = RES_ICONS.MAPS_ICONS_LIBRARY_FAVORITE_SMALL;
      }
      
      override protected function updateData(param1:VehicleCarouselVO) : void
      {
         var _loc2_:TextFormat = null;
         super.updateData(param1);
         if(StringUtils.isNotEmpty(param1.smallInfoText) && !clanLock.visible)
         {
            txtInfo.width = width - infoImgOffset ^ 0;
            txtInfo.htmlText = param1.smallInfoText;
            this._commons.updateTextFieldSize(txtInfo,true,true);
            if(txtInfo.height > height)
            {
               txtInfo.height = height;
            }
            txtInfo.x = !!infoImg.visible ? Number(infoImgOffset) : Number(width - txtInfo.width >> 1);
            txtInfo.y = height - txtInfo.height >> 1;
            _loc2_ = txtInfo.getTextFormat();
            _loc2_.align = !!infoImg.visible ? TEXT_ALIGN.LEFT : TEXT_ALIGN.CENTER;
            txtInfo.setTextFormat(_loc2_);
            txtInfo.visible = !infoImg.visible;
         }
         else
         {
            txtInfo.visible = infoImg.visible;
         }
         if(txtInfo.visible)
         {
            statsBg.visible = statsTF.visible = false;
         }
         if(param1.hasSale && param1.buySlot)
         {
            actionPrice.validateNow();
            actionPrice.bg.state = ActionPriceBgConstants.STATE_TECH_TREE_VEHICLE;
            actionPrice.bg.y = ACTION_PRICE_BG_OFFSET_Y;
         }
         imgIcon.source = param1.iconSmall;
         imgIcon.sourceAlt = param1.iconSmallAlt;
         addImg.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this._commons = null;
         super.onDispose();
      }
      
      override protected function get maxIconBounds() : Rectangle
      {
         return IMG_ICON_BOUNDS;
      }
   }
}
