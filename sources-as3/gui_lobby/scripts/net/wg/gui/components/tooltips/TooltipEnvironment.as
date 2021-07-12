package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.TooltipEnvironmentVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TooltipEnvironment extends ToolTipSpecial
   {
      
      private static const TEXTFIELD_PADDING:Number = 4;
      
      private static const HALF_TEXTFIELD_PADDING:Number = 2;
      
      private static const CONTENT_MARGIN_LEFT:Number = 21;
      
      private static const CONTENT_MARGIN_BOTTOM:Number = 20;
      
      private static const TITLE_ICON_GAP:Number = 3;
      
      private static const TITLE_TEXT_GAP:Number = 1;
      
      private static const ICON_TEXT_GAP:Number = 12;
       
      
      public var titleTF:TextField;
      
      public var textTF:TextField;
      
      public var icon:UILoaderAlt;
      
      public function TooltipEnvironment()
      {
         super();
         this.titleTF = content.titleTF;
         this.textTF = content.textTF;
         this.icon = content.icon;
         contentMargin.left = CONTENT_MARGIN_LEFT;
         contentMargin.bottom = CONTENT_MARGIN_BOTTOM;
      }
      
      override protected function redraw() : void
      {
         var _loc1_:TooltipEnvironmentVO = null;
         _loc1_ = new TooltipEnvironmentVO(_data);
         var _loc2_:Number = contentMargin.left + bgShadowMargin.left;
         this.titleTF.text = _loc1_.title;
         this.textTF.text = _loc1_.text;
         this.icon.visible = StringUtils.isNotEmpty(_loc1_.icon);
         App.utils.commons.updateTextFieldSize(this.titleTF,false,true);
         App.utils.commons.updateTextFieldSize(this.textTF,false,true);
         topPosition = bgShadowMargin.top + contentMargin.top;
         this.titleTF.y = topPosition | 0;
         this.titleTF.x = _loc2_ - HALF_TEXTFIELD_PADDING | 0;
         topPosition += this.titleTF.textHeight + TEXTFIELD_PADDING;
         if(this.icon.visible)
         {
            topPosition += TITLE_ICON_GAP;
            this.icon.source = _loc1_.icon;
            this.icon.y = topPosition | 0;
            this.icon.x = _loc2_ | 0;
            topPosition += this.icon.originalHeight + ICON_TEXT_GAP;
         }
         else
         {
            topPosition += TITLE_TEXT_GAP;
         }
         this.textTF.y = topPosition | 0;
         this.textTF.x = _loc2_ - HALF_TEXTFIELD_PADDING | 0;
         _loc1_.dispose();
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.titleTF = null;
         this.textTF = null;
         this.icon = null;
         super.onDispose();
      }
   }
}
