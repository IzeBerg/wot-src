package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.MapVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipMap extends ToolTipSpecial
   {
      
      private static const RIGHT_TF_VERTICAL_OFFSET:Number = 6;
       
      
      private var headerTF:TextField;
      
      private var headerRightTF:TextField;
      
      private var descriptionTF:TextField;
      
      private var image:UILoaderAlt;
      
      private var whiteBg:Sprite;
      
      public function ToolTipMap()
      {
         super();
         this.headerTF = content.headerTF;
         this.headerRightTF = content.headerRightTF;
         this.descriptionTF = content.descriptionTF;
         this.image = content.image;
         this.whiteBg = content.whiteBg;
         contentMargin.bottom = 18;
         contentMargin.right = 8;
      }
      
      override protected function redraw() : void
      {
         var _loc2_:Separator = null;
         var _loc1_:MapVO = new MapVO(_data);
         separators = new Vector.<Separator>();
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_.mapName,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         this.headerRightTF.htmlText = Utils.instance.htmlWrapper(_loc1_.gameplayName,Utils.instance.COLOR_NORMAL,14,"$FieldFont");
         this.headerRightTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerRightTF.y = this.headerTF.y + RIGHT_TF_VERTICAL_OFFSET;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         _loc2_ = Utils.instance.createSeparate(content);
         _loc2_.y = topPosition ^ 0;
         this.whiteBg.y = topPosition ^ 0;
         separators.push(_loc2_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         this.image.source = _loc1_.imageURL;
         this.image.x = bgShadowMargin.left + contentMargin.left;
         this.image.y = topPosition ^ 0;
         topPosition += this.image.originalHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         this.whiteBg.height = topPosition - this.whiteBg.y;
         _loc2_ = Utils.instance.createSeparate(content);
         _loc2_.y = topPosition ^ 0;
         separators.push(_loc2_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         this.descriptionTF.htmlText = Utils.instance.htmlWrapper(_loc1_.description,Utils.instance.COLOR_NORMAL,14,"$FieldFont");
         this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
         this.descriptionTF.y = topPosition;
         this.descriptionTF.height = this.descriptionTF.textHeight + 5;
         _loc1_.dispose();
         _loc1_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }
   }
}
