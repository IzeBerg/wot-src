package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipSkillVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipSkill extends ToolTipSpecial
   {
       
      
      private var headerTF:TextField = null;
      
      private var discrTF:TextField = null;
      
      private var infoTF:TextField = null;
      
      private var whiteBg:Sprite = null;
      
      private var maxWidth:Number = 270;
      
      public function ToolTipSkill()
      {
         super();
         this.headerTF = content.headerTF;
         this.discrTF = content.discrTF;
         this.infoTF = content.infoTF;
         this.whiteBg = content.whiteBg;
         separators = new Vector.<Separator>();
      }
      
      private static function getInfoText(param1:String) : String
      {
         var _loc2_:String = "";
         return Utils.instance.htmlWrapper(App.utils.locale.makeString(ITEM_TYPES.tankman_skills_type(param1),{}),Utils.instance.COLOR_NORMAL,14,"$FieldFont");
      }
      
      override protected function redraw() : void
      {
         var _loc1_:ToolTipSkillVO = null;
         var _loc4_:TextFormat = null;
         _loc1_ = new ToolTipSkillVO(_data);
         contentMargin.bottom = 2;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         this.whiteBg.width = 10;
         topPosition = bgShadowMargin.top + contentMargin.top;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_.name,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         this.maxWidth = Math.max(this.maxWidth,this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
         var _loc2_:Separator = Utils.instance.createSeparate(content);
         _loc2_.y = topPosition | 0;
         separators.push(_loc2_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         if(_loc1_.descr)
         {
            this.whiteBg.y = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            this.discrTF.autoSize = TextFieldAutoSize.LEFT;
            this.discrTF.htmlText = Utils.instance.htmlWrapper(_loc1_.descr,Utils.instance.COLOR_NORMAL,11,"$TextFont");
            this.discrTF.width = this.maxWidth != 0 ? Number(this.maxWidth - bgShadowMargin.left - contentMargin.left) : Number(this.discrTF.textWidth + 5);
            this.discrTF.x = bgShadowMargin.left + contentMargin.left;
            this.discrTF.y = topPosition;
            topPosition += this.discrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            this.whiteBg.height = topPosition - this.whiteBg.y;
         }
         else
         {
            this.discrTF.x = 0;
            this.discrTF.y = 0;
            this.discrTF.width = 10;
            this.discrTF.visible = false;
         }
         var _loc3_:String = getInfoText(_loc1_.type);
         if(_loc3_ != "")
         {
            this.whiteBg.height = topPosition - this.whiteBg.y;
            _loc2_ = Utils.instance.createSeparate(content);
            _loc2_.y = topPosition;
            separators.push(_loc2_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc4_ = new TextFormat();
            this.infoTF.autoSize = TextFieldAutoSize.LEFT;
            this.infoTF.htmlText = _loc3_;
            this.infoTF.setTextFormat(_loc4_);
            this.infoTF.x = bgShadowMargin.left + contentMargin.left;
            this.infoTF.y = topPosition;
            this.infoTF.width = this.infoTF.textWidth + 5;
            topPosition += this.infoTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
         }
         else
         {
            this.infoTF.x = 0;
            this.infoTF.y = 0;
            this.infoTF.width = 10;
            this.infoTF.visible = false;
         }
         _loc1_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.whiteBg.width = content.width + contentMargin.bottom + bgShadowMargin.bottom | 0;
      }
      
      override public function toString() : String
      {
         return "[SkillToolTip]";
      }
   }
}
