package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.SKILLS_CONSTANTS;
   import net.wg.gui.components.tooltips.VO.Dimension;
   import net.wg.gui.components.tooltips.VO.ToolTipBuySkillVO;
   import net.wg.gui.lobby.tankman.SkillItemViewMini;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.utils.IClassFactory;
   
   public class ToolTipBuySkill extends ToolTipBase
   {
      
      private static const BOTTOM_MARGIN:int = 5;
      
      private static const MARGIN_AFTER_SEPARETOR:int = 15;
      
      private static const LEFT_MARGIN:int = 18;
      
      private static const RIGHT_MARGIN:int = 18;
      
      private static const TOP_MARGIN:int = 12;
      
      private static const LINE_HEIGHT:int = 22;
      
      private static const MAC_WIDTH:int = 283 - (LEFT_MARGIN + RIGHT_MARGIN);
      
      private static const SKILL_LEVEL_HEIGHT_SHIFT:int = -6;
      
      private static const MAX_LEVEL_PERCENTAGE:int = 100;
       
      
      public var header:TextField = null;
      
      public var separator:Sprite = null;
      
      public var skillLevel:SkillItemViewMini = null;
      
      public var skillCount:SkillItemViewMini = null;
      
      public function ToolTipBuySkill()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[ToolTipBuySkill]";
      }
      
      override protected function redraw() : void
      {
         this.setContent();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Dimension = null;
         _loc1_ = this.getContDimension();
         background.x = background.y = 0;
         background.width = _loc1_.width + LEFT_MARGIN + RIGHT_MARGIN;
         this.separator.x = background.width - this.separator.width >> 1;
         background.height = _loc1_.height + TOP_MARGIN + BOTTOM_MARGIN;
      }
      
      override protected function onDispose() : void
      {
         this.header = null;
         this.separator = null;
         if(this.skillLevel != null)
         {
            this.skillLevel.dispose();
            this.skillLevel = null;
         }
         if(this.skillCount != null)
         {
            this.skillCount.dispose();
            this.skillCount = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.header.x = LEFT_MARGIN;
         this.header.y = TOP_MARGIN;
         this.header.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private function setContent() : void
      {
         var _loc1_:ToolTipBuySkillVO = new ToolTipBuySkillVO(_data);
         this.header.htmlText = _loc1_.header;
         var _loc2_:int = _loc1_.count - 1;
         var _loc3_:Number = _loc1_.level;
         this.separator.y = this.header.y + this.header.textHeight + TOP_MARGIN + MARGIN_AFTER_SEPARETOR | 0;
         var _loc4_:Number = this.separator.y + MARGIN_AFTER_SEPARETOR;
         if(_loc3_ == MAX_LEVEL_PERCENTAGE)
         {
            _loc2_++;
            _loc3_ = 0;
         }
         var _loc5_:IClassFactory = App.utils.classFactory;
         if(_loc3_ > 0)
         {
            this.skillLevel = _loc5_.getComponent(Linkages.SKILL_ITEM_VIEW_MINI,MovieClip);
            this.skillLevel.x = LEFT_MARGIN;
            this.skillLevel.type = SKILLS_CONSTANTS.TYPE_CURRENT_NEW_SKILL;
            this.skillLevel.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_PARTLY,{"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#F06532\">" + String(_loc3_) + "%</font>"}) + "</font>";
            addChild(this.skillLevel);
         }
         if(_loc2_ > 0)
         {
            this.skillCount = _loc5_.getComponent(Linkages.SKILL_ITEM_VIEW_MINI,SkillItemViewMini);
            this.skillCount.x = LEFT_MARGIN;
            this.skillCount.y = _loc4_;
            this.skillCount.type = _loc2_ > 1 ? SKILLS_CONSTANTS.TYPE_NEW_SKILLS : SKILLS_CONSTANTS.TYPE_NEW_SKILL;
            this.skillCount.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_FULLY,{"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#FFAC34\">" + String(_loc2_) + " x 100%</font>"}) + "</font>";
            if(_loc3_ > 0)
            {
               this.skillLevel.y = Math.round(this.skillCount.y + LINE_HEIGHT);
            }
            addChild(this.skillCount);
         }
         else if(_loc3_ > 0)
         {
            this.skillLevel.y = _loc4_;
         }
         _loc1_.dispose();
      }
      
      private function getContDimension() : Dimension
      {
         var _loc1_:Dimension = new Dimension();
         var _loc2_:Number = this.separator.width - (LEFT_MARGIN + RIGHT_MARGIN);
         _loc2_ = _loc2_ > this.header.textWidth ? Number(_loc2_) : Number(this.header.textWidth);
         _loc1_.height = this.header.y + this.header.textHeight;
         var _loc3_:IDisplayObject = this.skillCount == null ? this.skillLevel : this.skillCount;
         if(_loc3_ != null)
         {
            _loc2_ = _loc2_ > _loc3_.width ? Number(_loc2_) : Number(_loc3_.width);
         }
         _loc2_ = _loc2_ < MAC_WIDTH ? Number(MAC_WIDTH) : Number(_loc2_);
         _loc1_.width = _loc2_ | 0;
         _loc1_.height = Boolean(this.skillLevel) ? Number(this.skillLevel.y + this.skillLevel.height + SKILL_LEVEL_HEIGHT_SHIFT | 0) : (Boolean(this.skillCount) ? Number(this.skillCount.y + this.skillCount.height + SKILL_LEVEL_HEIGHT_SHIFT | 0) : Number(_loc1_.height));
         return _loc1_;
      }
   }
}
