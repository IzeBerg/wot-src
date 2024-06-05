package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipUnitLevelVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipUnitLevel extends ToolTipSpecial
   {
       
      
      private var headerTF:TextField;
      
      private var descriptionTF:TextField;
      
      private var whiteBg:Sprite;
      
      private var bodyMC:MovieClip;
      
      private var levelTF:TextField;
      
      private var icon:UILoaderAlt;
      
      private var levelDescriptionTF:TextField;
      
      private var tooltipStatus:Status;
      
      private var model:ToolTipUnitLevelVO;
      
      public function ToolTipUnitLevel()
      {
         super();
         this.headerTF = content.headerTF;
         this.descriptionTF = content.descriptionTF;
         this.whiteBg = content.whiteBg;
         this.tooltipStatus = content.tooltipStatus;
         this.bodyMC = content.bodyMC;
         this.levelTF = this.bodyMC.levelTF;
         this.levelDescriptionTF = this.bodyMC.levelDescriptionTF;
         this.icon = this.bodyMC.icon;
      }
      
      override protected function redraw() : void
      {
         var _loc3_:ToolTipStatusColorsVO = null;
         this.model = new ToolTipUnitLevelVO(_data);
         var _loc1_:int = _data.level;
         var _loc2_:Separator = null;
         separators = new Vector.<Separator>();
         topPosition += this.setHeader(this.model.header);
         _loc2_ = this.addSeparatorWithMargin();
         this.descriptionTF.y = topPosition;
         this.descriptionTF.x = contentMargin.left + bgShadowMargin.left;
         this.descriptionTF.htmlText = this.model.description;
         this.descriptionTF.height = this.descriptionTF.textHeight + 5;
         topPosition = this.descriptionTF.y + this.descriptionTF.height + Utils.instance.MARGIN_AFTER_BLOCK;
         _loc2_ = this.addSeparatorWithMargin();
         this.bodyMC.y = topPosition;
         this.bodyMC.x = contentMargin.left + bgShadowMargin.left;
         this.levelTF.htmlText = this.model.level;
         this.levelDescriptionTF.htmlText = this.model.levelDescription;
         this.icon.source = this.model.icon;
         topPosition = this.bodyMC.y + this.bodyMC.height;
         if(this.model.statusMsg)
         {
            topPosition += Utils.instance.MARGIN_AFTER_BLOCK;
            _loc2_ = this.addSeparatorWithMargin();
            this.whiteBg.visible = true;
            this.whiteBg.y = _loc2_.y;
            this.tooltipStatus.visible = true;
            this.tooltipStatus.y = topPosition;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            _loc3_ = Utils.instance.getStatusColor(this.model.statusLevel);
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(this.model.statusMsg,"",_loc3_);
            topPosition += this.tooltipStatus.height + Utils.instance.MARGIN_AFTER_BLOCK;
            this.whiteBg.height = topPosition - this.whiteBg.y;
         }
         else
         {
            this.tooltipStatus.visible = false;
            this.whiteBg.visible = false;
         }
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         var _loc1_:Sprite = content.whiteBg;
         if(_loc1_ && _loc1_.visible)
         {
            _loc1_.width = contentWidth + bgShadowMargin.horizontal;
         }
      }
      
      private function setHeader(param1:String) : Number
      {
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(param1,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition ^ 0;
         return this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
      }
      
      private function addSeparatorWithMargin() : Separator
      {
         var _loc1_:Separator = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition ^ 0;
         separators.push(_loc1_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         return _loc1_;
      }
   }
}
