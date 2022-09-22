package net.wg.gui.lobby.battleRoyale
{
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BattleRoyaleSmallTankIcon extends BattleRoyaleTankIcon
   {
      
      private static const IMG_ICON_BOUNDS:Rectangle = new Rectangle(1,1,160,35);
       
      
      private var _commons:ICommons;
      
      public function BattleRoyaleSmallTankIcon()
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
         imgIcon.source = param1.iconSmall;
         imgIcon.sourceAlt = param1.iconSmallAlt;
         addImg.visible = false;
      }
      
      override protected function updateTextInfo(param1:VehicleCarouselVO, param2:Boolean) : void
      {
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
