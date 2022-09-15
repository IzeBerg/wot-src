package net.wg.gui.components.tooltips
{
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.FortDivisionVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipFortDivision extends ToolTipSpecial
   {
      
      private static const ICO_MARGIN:Number = 27;
       
      
      private var _headerTF:TextField = null;
      
      private var _descrTF:TextField = null;
      
      public var warningTF:TextField = null;
      
      public var warnIcon:UILoaderAlt = null;
      
      public function ToolTipFortDivision()
      {
         super();
         this._headerTF = content.headerTF;
         this._descrTF = content.descrTF;
         this.warningTF = content.warningTF;
         this.warnIcon = content.warnIcon;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipDivision " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this._headerTF = null;
         this._descrTF = null;
         this.warningTF = null;
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         var _loc1_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:ToolTipBlockVO = null;
         var _loc7_:Number = NaN;
         var _loc8_:ToolTipBlockResultVO = null;
         _loc1_ = 320;
         var _loc2_:Separator = null;
         separators = new Vector.<Separator>();
         var _loc3_:FortDivisionVO = new FortDivisionVO(_data);
         contentMargin.bottom = 24;
         topPosition = bgShadowMargin.top + contentMargin.top;
         _loc4_ = bgShadowMargin.left + contentMargin.left;
         var _loc5_:Number = bgShadowMargin.horizontal + contentMargin.horizontal;
         this._headerTF.autoSize = TextFieldAutoSize.LEFT;
         this._headerTF.htmlText = Utils.instance.htmlWrapper(_loc3_.name,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this._headerTF.width = this._headerTF.textWidth + 5;
         this._headerTF.x = _loc4_;
         this._headerTF.y = topPosition;
         topPosition += this._headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         _loc1_ = Math.max(_loc1_,this._headerTF.width + _loc5_);
         this._descrTF.autoSize = TextFieldAutoSize.LEFT;
         this._descrTF.htmlText = Utils.instance.htmlWrapper(_loc3_.descr,Utils.instance.COLOR_NORMAL,14,"$FieldFont");
         this._descrTF.width = _loc1_;
         this._descrTF.x = _loc4_;
         this._descrTF.y = topPosition;
         topPosition += this._descrTF.textHeight + Utils.instance.MARGIN_AFTER_SEPARATE | 0;
         if(_loc3_.params)
         {
            blockResults = new Vector.<ToolTipBlockResultVO>();
            _loc6_ = new ToolTipBlockVO();
            _loc6_.startYPos = topPosition;
            _loc6_.contener = content;
            _loc6_.childrenNamePrefix = "fortDivision";
            _loc6_.leftText = "";
            _loc6_.leftTextLeading = 4;
            _loc6_.leftTextFont = "$FieldFont";
            _loc6_.leftTextSize = 14;
            _loc6_.leftTextLineHight = 19;
            _loc6_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_LABEL);
            _loc6_.rightTextStartYPos = 2;
            _loc6_.rightTextCSS = new StyleSheet();
            _loc6_.rightTextCSS.setStyle("h1",{
               "color":Utils.instance.COLOR_NORMAL_DARK,
               "fontSize":"14px",
               "fontFamily":"$FieldFont",
               "leading":"2px"
            });
            _loc6_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc7_ = 0;
            while(_loc7_ < _loc3_.params.length)
            {
               _loc6_.leftText += Utils.instance.htmlWrapper(_loc3_.params[_loc7_][1],Utils.instance.COLOR_LABEL,14,"$FieldFont") + "<br/>";
               _loc6_.rightTextList.push(new ToolTipBlockRightListItemVO("<h1>" + _loc3_.params[_loc7_][0] + "</h1>"));
               _loc7_++;
            }
            _loc8_ = Utils.instance.createBlock(_loc6_,_loc4_);
            blockResults.push(_loc8_);
            topPosition = _loc8_.startYPos;
            hasIcon = !!_loc8_.hasIcons ? Boolean(true) : Boolean(hasIcon);
            leftPartMaxW = _loc8_.leftPartMaxW > leftPartMaxW ? Number(_loc8_.leftPartMaxW) : Number(leftPartMaxW);
         }
         if(_loc3_.warning != Values.EMPTY_STR)
         {
            _loc2_ = Utils.instance.createSeparate(content);
            _loc2_.y = topPosition;
            separators.push(_loc2_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE + 5;
            this.warnIcon.autoSize = false;
            this.warnIcon.x = _loc4_ + 2;
            this.warnIcon.y = topPosition;
            this.warnIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
            this.warningTF.autoSize = TextFieldAutoSize.LEFT;
            this.warningTF.htmlText = Utils.instance.htmlWrapper(_loc3_.warning,Utils.instance.COLOR_WARNING,14,"$FieldFont");
            this.warningTF.x = this.warnIcon.x + ICO_MARGIN;
            this.warningTF.width = _loc1_ - (this.warningTF.x - _loc4_);
            this.warningTF.y = topPosition - 5;
            topPosition += this.warningTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            contentMargin.bottom = 17;
         }
         else
         {
            this.warningTF.x = this.warningTF.y = 0;
            this.warningTF.y = 10;
            this.warningTF.width = 10;
            this.warningTF.visible = false;
            this.warnIcon.visible = false;
         }
         _loc3_ = null;
         updatePositions();
         super.redraw();
      }
   }
}
