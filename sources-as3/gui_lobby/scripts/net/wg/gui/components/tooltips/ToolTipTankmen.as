package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.TankmenVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.utils.ILocale;
   
   public class ToolTipTankmen extends ToolTipSpecial
   {
       
      
      public var headerTF:TextField = null;
      
      public var tooltipStatus:Status = null;
      
      public var tooltipStatusNewSkill:Status = null;
      
      public var tankInfoHeaderTF:TextField = null;
      
      public var tankInfoTF:TextField = null;
      
      public var vehicleIco:UILoaderAlt = null;
      
      public var whiteBg:Sprite = null;
      
      private var dataVO:TankmenVO = null;
      
      public function ToolTipTankmen()
      {
         super();
         this.headerTF = content.headerTF;
         this.tooltipStatus = content.tooltipStatus;
         this.tooltipStatusNewSkill = content.tooltipStatusNewSkill;
         this.tankInfoHeaderTF = content.tankInfoHeaderTF;
         this.tankInfoTF = content.tankInfoTF;
         this.vehicleIco = content.vehicleIco;
         this.whiteBg = content.whiteBg;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.vehicleIco.hasEventListener(UILoaderEvent.COMPLETE))
         {
            this.vehicleIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
         }
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipTankmen " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function redraw() : void
      {
         var _loc2_:ToolTipBlockResultVO = null;
         var _loc5_:ILocale = null;
         var _loc6_:String = null;
         var _loc7_:TextFormat = null;
         var _loc8_:ToolTipBlockVO = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:ToolTipStatusColorsVO = null;
         var _loc14_:ToolTipStatusColorsVO = null;
         var _loc1_:Separator = null;
         separators = new Vector.<Separator>();
         this.dataVO = new TankmenVO(_data);
         _loc2_ = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         this.whiteBg.width = 10;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(this.dataVO.vName,Utils.instance.COLOR_HEADER,18,"$TitleFont") + "<br/>" + Utils.instance.htmlWrapper(this.dataVO.rank,Utils.instance.COLOR_NORMAL,12,"$FieldFont");
         this.headerTF.x = contentMargin.left + bgShadowMargin.left;
         this.headerTF.y = topPosition;
         this.headerTF.width = this.headerTF.textWidth + 5;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         _loc1_ = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition;
         separators.push(_loc1_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         _loc5_ = App.utils.locale;
         if(this.dataVO.vehicleContour != "")
         {
            topPosition -= Utils.instance.MARGIN_AFTER_SEPARATE;
            this.whiteBg.x = bgShadowMargin.left + 1;
            this.whiteBg.y = topPosition;
            this.whiteBg.height = 81;
            this.tankInfoHeaderTF.y = topPosition + 9;
            this.tankInfoHeaderTF.x = contentMargin.left + bgShadowMargin.left;
            this.tankInfoHeaderTF.text = TOOLTIPS.HANGAR_CREW_ASSIGNEDTO;
            this.tankInfoHeaderTF.width = this.tankInfoHeaderTF.textWidth + 5;
            this.vehicleIco.y = topPosition + 35;
            this.vehicleIco.x = contentMargin.left + bgShadowMargin.left;
            _loc6_ = _loc5_.makeString(MENU.tankmen(this.dataVO.currentVehicleType));
            _loc6_ = App.utils.toUpperOrLowerCase(_loc6_.slice(0,1),true) + _loc6_.slice(1);
            _loc6_ = this.dataVO.currentVehicleName + "<br/>" + _loc6_;
            _loc7_ = new TextFormat();
            _loc7_.leading = -2;
            this.tankInfoTF.autoSize = TextFieldAutoSize.LEFT;
            this.tankInfoTF.htmlText = Utils.instance.htmlWrapper(_loc6_,Utils.instance.COLOR_NUMBER,12,"$FieldFont");
            this.tankInfoTF.setTextFormat(_loc7_);
            this.tankInfoTF.width = this.tankInfoTF.textWidth + 5;
            this.tankInfoTF.y = this.vehicleIco.y + 1;
            this.tankInfoTF.x = this.vehicleIco.x;
            this.vehicleIco.autoSize = false;
            this.vehicleIco.maintainAspectRatio = false;
            this.vehicleIco.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            this.vehicleIco.source = this.dataVO.vehicleContour;
            topPosition += this.whiteBg.height;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.tankInfoHeaderTF.visible = this.whiteBg.visible = this.tankInfoTF.visible = this.vehicleIco.visible = false;
            this.tankInfoHeaderTF.width = 10;
            this.tankInfoTF.width = 10;
         }
         if(this.dataVO.params)
         {
            _loc8_ = new ToolTipBlockVO();
            _loc8_.startYPos = topPosition;
            _loc8_.header = _loc5_.makeString(TOOLTIPS.HANGAR_CREW_SPECIALTY_SKILLS);
            _loc8_.contener = content;
            _loc8_.childrenNamePrefix = "params";
            _loc8_.leftText = "";
            _loc8_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc8_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc8_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc8_.rightTextCSS = new StyleSheet();
            _loc8_.rightTextCSS.setStyle("h1",{
               "color":Utils.instance.COLOR_NORMAL,
               "fontSize":"11px",
               "fontFamily":"$TextFont",
               "leading":"2px"
            });
            _loc8_.rightTextCSS.setStyle("h2",{
               "color":Utils.instance.COLOR_ALERT,
               "fontSize":"11px",
               "fontFamily":"$TextFont",
               "leading":"2px"
            });
            _loc8_.rightTextCSS.setStyle("p",{
               "color":Utils.instance.COLOR_ALERT,
               "fontSize":"11px",
               "fontFamily":"$TextFont",
               "leading":"2px"
            });
            _loc3_ = this.dataVO.params.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc9_ = Boolean(this.dataVO.params[_loc4_][2]) ? Utils.instance.COLOR_NUMBER : Utils.instance.COLOR_ALERT;
               _loc8_.leftText += Utils.instance.htmlWrapper(this.dataVO.params[_loc4_][1],_loc9_,12,"$TextFont") + "<br/>";
               _loc10_ = "";
               if(_loc4_ == 0)
               {
                  if(this.dataVO.vehicleName == this.dataVO.currentVehicleName || this.dataVO.currentVehicleName == "")
                  {
                     _loc10_ = "<h1>" + _loc5_.makeString(this.dataVO.params[_loc4_][0]) + " " + this.dataVO.vehicleName + "</h1>";
                  }
                  else
                  {
                     _loc10_ = "<h1>" + _loc5_.makeString(this.dataVO.params[_loc4_][0]) + " <p>" + this.dataVO.vehicleName + "</p></h1>";
                  }
               }
               else
               {
                  _loc10_ = "<h1>" + _loc5_.makeString(this.dataVO.params[_loc4_][0]) + "</h1>";
               }
               _loc8_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(_loc10_);
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc8_,contentMargin.left + bgShadowMargin.left);
            blockResults.push(_loc2_);
            topPosition = _loc2_.startYPos;
            hasIcon = !!_loc2_.hasIcons ? Boolean(true) : Boolean(hasIcon);
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc2_.leftPartMaxW > leftPartMaxW ? Number(_loc2_.leftPartMaxW) : Number(leftPartMaxW);
         }
         if(this.dataVO.newSkillsCount > 0)
         {
            _loc11_ = _loc5_.makeString(TOOLTIPS.HANGAR_CREW_NEW_SKILL_AVAILABLE_HEADER);
            _loc12_ = _loc5_.makeString(TOOLTIPS.HANGAR_CREW_NEW_SKILL_AVAILABLE_TEXT);
            _loc13_ = Utils.instance.getStatusColor(Utils.instance.STATUS_ADDITIONAL);
            this.tooltipStatusNewSkill.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatusNewSkill.setData(_loc11_,_loc12_,_loc13_,Status.ICO_NEW_SKILL);
            this.tooltipStatusNewSkill.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatusNewSkill.y = topPosition;
            topPosition += this.tooltipStatusNewSkill.actualHeight + Utils.instance.MARGIN_AFTER_BLOCK;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.tooltipStatusNewSkill.y = 0;
            this.tooltipStatusNewSkill.width = 10;
            this.tooltipStatusNewSkill.visible = false;
         }
         if(this.dataVO.status)
         {
            _loc14_ = Utils.instance.getStatusColor(this.dataVO.statusLevel);
            this.tooltipStatus.y = topPosition;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(this.dataVO.statusHeader,this.dataVO.statusText,_loc14_);
            topPosition += this.tooltipStatus.height;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition += Utils.instance.MARGIN_AFTER_BLOCK;
         }
         else
         {
            this.tooltipStatus.visible = false;
            this.tooltipStatus.y = 0;
         }
         popSeparator();
         this.dataVO = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
      }
      
      private function getSign(param1:Number) : String
      {
         return param1 >= 0 ? "+" : "";
      }
      
      private function onIcoLoaded(param1:UILoaderEvent) : void
      {
         if(this.vehicleIco.hasEventListener(UILoaderEvent.COMPLETE))
         {
            this.vehicleIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
         }
         this.vehicleIco.scaleX = -1;
         this.vehicleIco.x = contentMargin.left + bgShadowMargin.left + this.vehicleIco.width;
         this.tankInfoTF.x = this.vehicleIco.x + 5;
      }
   }
}
