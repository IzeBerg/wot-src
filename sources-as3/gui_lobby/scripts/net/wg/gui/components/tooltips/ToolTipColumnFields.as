package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.ColumnFieldsVo;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipColumnFields extends ToolTipBase
   {
      
      private static const HEADER_BOTTOM_MARGIN:Number = 10;
      
      private static const BETWEEN_COLUMN_MARGIN:Number = 10;
      
      private static const MIN_CONTENT_WIDTH:Number = 200;
       
      
      private var headerTF:TextField = null;
      
      private var _columns:Vector.<TextField> = null;
      
      public function ToolTipColumnFields()
      {
         super();
         this.headerTF = content.headerTF;
         this._columns = new Vector.<TextField>();
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TextField = null;
         this.headerTF = null;
         if(this._columns)
         {
            _loc1_ = null;
            while(this._columns.length)
            {
               _loc1_ = this._columns.pop();
               content.removeChild(_loc1_);
               _loc1_ = null;
            }
            this._columns = null;
         }
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         var _loc1_:ColumnFieldsVo = new ColumnFieldsVo(_data);
         var _loc2_:TextField = null;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         _loc3_.size = 14;
         _loc3_.font = "$FieldFont";
         _loc3_.align = TextFormatAlign.LEFT;
         var _loc4_:String = Values.EMPTY_STR;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         while(_loc6_ < _loc1_.columns.length)
         {
            _loc4_ = _loc1_.columns[_loc6_];
            _loc2_ = App.textMgr.createTextField();
            _loc5_ += this.setTextFieldProps(_loc2_,_loc3_,_loc4_);
            content.addChild(_loc2_);
            this._columns.push(_loc2_);
            _loc6_++;
         }
         _loc5_ += (this._columns.length - 1) * BETWEEN_COLUMN_MARGIN;
         this.headerTF.width = Math.max(_loc5_,MIN_CONTENT_WIDTH);
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = _loc1_.name;
         this.headerTF.height = this.headerTF.textHeight + 4 ^ 0;
         contentMargin.bottom = 1;
         contentMargin.right = -1;
         _loc1_.dispose();
         _loc1_ = null;
         this.updatePositions();
         super.redraw();
      }
      
      protected function updatePositions() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:TextField = null;
         var _loc4_:Number = NaN;
         _loc1_ = bgShadowMargin.left + contentMargin.left;
         this.headerTF.x = _loc1_;
         this.headerTF.y = topPosition;
         if(this._columns)
         {
            topPosition += this.headerTF.height + HEADER_BOTTOM_MARGIN;
            _loc2_ = _loc1_;
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < this._columns.length)
            {
               _loc3_ = this._columns[_loc4_];
               _loc3_.y = topPosition;
               _loc3_.x = _loc2_;
               _loc2_ += _loc3_.width + BETWEEN_COLUMN_MARGIN ^ 0;
               _loc4_++;
            }
         }
      }
      
      private function setTextFieldProps(param1:TextField, param2:TextFormat, param3:String) : Number
      {
         param1.multiline = true;
         param1.autoSize = TextFieldAutoSize.LEFT;
         param1.wordWrap = true;
         param1.textColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         param1.width = 300;
         param1.setTextFormat(param2);
         param1.htmlText = param3;
         param1.width = param1.textWidth + 4;
         param1.height = param1.textHeight + 4;
         return param1.width;
      }
   }
}
