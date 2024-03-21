package net.wg.gui.components.advanced
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class CounterEx extends UIComponentEx
   {
      
      protected static const ANIMATE_STEP_FRAMES:int = 40;
      
      protected static const START_FRAME:int = 1;
      
      private static const ZERO_STR:String = "0";
      
      private static const CMP_NUMBER_LINE:String = "NumberLine";
      
      private static const FIELD_NUM:String = "num_";
      
      private static const STR_MINUS:String = "-";
       
      
      public var contener_mc:MovieClip = null;
      
      public var tempTF:TextField = null;
      
      protected var lines:Vector.<MovieClip> = null;
      
      protected var checkTruePosition:Vector.<PositionInfo> = null;
      
      private var _number:Number = -1;
      
      private var _font:String = "";
      
      private var _size:Number;
      
      private var _color:Number;
      
      private var _endingChar:String = "";
      
      private var _letterSpacing:Number;
      
      private var _speed:Number;
      
      private var _playAnim:Boolean;
      
      private var _tFormat:TextFormat;
      
      private var _tfMetrics:Object;
      
      private var _realMetricsWidth:Number = 0;
      
      private var _tween:Tween;
      
      private var _localizationSymbol:String;
      
      private var _tweenNum:int = 0;
      
      private var _formattedNumber:String = "0";
      
      private var _expectedWidth:Number;
      
      private var _patternSpaces:RegExp;
      
      public function CounterEx()
      {
         this._tfMetrics = {};
         this._patternSpaces = / /g;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.clearLines();
         this._tFormat = null;
         this._tfMetrics = null;
         this.contener_mc = null;
         this.tempTF = null;
         App.utils.data.cleanupDynamicObject(this._patternSpaces);
         this._patternSpaces = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tempTF.visible = false;
      }
      
      public function init(param1:Number, param2:String, param3:String, param4:Boolean) : void
      {
         this.formattedNumber = param2;
         this.localizationSymbol = param3;
         this.playAnim = param4;
         this.number = param1;
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function startAnim() : void
      {
         if(this.font != Values.EMPTY_STR && this.size > 0 && this.color && this.speed > 0)
         {
            this._tFormat = this.tempTF.getTextFormat();
            this._tFormat.color = this.color;
            this._tFormat.size = this.size;
            this._tFormat.font = this.font;
            this._tFormat.letterSpacing = this.letterSpacing;
            this._tFormat.align = TextFormatAlign.LEFT;
            this.tempTF.autoSize = TextFieldAutoSize.LEFT;
            this.tempTF.text = this.formattedNumber.length > 0 ? this.formattedNumber : ZERO_STR;
            this.tempTF.setTextFormat(this._tFormat);
            this._tFormat = this.tempTF.getTextFormat(0,1);
            this._realMetricsWidth = this.tempTF.getLineMetrics(0).width;
            this._tfMetrics.lines = String(Math.abs(this.number)).length;
            this.tempTF.text = Values.EMPTY_STR;
            this.tempTF.visible = false;
            this.clearTween();
            this.clearLines();
            this.createLines();
            this.animate();
         }
      }
      
      private function clearLines() : void
      {
         while(this.contener_mc.numChildren > 0)
         {
            this.contener_mc.removeChildAt(0);
         }
         if(this.lines)
         {
            this.lines.splice(0,this.lines.length);
            this.lines = null;
         }
         if(this.checkTruePosition)
         {
            this.checkTruePosition.splice(0,this.checkTruePosition.length);
            this.checkTruePosition = null;
         }
      }
      
      private function createLines() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc9_:TextField = null;
         var _loc10_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:TextLineMetrics = null;
         var _loc5_:IClassFactory = App.utils.classFactory;
         var _loc6_:int = this._tfMetrics.lines;
         if(this._endingChar.length)
         {
            _loc4_ = this.createTextLine();
            _loc4_.text = this._endingChar;
            _loc1_ -= _loc4_.textWidth + this.letterSpacing;
            _loc4_.x = _loc1_;
         }
         this.checkTruePosition = new Vector.<PositionInfo>();
         this.lines = new Vector.<MovieClip>();
         var _loc7_:PositionInfo = null;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = new PositionInfo(false,Math.floor(ANIMATE_STEP_FRAMES * Math.floor(Math.abs(this.number) / Math.pow(10,_loc8_) % 10)) + START_FRAME);
            this.checkTruePosition[_loc8_] = _loc7_;
            if(_loc8_ > 0 && _loc8_ % 3 == 0 && StringUtils.isNotEmpty(this.localizationSymbol))
            {
               _loc4_ = this.createTextLine();
               _loc4_.text = this.localizationSymbol;
               _loc1_ -= Math.round(_loc4_.textWidth + this.letterSpacing);
               _loc4_.x = _loc1_;
               if(this.localizationSymbol.replace(this._patternSpaces,Values.EMPTY_STR).length == 0)
               {
                  this.contener_mc.removeChild(_loc4_);
               }
            }
            _loc3_ = _loc5_.getComponent(CMP_NUMBER_LINE,MovieClip);
            this.contener_mc.addChild(_loc3_);
            this.tempTF.autoSize = TextFieldAutoSize.LEFT;
            this.tempTF.text = String(Math.abs(this.number) / Math.pow(10,_loc8_) % 10 ^ 0);
            this.tempTF.setTextFormat(this._tFormat);
            _loc2_ = this.tempTF.getLineMetrics(0);
            this.tempTF.visible = false;
            _loc1_ -= Math.round(_loc2_.width + this.letterSpacing);
            _loc3_.x = _loc1_;
            _loc3_.y = 0;
            _loc10_ = 0;
            while(_loc10_ < 10)
            {
               _loc9_ = _loc3_[FIELD_NUM + _loc10_].textField;
               _loc9_.autoSize = TextFormatAlign.LEFT;
               _loc9_.textColor = this.color;
               _loc9_.setTextFormat(this._tFormat);
               _loc10_++;
            }
            _loc3_.gotoAndStop(Math.floor(ANIMATE_STEP_FRAMES * Math.floor(this._tweenNum / Math.pow(10,_loc8_) % 10)) + START_FRAME);
            this.lines[_loc8_] = _loc3_;
            _loc8_++;
         }
         if(this.number < 0)
         {
            _loc4_ = this.createTextLine();
            _loc4_.text = STR_MINUS;
            _loc1_ -= Math.round(_loc4_.textWidth + this.letterSpacing);
            _loc4_.x = _loc1_;
         }
         this._expectedWidth = Math.abs(_loc1_);
         this.checkTruePosition.push(new PositionInfo(true,0));
      }
      
      private function createTextLine() : TextField
      {
         var _loc1_:TextField = App.textMgr.createTextField();
         this.contener_mc.addChild(_loc1_);
         _loc1_.selectable = false;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.textColor = this.color;
         _loc1_.defaultTextFormat = this._tFormat;
         return _loc1_;
      }
      
      private function animate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.playAnim)
         {
            this._tween = new Tween(this.speed,this,{"tweenNum":Math.abs(this.number)},{
               "paused":false,
               "ease":Cubic.easeOut,
               "onComplete":null
            });
         }
         else
         {
            _loc1_ = this.lines.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.checkTruePosition[_loc2_].isSet = true;
               this.lines[_loc2_].gotoAndStop(this.checkTruePosition[_loc2_].num);
               _loc2_++;
            }
         }
      }
      
      private function setLinesPosition(param1:Number) : void
      {
         var _loc3_:Boolean = false;
         if(!this.lines)
         {
            return;
         }
         var _loc2_:int = this.lines.length;
         var _loc4_:PositionInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            if(_baseDisposed)
            {
               return;
            }
            _loc5_ = this.lines[_loc6_];
            _loc4_ = this.checkTruePosition[_loc6_];
            _loc3_ = param1 < Math.abs(this.number) ? Boolean(_loc5_.currentFrame >= _loc4_.num) : Boolean(_loc5_.currentFrame <= _loc4_.num);
            if(!_loc4_.isSet && this.checkTruePosition[_loc6_ + 1].isSet && _loc3_ || param1 == Math.abs(this.number))
            {
               _loc4_.isSet = true;
               _loc5_.gotoAndStop(_loc4_.num);
            }
            else if(!_loc4_.isSet)
            {
               _loc5_.gotoAndStop(START_FRAME + ANIMATE_STEP_FRAMES * int((param1 / Math.pow(10,_loc6_) ^ 0) % 10));
            }
            _loc6_++;
         }
      }
      
      public function get tweenNum() : Number
      {
         return this._tweenNum;
      }
      
      public function set tweenNum(param1:Number) : void
      {
         if(this._tweenNum == param1)
         {
            return;
         }
         this._tweenNum = param1;
         this.setLinesPosition(this._tweenNum);
      }
      
      public function get expectedWidth() : Number
      {
         return this._expectedWidth;
      }
      
      [Inspectable(defaultValue="-1",type="Number")]
      public function get number() : Number
      {
         return this._number;
      }
      
      public function set number(param1:Number) : void
      {
         if(param1 == this._number)
         {
            return;
         }
         this._number = param1;
         this.startAnim();
      }
      
      public function get playAnim() : Boolean
      {
         return this._playAnim;
      }
      
      public function set playAnim(param1:Boolean) : void
      {
         if(param1 == this._playAnim)
         {
            return;
         }
         this._playAnim = param1;
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get size() : Number
      {
         return this._size;
      }
      
      public function set size(param1:Number) : void
      {
         if(param1 == this._size)
         {
            return;
         }
         this._size = param1;
         this.startAnim();
      }
      
      [Inspectable(defaultValue="#FFFFFF",type="Color")]
      public function get color() : Number
      {
         return this._color;
      }
      
      public function set color(param1:Number) : void
      {
         if(param1 == this._color)
         {
            return;
         }
         this._color = param1;
         this.startAnim();
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get letterSpacing() : Number
      {
         return this._letterSpacing;
      }
      
      public function set letterSpacing(param1:Number) : void
      {
         if(param1 == this._letterSpacing)
         {
            return;
         }
         this._letterSpacing = param1;
         this.startAnim();
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get speed() : Number
      {
         return this._speed;
      }
      
      public function set speed(param1:Number) : void
      {
         if(param1 == this._speed)
         {
            return;
         }
         this._speed = param1;
         this.startAnim();
      }
      
      [Inspectable(defaultValue="$TitleFont",enumeration="$TitleFont,$TextFont,$FieldFont")]
      public function get font() : String
      {
         return this._font;
      }
      
      public function set font(param1:String) : void
      {
         if(param1 == this._font)
         {
            return;
         }
         this._font = param1;
         this.startAnim();
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function get localizationSymbol() : String
      {
         return this._localizationSymbol;
      }
      
      public function set localizationSymbol(param1:String) : void
      {
         if(param1 == this._localizationSymbol)
         {
            return;
         }
         this._localizationSymbol = param1;
      }
      
      public function get metricsWidth() : Number
      {
         return this._realMetricsWidth;
      }
      
      [Inspectable(defaultValue="0")]
      public function get formattedNumber() : String
      {
         return this._formattedNumber;
      }
      
      public function set formattedNumber(param1:String) : void
      {
         this._formattedNumber = param1;
      }
      
      public function get endingChar() : String
      {
         return this._endingChar;
      }
      
      public function set endingChar(param1:String) : void
      {
         this._endingChar = param1;
      }
   }
}

class PositionInfo
{
    
   
   public var isSet:Boolean = false;
   
   public var num:int = -1;
   
   function PositionInfo(param1:Boolean, param2:int)
   {
      super();
      this.isSet = param1;
      this.num = param2;
   }
}
