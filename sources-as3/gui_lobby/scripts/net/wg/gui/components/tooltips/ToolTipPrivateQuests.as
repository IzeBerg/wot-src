package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.PrivateQuestsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class ToolTipPrivateQuests extends ToolTipSpecial
   {
       
      
      public var headerTF:TextField = null;
      
      public var conditionTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var tooltipStatus:Status = null;
      
      private var whiteBg:Sprite = null;
      
      public function ToolTipPrivateQuests()
      {
         super();
         this.headerTF = content.headerTF;
         this.conditionTF = content.conditionTF;
         this.descriptionTF = content.descriptionTF;
         this.tooltipStatus = content.tooltipStatus;
         this.whiteBg = content.whiteBg;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipVehicle " + name + "]";
      }
      
      override protected function redraw() : void
      {
         var _loc9_:ToolTipBlockVO = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:ToolTipStatusColorsVO = null;
         var _loc1_:Separator = null;
         separators = new Vector.<Separator>();
         var _loc2_:ToolTipBlockResultVO = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = 300;
         var _loc6_:Number = bgShadowMargin.left + contentMargin.left;
         var _loc7_:ILocale = App.utils.locale;
         App.utils.asserter.assertNotNull(_loc7_,"App.utils.locale is Null");
         var _loc8_:PrivateQuestsVO = new PrivateQuestsVO(_data);
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc8_.name,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + 5 | 0;
         _loc5_ = Math.max(_loc5_,this.headerTF.width);
         this.headerTF.x = _loc6_;
         this.headerTF.y = topPosition;
         topPosition = this.headerTF.y + this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         _loc1_ = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition;
         separators.push(_loc1_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         if(_loc8_.conditions && _loc8_.conditions != Values.EMPTY_STR)
         {
            this.conditionTF.multiline = true;
            this.conditionTF.wordWrap = true;
            this.conditionTF.htmlText = Utils.instance.htmlWrapper(_loc8_.conditions,Utils.instance.COLOR_NORMAL,12,"$TextFont");
            this.conditionTF.width = _loc5_ != 0 ? Number(_loc5_ - _loc6_) : Number(this.conditionTF.textWidth + 5);
            this.conditionTF.height = this.conditionTF.textHeight + 4 | 0;
            this.conditionTF.x = _loc6_;
            this.conditionTF.y = topPosition;
            topPosition += this.conditionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.conditionTF.x = this.conditionTF.y = 10;
            this.conditionTF.width = 10;
            this.conditionTF.visible = false;
         }
         if(_loc8_.params && _loc8_.params.length > 0)
         {
            _loc9_ = new ToolTipBlockVO();
            _loc9_.leftText = "";
            _loc9_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc9_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc9_.contener = content;
            _loc9_.startYPos = topPosition;
            _loc9_.childrenNamePrefix = "params";
            _loc9_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc3_ = _loc8_.params.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc10_ = _loc8_.params[_loc4_][0];
               _loc9_.leftText += Utils.instance.htmlWrapper(_loc8_.params[_loc4_][1],Utils.instance.COLOR_NUMBER,12,"$TextFont") + "<br/>";
               _loc11_ = Utils.instance.getIcon(_loc10_);
               _loc9_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(TOOLTIPS.privatequests_params(_loc10_),_loc11_);
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc9_,_loc6_);
            blockResults.push(_loc2_);
            topPosition = _loc2_.startYPos;
            this.whiteBg.y = separators[separators.length - 1].y;
            this.whiteBg.height = topPosition - this.whiteBg.y;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.whiteBg.visible = false;
         }
         if(_loc8_.descr && _loc8_.descr != Values.EMPTY_STR)
         {
            this.descriptionTF.htmlText = Utils.instance.htmlWrapper(_loc8_.descr,Utils.instance.COLOR_NORMAL,12,"$TextFont");
            this.descriptionTF.multiline = true;
            this.descriptionTF.wordWrap = true;
            this.descriptionTF.width = _loc5_ != 0 ? Number(_loc5_ - _loc6_) : Number(this.descriptionTF.textWidth + 5);
            this.descriptionTF.height = this.descriptionTF.textHeight + 4 | 0;
            this.descriptionTF.x = _loc6_;
            this.descriptionTF.y = topPosition;
            topPosition += this.descriptionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.descriptionTF.x = this.descriptionTF.y = 10;
            this.descriptionTF.width = 10;
            this.descriptionTF.visible = false;
         }
         if(_loc8_.status)
         {
            _loc12_ = Utils.instance.getStatusColor(_loc8_.statusLevel);
            this.tooltipStatus.y = topPosition;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(_loc8_.statusHeader,_loc8_.statusText,_loc12_);
            topPosition += this.tooltipStatus.height;
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
         }
         else
         {
            this.tooltipStatus.visible = false;
            this.tooltipStatus.y = 0;
            popSeparator();
         }
         _loc8_.dispose();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         var _loc1_:Number = content.width + contentMargin.right - bgShadowMargin.left;
         if(this.whiteBg.visible)
         {
            this.whiteBg.x = bgShadowMargin.left;
            this.whiteBg.width = _loc1_;
         }
      }
   }
}
