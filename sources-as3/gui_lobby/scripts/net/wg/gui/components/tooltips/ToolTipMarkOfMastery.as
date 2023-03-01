package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipTankClassVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class ToolTipMarkOfMastery extends ToolTipSpecial
   {
       
      
      private var headerTF:TextField;
      
      private var descriptionTF:TextField;
      
      private var recordTF:TextField;
      
      private var status:Status;
      
      private var whiteBg:Sprite;
      
      private var separator:Separator;
      
      public function ToolTipMarkOfMastery()
      {
         super();
         this.initControls();
      }
      
      public function get utils() : Utils
      {
         return Utils.instance;
      }
      
      override protected function redraw() : void
      {
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:ToolTipStatusColorsVO = null;
         contentMargin.left = 19;
         topPosition = bgShadowMargin.top + contentMargin.top;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         separators = new Vector.<Separator>();
         var _loc1_:ToolTipTankClassVO = new ToolTipTankClassVO(_data);
         var _loc2_:Number = bgShadowMargin.left + contentMargin.left;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.leading = -2;
         _loc3_.align = TextFormatAlign.LEFT;
         var _loc4_:String = "<img src=\"img://gui/maps/icons/library/proficiency/class_icons_" + _loc1_.localizedValue + ".png\" WIDTH=\"32\" HEIGHT=\"32\" VSPACE=\"-10\"/>&nbsp;&nbsp;" + this.utils.htmlWrapper(_loc1_.name,this.utils.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.htmlText = _loc4_;
         this.headerTF.setTextFormat(_loc3_);
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = _loc2_;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.textHeight + 12;
         this.separator = this.utils.createSeparate(content);
         this.separator.y = topPosition;
         separators.push(this.separator);
         this.whiteBg.y = topPosition;
         topPosition += this.utils.MARGIN_AFTER_BLOCK;
         var _loc5_:ILocale = App.utils.locale;
         var _loc6_:String = _loc5_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + _loc1_.localizedValue) + "%";
         _loc6_ = Utils.instance.htmlWrapper(_loc6_,Utils.instance.COLOR_NUMBER,12,"$TextFont");
         var _loc7_:String = _loc5_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT,{"val":_loc6_});
         _loc7_ = Utils.instance.htmlWrapper(_loc7_,Utils.instance.COLOR_NORMAL,12,"$TextFont");
         var _loc8_:String = _loc5_.makeString(ACHIEVEMENTS.MARKOFMASTERYSUBCONTENT);
         _loc7_ += "<br/><br/>" + Utils.instance.htmlWrapper(_loc8_,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont");
         var _loc9_:String = _loc5_.makeString(ACHIEVEMENTS.MARKOFMASTERYRANKHEADER);
         _loc9_ = "<br/><br/>" + Utils.instance.htmlWrapper(_loc9_,Utils.instance.COLOR_NORMAL,14,"$TitleFont");
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.htmlText = _loc7_ + _loc9_;
         this.descriptionTF.width = this.descriptionTF.textWidth + 5;
         this.descriptionTF.height = this.descriptionTF.textHeight + 5;
         this.descriptionTF.x = _loc2_;
         this.descriptionTF.y = topPosition;
         topPosition += this.descriptionTF.height + 5;
         var _loc10_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc10_.contener = content;
         _loc10_.startYPos = topPosition;
         _loc10_.leftTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NUMBER);
         _loc10_.leftText = "";
         _loc10_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         _loc10_.rightTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NORMAL);
         var _loc11_:int = 4;
         while(_loc11_ > 0)
         {
            _loc13_ = _loc5_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + _loc11_) + "%";
            _loc10_.leftText += this.utils.htmlWrapper(_loc13_,this.utils.COLOR_NUMBER,11,"$TextFont") + "<br>";
            _loc14_ = ACHIEVEMENTS.achievement("master" + _loc11_);
            _loc15_ = "class" + _loc11_;
            _loc10_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc14_,_loc15_,-1,4));
            _loc11_--;
         }
         var _loc12_:ToolTipBlockResultVO = Utils.instance.createBlock(_loc10_,_loc2_);
         blockResults.push(_loc12_);
         topPosition = _loc12_.startYPos | 0;
         if(_loc1_.oldRecordOn != Values.EMPTY_STR && _loc1_.oldRecordLevel != Values.EMPTY_STR)
         {
            this.separator = this.utils.createSeparate(content);
            this.separator.y = topPosition;
            separators.push(this.separator);
            topPosition += this.utils.MARGIN_AFTER_BLOCK;
            this.recordTF.y = topPosition;
            this.recordTF.x = _loc2_;
            this.recordTF.htmlText = _loc1_.oldRecordOn + this.utils.htmlWrapper(_loc5_.makeString(ACHIEVEMENTS.achievement("master" + _loc1_.oldRecordLevel)),this.utils.COLOR_NUMBER,12,"$TextFont");
            this.recordTF.width = this.recordTF.textWidth + 4;
            this.recordTF.height = this.recordTF.textHeight + 4;
            topPosition += this.recordTF.height + this.utils.MARGIN_AFTER_LASTITEM | 0;
         }
         else
         {
            this.recordTF.visible = false;
            this.recordTF.x = 10;
            this.recordTF.y = 10;
            this.recordTF.width = 10;
         }
         if(_loc1_.newRecord != Values.EMPTY_STR && this.status)
         {
            this.separator = this.utils.createSeparate(content);
            this.separator.y = topPosition;
            separators.push(this.separator);
            topPosition += this.utils.MARGIN_AFTER_BLOCK;
            _loc16_ = this.utils.getStatusColor(this.utils.STATUS_ADDITIONAL);
            this.status.y = topPosition;
            this.status.x = _loc2_;
            this.status.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.status.setData(_loc1_.newRecord,null,_loc16_);
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
         }
         else
         {
            this.status.visible = false;
            this.status.y = 0;
         }
         _loc1_.dispose();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
         this.whiteBg.height = content.height - this.whiteBg.y + contentMargin.bottom;
      }
      
      private function initControls() : void
      {
         this.headerTF = content.headerTF;
         this.descriptionTF = content.descriptionTF;
         this.recordTF = content.recordTF;
         this.status = content.status;
         this.whiteBg = content.whiteBg;
      }
   }
}
