package net.wg.gui.components.tooltips.helpers
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.helpers.IconTextHelper;
   import net.wg.gui.components.tooltips.Separator;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   
   public class Utils
   {
      
      private static var __instance:Utils;
      
      private static var __allowInstantiation:Boolean = false;
      
      private static const ICON_TEXT_OFFSET:int = -17;
      
      private static const ICON_TEXT_PREFIX:String = "_iconText_";
      
      private static const LEFT_TEXTFIELD_PREFIX:String = "_left";
      
      private static const HEADER_TEXTFIELD_PREFIX:String = "_header";
      
      private static const TEXT_FIELD_WIDTH_PADDING:int = 5;
      
      private static const TEXT_FIELD_HEIGHT_PADDING:int = 6;
       
      
      public const COLOR_HEADER:String = "#fdf4ce";
      
      public const COLOR_SUB_HEADER:String = "#FEFEEC";
      
      public const COLOR_BLOCK_HEADER:String = "#4c4b41";
      
      public const COLOR_NUMBER:String = "#d3d3ca";
      
      public const COLOR_ALERT:String = "#ff0000";
      
      public const COLOR_NORMAL:String = "#8c8c7e";
      
      public const COLOR_CRYSTAL:String = "#C9C9B6";
      
      public const COLOR_NEUTRAL:String = "#CBAC77";
      
      public const COLOR_NORMAL_DARK:String = "#595950";
      
      public const COLOR_SUB_NORMAL:String = "#4a4a3f";
      
      public const COLOR_ADD_INFO:String = "#ccad77";
      
      public const COLOR_NOTE:String = "#497212";
      
      public const COLOR_LABEL:String = "#E9E2BF";
      
      public const COLOR_WARNING:String = "#EE7000";
      
      public const STATUS_ADDITIONAL:String = "additional";
      
      public const STATUS_RENTED:String = "rented";
      
      public const STATUS_DISMISSED:String = "dismissed";
      
      public const STATUS_CRITICAL:String = "critical";
      
      public const STATUS_WARNING:String = "warning";
      
      public const STATUS_INFO:String = "info";
      
      public const allowStatuses:Array = [this.STATUS_ADDITIONAL,this.STATUS_RENTED,this.STATUS_CRITICAL,this.STATUS_WARNING,this.STATUS_INFO];
      
      public const MARGIN_AFTER_BLOCK:Number = 15;
      
      public const MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS:Number = 3;
      
      public const MARGIN_AFTER_SEPARATE:Number = 11;
      
      public const MARGIN_AFTER_SUBHEADER:Number = 12;
      
      private const LEFT_TEXTFIELD_MIN_WIDTH:Number = 54;
      
      public const MARGIN_AFTER_LASTITEM:Number = 14;
      
      public function Utils()
      {
         super();
         if(__allowInstantiation)
         {
         }
      }
      
      public static function get instance() : Utils
      {
         if(!__instance)
         {
            __allowInstantiation = true;
            __instance = new Utils();
            __allowInstantiation = false;
         }
         return __instance;
      }
      
      public function addEmptyBlock(param1:ToolTipBlockVO) : void
      {
         param1.leftText += Utils.instance.htmlWrapper(" ",this.COLOR_NUMBER,12,"$TextFont") + "<br/>";
         param1.rightTextList.push(new ToolTipBlockRightListItemVO("<h1> </h1>",IconsTypes.EMPTY,0));
      }
      
      public function addHeader(param1:String, param2:Number, param3:Number, param4:String) : TextField
      {
         var _loc6_:TextFormat = null;
         var _loc5_:TextField = App.textMgr.createTextField();
         _loc6_ = new TextFormat();
         _loc6_.leading = -3;
         _loc6_.align = TextFormatAlign.LEFT;
         _loc5_.name = param1;
         _loc5_.x = param2;
         _loc5_.y = param3;
         _loc5_.width = 800;
         _loc5_.height = 10;
         _loc5_.autoSize = TextFormatAlign.LEFT;
         _loc5_.multiline = true;
         _loc5_.htmlText = this.htmlWrapper(param4,this.COLOR_BLOCK_HEADER,14,"$TitleFont");
         _loc5_.setTextFormat(_loc6_);
         return _loc5_;
      }
      
      public function convertStringColorToNumber(param1:String) : Number
      {
         return Number("0x" + param1.slice(1));
      }
      
      public function createBlock(param1:ToolTipBlockVO, param2:Number) : ToolTipBlockResultVO
      {
         var _loc9_:Number = NaN;
         var _loc10_:TextField = null;
         var _loc15_:Number = NaN;
         var _loc16_:IconText = null;
         var _loc17_:ToolTipBlockRightListItemVO = null;
         var _loc18_:Boolean = false;
         var _loc21_:TextField = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc3_:Number = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = "$TextFont";
         var _loc6_:Number = 0;
         var _loc7_:Vector.<IconText> = new Vector.<IconText>();
         var _loc8_:Array = [];
         if(param1.header)
         {
            _loc21_ = this.addHeader(param1.childrenNamePrefix + HEADER_TEXTFIELD_PREFIX,param2,param1.startYPos,param1.header);
            _loc22_ = _loc21_.textWidth;
            _loc21_.width = _loc22_;
            if(_loc6_ < _loc22_)
            {
               _loc6_ = _loc22_;
            }
            param1.contener.addChild(_loc21_);
            param1.startYPos += _loc21_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0;
         }
         _loc9_ = param1.startYPos;
         _loc10_ = App.textMgr.createTextField();
         _loc10_.name = param1.childrenNamePrefix + LEFT_TEXTFIELD_PREFIX;
         _loc10_.x = param2;
         _loc10_.y = _loc9_;
         _loc10_.autoSize = TextFormatAlign.RIGHT;
         _loc10_.multiline = true;
         _loc10_.wordWrap = true;
         _loc10_.textColor = param1.leftTextColor;
         _loc10_.htmlText = param1.leftText;
         var _loc11_:TextFormat = _loc10_.defaultTextFormat;
         _loc11_.leading = param1.leftTextLeading;
         _loc11_.align = TextFormatAlign.RIGHT;
         _loc11_.size = param1.leftTextSize;
         _loc11_.font = param1.leftTextFont;
         _loc10_.setTextFormat(_loc11_);
         var _loc12_:Number = _loc10_.textWidth + TEXT_FIELD_WIDTH_PADDING;
         if(_loc12_ < this.LEFT_TEXTFIELD_MIN_WIDTH)
         {
            _loc12_ = this.LEFT_TEXTFIELD_MIN_WIDTH;
         }
         _loc10_.height = _loc10_.textHeight + TEXT_FIELD_HEIGHT_PADDING;
         _loc10_.width = _loc12_;
         if(_loc3_ < _loc12_)
         {
            _loc3_ = _loc12_;
         }
         if(_loc6_ < _loc3_)
         {
            _loc6_ = _loc3_;
         }
         param1.contener.addChild(_loc10_);
         var _loc13_:Vector.<ToolTipBlockRightListItemVO> = param1.rightTextList;
         var _loc14_:uint = _loc13_.length;
         _loc15_ = param1.leftTextLineHight != 0 ? Number(param1.leftTextLineHight) : Number(_loc10_.getLineMetrics(0).height);
         _loc18_ = false;
         _loc4_ = 0;
         while(_loc4_ < _loc14_)
         {
            _loc17_ = _loc13_[_loc4_];
            _loc16_ = App.utils.classFactory.getComponent(Linkages.ICON_TEXT,IconText);
            param1.contener.addChild(_loc16_);
            _loc7_[_loc4_] = _loc16_;
            _loc18_ = _loc18_ || IconTextHelper.getInstance().isIconClipVisible(_loc17_.icon);
            _loc4_++;
         }
         var _loc19_:String = param1.childrenNamePrefix + ICON_TEXT_PREFIX;
         var _loc20_:Number = param2 + this.LEFT_TEXTFIELD_MIN_WIDTH + this.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS;
         _loc4_ = 0;
         while(_loc4_ < _loc14_)
         {
            _loc17_ = _loc13_[_loc4_];
            _loc16_ = _loc7_[_loc4_];
            _loc16_.name = _loc19_ + _loc4_;
            _loc16_.x = _loc20_;
            _loc16_.y = Math.round(_loc9_);
            _loc16_.textAlign = TextFormatAlign.LEFT;
            _loc16_.textColor = param1.rightTextColor;
            _loc16_.iconPosition = TextFormatAlign.LEFT;
            _loc16_.textFont = _loc5_;
            _loc16_.textSize = 11;
            if(param1.rightTextCSS)
            {
               _loc16_.css = param1.rightTextCSS;
            }
            _loc16_.icon = _loc17_.icon;
            _loc16_.xCorrect = !!_loc18_ ? Number(_loc17_.textXOffset) : Number(ICON_TEXT_OFFSET);
            _loc16_.text = _loc17_.text;
            _loc16_.textField.htmlText = _loc17_.text;
            _loc16_.textField.width = _loc16_.textField.textWidth + 2;
            _loc16_.iconClip.y = _loc17_.textYOffset;
            _loc16_.validateNow();
            _loc9_ += _loc15_;
            if(!_loc18_)
            {
               _loc23_ = _loc16_.x + _loc16_.textField.x + _loc16_.textField.width;
               if(_loc23_ > _loc6_)
               {
                  _loc6_ = _loc23_;
               }
            }
            _loc4_++;
         }
         param1.startYPos = Math.round(_loc9_) + this.MARGIN_AFTER_BLOCK;
         return new ToolTipBlockResultVO(param1.startYPos,_loc10_,_loc7_,_loc8_,_loc21_,_loc18_,_loc3_,_loc6_);
      }
      
      public function createSeparate(param1:MovieClip) : Separator
      {
         var _loc2_:Separator = null;
         var _loc3_:IPoolManager = App.utils.poolManager;
         var _loc4_:String = Linkages.TOOLTIP_SEPARATOR_UI;
         if(_loc3_.containsPool(_loc4_))
         {
            _loc2_ = Separator(App.utils.poolManager.getItem(_loc4_));
         }
         else
         {
            _loc2_ = App.utils.classFactory.getComponent(_loc4_,Separator);
         }
         param1.addChild(_loc2_);
         return _loc2_;
      }
      
      public function getIcon(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false) : String
      {
         var _loc5_:String = IconsTypes.EMPTY;
         switch(param1)
         {
            case "xp":
               _loc5_ = !!param4 ? IconsTypes.ELITE_XP : IconsTypes.XP;
               break;
            case "doubleXPFactor":
               _loc5_ = IconsTypes.DOUBLE_XP_FACTOR;
               break;
            case "actionXPFactor":
               _loc5_ = IconsTypes.ACTION_XP_FACTOR;
               break;
            case "unlock_price":
               _loc5_ = IconsTypes.XP_PRICE;
               break;
            case "buy_price_action":
               _loc5_ = !!param3 ? IconsTypes.CREDITS : IconsTypes.GOLD;
               break;
            case "buy_price":
            case "sell_price":
               if(param3)
               {
                  _loc5_ = IconsTypes.GOLD;
               }
               else
               {
                  _loc5_ = IconsTypes.CREDITS;
               }
               break;
            case "rentals":
               _loc5_ = IconsTypes.RENTALS;
               break;
            case "sheets":
            case "collectedSheets":
               _loc5_ = IconsTypes.REWARD_SHEET;
               break;
            default:
               _loc5_ = IconsTypes.EMPTY;
         }
         return _loc5_;
      }
      
      public function getStatusColor(param1:String) : ToolTipStatusColorsVO
      {
         var _loc2_:ToolTipStatusColorsVO = new ToolTipStatusColorsVO();
         var _loc3_:uint = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         switch(param1)
         {
            case this.STATUS_RENTED:
               _loc2_.textColor = 16754521;
               _loc2_.headerFontSize = 13;
               _loc2_.headerFontFace = "$FieldFont";
               _loc3_ = 16723968;
               _loc4_ = 2.6;
               _loc5_ = 0.6;
               _loc6_ = 12;
               break;
            case this.STATUS_ADDITIONAL:
               _loc2_.textColor = 16761699;
               _loc2_.filters = [];
               return _loc2_;
            case this.STATUS_CRITICAL:
               _loc2_.textColor = 16721687;
               _loc3_ = 16711680;
               _loc4_ = 0.5;
               _loc5_ = 0.27;
               _loc6_ = 11;
               break;
            case this.STATUS_WARNING:
               _loc2_.textColor = 16117989;
               _loc3_ = 15521204;
               _loc4_ = 0.3;
               _loc5_ = 0.11;
               _loc6_ = 11;
               break;
            case this.STATUS_DISMISSED:
               _loc2_.textColor = 0;
               break;
            case this.STATUS_INFO:
            default:
               _loc2_.textColor = 8041216;
               _loc3_ = 3997440;
               _loc4_ = 0.5;
               _loc5_ = 0.24;
               _loc6_ = 11;
         }
         _loc2_.filters = [];
         var _loc7_:DropShadowFilter = new DropShadowFilter();
         _loc7_.distance = 0;
         _loc7_.angle = 0;
         _loc7_.color = _loc3_;
         _loc7_.alpha = _loc5_;
         _loc7_.blurX = _loc6_;
         _loc7_.blurY = _loc6_;
         _loc7_.strength = _loc4_;
         _loc7_.quality = 3;
         _loc7_.inner = false;
         _loc7_.knockout = false;
         _loc7_.hideObject = false;
         _loc2_.filters.push(_loc7_);
         return _loc2_;
      }
      
      public function htmlWrapper(param1:String, param2:String = "#ffffff", param3:Number = 12, param4:String = "$TextFont") : String
      {
         var _loc5_:String = "";
         _loc5_ += param4 == "" ? "" : " face=\"" + param4 + "\"";
         _loc5_ += param2 == "" ? "" : " color=\"" + param2 + "\"";
         _loc5_ += !param3 ? "" : " size=\"" + param3 + "\"";
         return "<font" + _loc5_ + ">" + param1 + "</font>";
      }
   }
}
