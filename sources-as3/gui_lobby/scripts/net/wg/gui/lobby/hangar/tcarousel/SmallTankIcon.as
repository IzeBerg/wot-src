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
      
      private static const IMG_ICON_BOUNDS:Rectangle = new Rectangle(0,0,160,35);
      
      private static const EXTRA_IMAGE_POS:Object = {"wotPlus":{
         "x":5,
         "y":16
      }};
      
      private static const NY_SLOT_INFO_Y:int = 3;
      
      private static const NY_SLOT_ICON_Y:int = 1;
      
      private static const NY_SLOT_HOVER_ICON_Y:int = 1;
      
      private static const ASIAN_LOCALES:Vector.<String> = new <String>["ja","ko","zh_tw","zh_sg","zh_cn","th"];
       
      
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
         if(isNYSlot)
         {
            imgIcon.y = NY_SLOT_ICON_Y;
            txtInfo.y = NY_SLOT_INFO_Y;
            hoverImgIcon.y = NY_SLOT_HOVER_ICON_Y;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         imgIcon.horizontalAlign = hoverImgIcon.horizontalAlign = AlignType.RIGHT;
         imgIcon.verticalAlign = hoverImgIcon.verticalAlign = AlignType.BOTTOM;
         imgFavorite.source = RES_ICONS.MAPS_ICONS_LIBRARY_FAVORITE_SMALL;
      }
      
      override protected function updateData(param1:VehicleCarouselVO) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:Boolean = false;
         super.updateData(param1);
         if(StringUtils.isNotEmpty(param1.smallInfoText) && !clanLock.visible)
         {
            txtInfo.width = width - infoImgOffset ^ 0;
            txtInfo.htmlText = param1.smallInfoText;
            _loc2_ = txtInfo.getTextFormat();
            _loc2_.align = !!infoImg.visible ? TEXT_ALIGN.LEFT : TEXT_ALIGN.CENTER;
            _loc3_ = ASIAN_LOCALES.indexOf(App.utils.locale.makeString(SETTINGS.LANGUAGE_CODE)) != -1;
            if(param1.nySlot && _loc3_)
            {
               _loc2_.leading = 0;
            }
            txtInfo.setTextFormat(_loc2_);
            if(param1.nySlot)
            {
               this._commons.updateTextFieldSize(txtInfo,false,true);
            }
            else
            {
               this._commons.updateTextFieldSize(txtInfo,true,true);
            }
            if(txtInfo.height > height)
            {
               txtInfo.height = height;
            }
            txtInfo.x = !!infoImg.visible ? Number(infoImgOffset) : Number(width - txtInfo.width >> 1);
            txtInfo.y = height - txtInfo.height >> 1;
            txtInfo.visible = !infoImg.visible;
         }
         else
         {
            txtInfo.visible = infoImg.visible;
         }
         if(param1.hasSale && param1.buySlot)
         {
            actionPrice.validateNow();
            actionPrice.bg.state = ActionPriceBgConstants.STATE_TECH_TREE_VEHICLE;
            actionPrice.bg.y = ACTION_PRICE_BG_OFFSET_Y;
         }
         imgIcon.source = param1.iconSmall;
         imgIcon.sourceAlt = param1.iconSmallAlt;
         hasHoverImg = StringUtils.isNotEmpty(param1.iconHoverSmall);
         if(hasHoverImg)
         {
            hoverImgIcon.source = param1.iconHoverSmall;
            hoverImgIcon.sourceAlt = param1.iconHoverSmallAlt;
         }
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
