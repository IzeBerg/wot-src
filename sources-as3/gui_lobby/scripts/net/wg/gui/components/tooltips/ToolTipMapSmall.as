package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.MapVO;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipMapSmall extends ToolTipSpecial
   {
      
      private static const DESCRIPTION_H_PADDING:int = 115;
      
      private static const TEXTS_PADDING:int = 4;
       
      
      private var headerTF:TextField = null;
      
      private var descriptionTF:TextField = null;
      
      private var image:UILoaderAlt = null;
      
      public function ToolTipMapSmall()
      {
         super();
         this.headerTF = content.headerTF;
         this.descriptionTF = content.descriptionTF;
         this.descriptionTF.wordWrap = true;
         this.image = content.image;
         contentMargin = new Padding(11,19,23,19);
      }
      
      override protected function redraw() : void
      {
         this.setData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updatePositions() : void
      {
         this.headerTF.x = contentMargin.left + bgShadowMargin.left;
         this.image.x = this.headerTF.x + TEXTS_PADDING;
         this.descriptionTF.x = this.image.x + DESCRIPTION_H_PADDING;
         this.headerTF.y = topPosition;
         this.image.y = this.headerTF.height + 15 ^ 0;
         this.descriptionTF.y = this.image.y - TEXTS_PADDING;
         this.descriptionTF.height = this.descriptionTF.textHeight + 5;
         super.updatePositions();
      }
      
      override protected function updateSize() : void
      {
         background.width = Math.round(content.width + contentMargin.right + contentMargin.left);
         background.height = Math.round(content.height + contentMargin.bottom + contentMargin.top);
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.descriptionTF = null;
         this.image.dispose();
         this.image = null;
         while(content.numChildren > 0)
         {
            content.removeChildAt(0);
         }
         super.onDispose();
      }
      
      private function setData() : void
      {
         var _loc1_:MapVO = new MapVO(_data);
         this.headerTF.htmlText = _loc1_.mapName;
         this.descriptionTF.htmlText = _loc1_.description;
         this.image.source = _loc1_.imageURL;
      }
   }
}
