package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.ToolTipFortSortieVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipFortSortie extends ToolTipSpecial
   {
      
      private static const BG_WIDTH:int = 364;
      
      private static const DIVISION_OFFSET:int = 25;
      
      private static const DESCRIPTION_OFFSET:int = 12;
      
      private static const TOP_SEPARATOR_OFFSET:int = 20;
      
      private static const BOT_SEPARATOR_OFFSET:int = 17;
      
      private static const HINT_OFFSET:int = 16;
      
      private static const WHITEBG_OFFSET:int = 6;
      
      private static const ANTI_ALIAS:int = 5;
      
      private static const PADDING_TOP:int = 17;
      
      private static const PADDING_RIGHT:int = 12;
      
      private static const PADDING_BOTTOM:int = 32;
      
      private static const PADDING_LEFT:int = 22;
       
      
      public var titleTF:TextField = null;
      
      public var divisionTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var hintTF:TextField = null;
      
      public var inBattleTF:TextField = null;
      
      public var whiteBg:Sprite = null;
      
      public function ToolTipFortSortie()
      {
         super();
         contentMargin = new Padding(PADDING_TOP,PADDING_RIGHT,PADDING_BOTTOM,PADDING_LEFT);
         this.titleTF = content.titleTF;
         this.divisionTF = content.divisionTF;
         this.descriptionTF = content.descriptionTF;
         this.hintTF = content.hintTF;
         this.inBattleTF = content.inBattleTF;
         this.whiteBg = content.whiteBg;
         separators = new Vector.<Separator>();
      }
      
      override protected function redraw() : void
      {
         this.setData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updatePositions() : void
      {
         this.titleTF.x = this.divisionTF.x = this.hintTF.x = this.inBattleTF.x = contentMargin.left;
         this.titleTF.y = contentMargin.top;
         this.divisionTF.y = this.titleTF.y + DIVISION_OFFSET;
         if(this.inBattleTF.visible)
         {
            this.inBattleTF.y = this.divisionTF.y;
         }
         var _loc1_:Separator = Utils.instance.createSeparate(content);
         _loc1_.y = this.divisionTF.y + this.divisionTF.textHeight + TOP_SEPARATOR_OFFSET ^ 0;
         separators.push(_loc1_);
         if(this.descriptionTF.visible)
         {
            this.whiteBg.y = _loc1_.y + _loc1_.height ^ 0;
            this.descriptionTF.x = this.titleTF.x + DESCRIPTION_OFFSET;
            this.descriptionTF.y = this.whiteBg.y + DESCRIPTION_OFFSET;
            this.descriptionTF.height = this.descriptionTF.textHeight + ANTI_ALIAS;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = this.descriptionTF.y + this.descriptionTF.textHeight + BOT_SEPARATOR_OFFSET ^ 0;
            separators.push(_loc1_);
            this.whiteBg.height = _loc1_.y - this.whiteBg.y ^ 0;
         }
         else
         {
            this.descriptionTF.y = this.whiteBg.y = this.titleTF.y;
         }
         this.hintTF.y = _loc1_.y + HINT_OFFSET ^ 0;
         this.hintTF.height = this.hintTF.textHeight + ANTI_ALIAS;
         super.updatePositions();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.whiteBg.x = WHITEBG_OFFSET;
         this.whiteBg.width = BG_WIDTH;
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.divisionTF = null;
         this.descriptionTF = null;
         this.hintTF = null;
         this.inBattleTF = null;
         this.whiteBg = null;
         super.onDispose();
      }
      
      private function setData() : void
      {
         var _loc1_:ToolTipFortSortieVO = new ToolTipFortSortieVO(_data);
         this.titleTF.htmlText = _loc1_.titleText;
         this.divisionTF.htmlText = _loc1_.divisionText;
         this.hintTF.htmlText = _loc1_.hintText;
         this.descriptionTF.visible = this.whiteBg.visible = StringUtils.isNotEmpty(_loc1_.descriptionText);
         if(StringUtils.isNotEmpty(_loc1_.descriptionText))
         {
            this.descriptionTF.htmlText = _loc1_.descriptionText;
         }
         this.inBattleTF.visible = _loc1_.isInBattle;
         if(_loc1_.isInBattle)
         {
            this.inBattleTF.htmlText = _loc1_.inBattleText;
         }
         _loc1_.dispose();
      }
   }
}
