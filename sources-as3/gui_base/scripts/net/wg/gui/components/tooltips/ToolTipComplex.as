package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipComplex extends ToolTipBase
   {
      
      private static const CONTENT_COLOR:String = "#8C8C7E";
      
      private static const CONTENT_FONT:String = "$FieldFont";
      
      private static const CONTENT_FONT_SIZE:Number = 14;
       
      
      private var _minWidth:Number;
      
      private var _maxWidth:Number;
      
      private var contentList:Vector.<TextField>;
      
      public function ToolTipComplex()
      {
         super();
         this.contentList = new Vector.<TextField>();
         contentMargin.top = 15;
         contentMargin.right = 13;
         contentMargin.bottom = 0;
         contentMargin.left = 19;
      }
      
      private static function setTextProp(param1:TextField, param2:String, param3:TextFormat, param4:String) : void
      {
         param3.align = param4;
         param3.leading = 0;
         param1.wordWrap = true;
         param1.multiline = true;
         param1.autoSize = param4;
         if(App.utils.toUpperOrLowerCase(param2,false).indexOf("face=",0) == -1)
         {
            param3.font = CONTENT_FONT;
         }
         if(param2.slice(0,1) == "#")
         {
            param2 = App.utils.locale.makeString(param2);
            param1.textColor = Utils.instance.convertStringColorToNumber(CONTENT_COLOR);
         }
         param1.htmlText = "<font color=\"" + CONTENT_COLOR + "\" size=\"" + CONTENT_FONT_SIZE + "\">" + param2 + "</font>";
         param1.setTextFormat(param3);
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         this._minWidth = param2.minWidth;
         this._maxWidth = param2.maxWidth;
         super.build(param1,param2);
      }
      
      override protected function initData(param1:Object) : void
      {
         _type = TOOLTIPS_CONSTANTS.COMPLEX;
         _component = TOOLTIPS_CONSTANTS.COMPLEX;
         _data = param1;
      }
      
      override protected function redraw() : void
      {
         this.setContent();
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TextField = null;
         if(this.contentList)
         {
            while(this.contentList.length)
            {
               _loc1_ = this.contentList.pop();
               _loc1_.text = "";
               _loc1_.htmlText = "";
               removeChild(_loc1_);
               _loc1_ = null;
            }
            this.contentList = null;
         }
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Object = this.calcDimension();
         background.x = background.y = 0;
         background.width = Math.round(_loc1_.w) + contentMargin.horizontal + bgShadowMargin.horizontal;
         background.height = Math.round(_loc1_.h) + contentMargin.vertical + bgShadowMargin.vertical;
      }
      
      private function calcDimension() : Object
      {
         var _loc6_:TextField = null;
         var _loc1_:Number = this._maxWidth;
         var _loc2_:Number = 0;
         var _loc3_:int = this.contentList.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = this.contentList[_loc4_];
            if(this._maxWidth)
            {
               if(_loc1_ < _loc6_.width)
               {
                  _loc6_.width = _loc1_;
                  _loc6_.height = _loc6_.textHeight + 4;
               }
               else
               {
                  _loc1_ = _loc6_.width;
               }
            }
            else if(_loc1_ < _loc6_.width)
            {
               _loc1_ = _loc6_.width;
            }
            if(_loc2_ < _loc6_.y + _loc6_.textHeight)
            {
               _loc2_ = _loc6_.y + _loc6_.textHeight;
            }
            _loc4_++;
         }
         _loc1_ += 5;
         return {
            "w":_loc1_,
            "h":_loc2_
         };
      }
      
      private function setContent() : void
      {
         var _loc1_:String = null;
         _loc1_ = _data.toString();
         var _loc2_:TextFormat = new TextFormat();
         var _loc3_:Number = 10;
         var _loc4_:Number = this._minWidth == 0 ? Number(500) : Number(this._minWidth);
         var _loc5_:TextField = App.textMgr.createTextField();
         _loc5_.x = contentMargin.left + bgShadowMargin.left;
         _loc5_.y = contentMargin.top + bgShadowMargin.top;
         _loc5_.width = _loc4_;
         _loc5_.height = _loc3_;
         setTextProp(_loc5_,_loc1_,_loc2_,"left");
         _loc5_.width = _loc5_.textWidth + 4;
         this.contentList.push(_loc5_);
         addChild(_loc5_);
      }
   }
}
