package net.wg.gui.lobby.techtree.helpers
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.OutLiteral;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import scaleform.clik.motion.Tween;
   
   public class NTGraphics extends LinesGraphics
   {
      
      private static const SHOW_TWEEN_TIME:int = 150;
      
      private static const ACTION_LINE_COLOR:uint = 16768409;
      
      private static const FIELD_Y:String = "y";
      
      private static const LOG_MSG_DRAW_TM_SET_WARNING:String = "Warning! From top part of node can goes only one line.";
      
      private static const LOG_MSG_DRAW_BM_SET_WARNING:String = "Warning! From bottom part of node can goes only one line.";
      
      private static const LOG_MSG_DRAW_RIGHT_SET_WARNING:String = "Warning! Only one line can goes from part of a node called ";
       
      
      public var mainLine:Sprite = null;
      
      private var _tween:Tween = null;
      
      private var _tweenWrapper:TweenWrapper = null;
      
      private var _parentIDs:Object;
      
      private var _zeroSprite:Sprite = null;
      
      public function NTGraphics()
      {
         this._parentIDs = {};
         super();
         this._tweenWrapper = new TweenWrapper(this);
         this._zeroSprite = new Sprite();
         this._zeroSprite.visible = false;
         var _loc1_:Graphics = this._zeroSprite.graphics;
         _loc1_.beginFill(4095,0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         addChild(this._zeroSprite);
         this.mainLine.mouseEnabled = this.mainLine.mouseChildren = false;
      }
      
      override public function clearUp() : void
      {
         var _loc1_:DisplayObject = null;
         super.clearUp();
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(numChildren - 1);
            if(_loc1_ is IRenderer)
            {
               clearUpRenderer(IRenderer(_loc1_));
            }
            removeChild(_loc1_);
         }
         this._parentIDs = null;
      }
      
      override public function setup() : void
      {
         colorIdxs = new <uint>[ARROW_COLOR,ARROW_COLOR,ACTION_LINE_COLOR];
      }
      
      override protected function onDispose() : void
      {
         this._tween.paused = true;
         this._tween.dispose();
         this._tween = null;
         this._tweenWrapper.dispose();
         this._tweenWrapper = null;
         this.mainLine = null;
         this._zeroSprite = null;
         this.clearUp();
         super.onDispose();
      }
      
      override protected function getLinesAndArrowsSprite(param1:IRenderer, param2:Boolean = true) : Sprite
      {
         var _loc3_:Sprite = super.getLinesAndArrowsSprite(param1,param2);
         swapChildren(_loc3_,this.mainLine);
         return _loc3_;
      }
      
      public function clearCache() : void
      {
         this._parentIDs = {};
      }
      
      public function drawLineSet(param1:IRenderer, param2:Object, param3:Boolean) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc4_:String = param2.outLiteral;
         switch(_loc4_)
         {
            case OutLiteral.RIGHT_MIDDLE:
               this.drawLineRMSet(param1,param2,param3);
               break;
            case OutLiteral.TOP_MIDDLE:
               this.drawLineTMSet(param1,param2,param3);
               break;
            case OutLiteral.BOTTOM_MIDDLE:
               this.drawLineBMSet(param1,param2,param3);
               break;
            case OutLiteral.TOP_RIGHT:
            case OutLiteral.BOTTOM_RIGHT:
               this.drawLineRightSet(_loc4_,param1,param2,param3);
         }
      }
      
      public function drawNodeLines(param1:IRenderer, param2:Boolean) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Object = param1.getDisplayInfo();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.lines;
         var _loc6_:int = _loc4_.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = _loc4_[_loc7_];
            if(_loc5_ == null)
            {
               return;
            }
            this.drawLineSet(param1,_loc5_,param2);
            _loc7_++;
         }
      }
      
      public function drawTopLines(param1:IRenderer, param2:Boolean) : void
      {
         var _loc8_:Point = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:IRenderer = null;
         var _loc19_:uint = 0;
         var _loc3_:Object = param1.getDisplayInfo();
         if(_loc3_ == null || _loc3_.lines == null)
         {
            return;
         }
         var _loc4_:Object = _loc3_.lines[0];
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Array = _loc4_.outPin;
         var _loc6_:Array = _loc4_.inPins;
         var _loc7_:Point = new Point(_loc5_[0],_loc5_[1]);
         var _loc12_:int = _loc6_.length;
         var _loc13_:int = int.MAX_VALUE;
         var _loc17_:Array = [];
         var _loc18_:Array = [];
         _loc14_ = 0;
         while(_loc14_ < _loc12_)
         {
            _loc15_ = _loc6_[_loc14_];
            if(!isNaN(_loc15_.childID))
            {
               _loc8_ = new Point(_loc15_.inPin[0],_loc15_.inPin[1]);
               _loc13_ = Math.min(_loc13_,_loc8_.x);
               _loc16_ = container.getNodeByID(_loc15_.childID);
               if(_loc7_.y > _loc8_.y)
               {
                  _loc17_.push(new TopLineInfo(_loc15_.childID,_loc8_));
               }
               else if(_loc7_.y < _loc8_.y)
               {
                  _loc18_.push(new TopLineInfo(_loc15_.childID,_loc8_));
               }
               else if(_loc7_.y == _loc8_.y)
               {
                  _loc9_ = _loc16_.getColorIndex(param1);
                  _loc10_ = colorIdxs[_loc9_];
                  _loc19_ = getLineThickness(_loc16_,param1);
                  _loc11_ = this.getArrowAlpha(_loc10_,_loc19_);
                  drawLineAndArrow(param1,_loc10_,_loc7_,_loc8_,_loc19_,_loc11_);
               }
            }
            _loc14_++;
         }
         var _loc20_:Point = new Point(_loc7_.x + (_loc13_ - _loc7_.x >> 1),0);
         _loc8_ = _loc20_.clone();
         _loc17_.sortOn(FIELD_Y,Array.NUMERIC);
         _loc18_.sortOn(FIELD_Y,Array.NUMERIC | Array.DESCENDING);
         this.drawTopLinesParts(param1,_loc17_,_loc7_,_loc20_,_loc8_);
         this.drawTopLinesParts(param1,_loc18_,_loc7_,_loc20_,_loc8_);
      }
      
      private function getArrowAlpha(param1:uint, param2:uint) : Number
      {
         if(param1 == ACTION_LINE_COLOR)
         {
            return 1;
         }
         return this.getArrowAlphaByThickness(param2);
      }
      
      override protected function getArrowAlphaByThickness(param1:int) : Number
      {
         if(param1 == UNLOCKED_LINE_THICKNESS)
         {
            return ARROW_OPENED_ALPHA;
         }
         return ARROW_LOCKED_ALPHA;
      }
      
      public function hide() : void
      {
         if(this._tween != null)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
         alpha = 0;
      }
      
      public function show() : void
      {
         this._tween = new Tween(SHOW_TWEEN_TIME,this._tweenWrapper,{"alpha":1},{
            "paused":false,
            "ease":Strong.easeIn
         });
      }
      
      private function drawTopLinesParts(param1:IRenderer, param2:Array, param3:Point, param4:Point, param5:Point) : void
      {
         var _loc6_:int = 0;
         var _loc8_:TopLineInfo = null;
         var _loc9_:IRenderer = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         var _loc7_:int = param2.length;
         var _loc12_:uint = ColorIndex.DEFAULT;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = param2[_loc6_];
            _loc9_ = container.getNodeByID(_loc8_.id);
            _loc10_ = _loc9_.getColorIndex(param1);
            _loc12_ = Math.min(_loc12_,_loc10_);
            _loc11_ = colorIdxs[_loc10_];
            _loc14_ = getLineThickness(_loc9_,param1);
            _loc13_ = this.getArrowAlpha(_loc11_,_loc14_);
            param4.y = _loc6_ == _loc7_ - 1 ? Number(param3.y) : Number(param2[_loc6_ + 1].point.y);
            param5.y = _loc8_.point.y;
            drawLineAndArrow(param1,_loc11_,param5,_loc8_.point,_loc14_,_loc13_);
            drawLine(param1,_loc11_,param4,param5,_loc14_,_loc13_);
            _loc6_++;
         }
      }
      
      private function addParentID(param1:IRenderer, param2:IRenderer) : void
      {
         var _loc3_:uint = param2.getID();
         if(this._parentIDs[_loc3_] == undefined)
         {
            this._parentIDs[_loc3_] = [];
         }
         var _loc4_:Array = this._parentIDs[_loc3_];
         _loc3_ = param1.getID();
         if(_loc4_.indexOf(_loc3_) == -1)
         {
            _loc4_.push(_loc3_);
         }
      }
      
      private function drawSingleLine(param1:IRenderer, param2:Array, param3:Object, param4:Boolean) : void
      {
         var _loc13_:Point = null;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc5_:IRenderer = container.getNodeByID(param3.childID);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Array = param3.inPin;
         var _loc7_:Array = param3.viaPins;
         var _loc8_:uint = getLineThickness(_loc5_,param1);
         var _loc9_:uint = _loc5_.getColorIndex(param1);
         var _loc10_:uint = colorIdxs[_loc9_];
         var _loc11_:Number = this.getArrowAlpha(_loc10_,_loc8_);
         var _loc12_:Point = new Point(param2[0],param2[1]);
         var _loc14_:int = _loc7_.length;
         if(_loc14_ > 0)
         {
            _loc16_ = 0;
            while(_loc16_ < _loc14_)
            {
               _loc15_ = _loc7_[_loc16_];
               _loc13_ = new Point(_loc15_[0],_loc15_[1]);
               drawLine(param1,_loc10_,_loc12_,_loc13_,_loc8_,_loc11_);
               _loc12_ = _loc13_;
               _loc16_++;
            }
            _loc13_ = new Point(_loc6_[0],_loc6_[1]);
            drawLineAndArrow(param1,_loc10_,_loc12_,_loc13_,_loc8_,_loc11_);
         }
         else
         {
            _loc13_ = new Point(_loc6_[0],_loc6_[1]);
            drawLineAndArrow(param1,_loc10_,_loc12_,_loc13_,_loc8_,_loc11_);
         }
         if(!param4)
         {
            this.addParentID(param1,_loc5_);
         }
      }
      
      private function drawLineRMSet(param1:IRenderer, param2:Object, param3:Boolean) : void
      {
         var _loc8_:Point = null;
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:IRenderer = null;
         var _loc20_:uint = 0;
         var _loc21_:Point = null;
         var _loc22_:uint = 0;
         var _loc23_:RSetLineInfo = null;
         var _loc4_:Array = param2.outPin;
         var _loc5_:Array = param2.inPins;
         var _loc6_:int = _loc5_.length;
         if(_loc6_ < 2)
         {
            if(_loc6_ == 1)
            {
               this.drawSingleLine(param1,_loc4_,_loc5_[0],param3);
            }
            return;
         }
         var _loc7_:Point = new Point(_loc4_[0],_loc4_[1]);
         var _loc13_:int = int.MAX_VALUE;
         var _loc14_:Vector.<RSetLineInfo> = new Vector.<RSetLineInfo>();
         var _loc15_:int = DEFAULT_LINE_THICKNESS;
         var _loc16_:uint = ColorIndex.DEFAULT;
         _loc11_ = 0;
         while(_loc11_ < _loc6_)
         {
            _loc9_ = _loc5_[_loc11_];
            _loc12_ = container.getNodeByID(_loc9_.childID);
            if(_loc12_)
            {
               _loc8_ = new Point(_loc9_.inPin[0],_loc9_.inPin[1]);
               _loc13_ = Math.min(_loc13_,_loc8_.x);
               _loc15_ = Math.max(getLineThickness(_loc12_,param1),_loc15_);
               _loc16_ = Math.max(_loc16_,_loc12_.getColorIndex(param1));
               _loc14_.push(new RSetLineInfo(_loc11_,_loc8_,_loc7_.y == _loc8_.y));
            }
            _loc11_++;
         }
         var _loc17_:Point = new Point(_loc7_.x + (_loc13_ - _loc7_.x >> 1),_loc7_.y);
         var _loc18_:uint = colorIdxs[_loc16_];
         var _loc19_:Number = this.getArrowAlpha(_loc18_,_loc15_);
         drawLine(param1,_loc18_,_loc7_,_loc17_,_loc15_,_loc19_);
         for each(_loc23_ in _loc14_)
         {
            _loc9_ = _loc5_[_loc23_.idx];
            _loc12_ = container.getNodeByID(_loc9_.childID);
            _loc20_ = getLineThickness(_loc12_,param1);
            _loc10_ = _loc12_.getColorIndex(param1);
            _loc22_ = colorIdxs[_loc10_];
            _loc19_ = this.getArrowAlpha(_loc22_,_loc20_);
            if(_loc23_.drawArrow)
            {
               drawLineAndArrow(param1,_loc22_,_loc17_,_loc23_.endPin,_loc20_,_loc19_);
            }
            else
            {
               _loc8_ = _loc23_.endPin;
               _loc21_ = new Point(_loc17_.x,_loc8_.y);
               drawLine(param1,_loc22_,_loc17_,_loc21_,_loc20_,_loc19_);
               drawLineAndArrow(param1,_loc22_,_loc21_,_loc8_,_loc20_,_loc19_);
            }
            if(!param3)
            {
               this.addParentID(param1,_loc12_);
            }
         }
      }
      
      private function drawLineTMSet(param1:IRenderer, param2:Object, param3:Boolean) : void
      {
         var _loc4_:Array = param2.outPin;
         var _loc5_:Array = param2.inPins;
         var _loc6_:Object = _loc5_[0];
         var _loc7_:IRenderer = container.getNodeByID(_loc6_.childID);
         if(_loc7_ != null && _loc7_.bottomArrowOffset > 0)
         {
            _loc6_ = {
               "childID":_loc6_.childID,
               "inPin":[_loc6_.inPin[0],_loc6_.inPin[1] + _loc7_.bottomArrowOffset],
               "viaPins":_loc6_.viaPins
            };
         }
         this.drawSingleLine(param1,_loc4_,_loc6_,param3);
         if(_loc5_.length > 1)
         {
            DebugUtils.LOG_WARNING(LOG_MSG_DRAW_TM_SET_WARNING);
         }
      }
      
      private function drawLineBMSet(param1:IRenderer, param2:Object, param3:Boolean) : void
      {
         var _loc4_:Array = param2.outPin;
         var _loc5_:Array = param2.inPins;
         if(param1.bottomArrowOffset > 0)
         {
            _loc4_ = [_loc4_[0],_loc4_[1] + param1.bottomArrowOffset];
         }
         this.drawSingleLine(param1,_loc4_,_loc5_[0],param3);
         if(_loc5_.length > 1)
         {
            DebugUtils.LOG_WARNING(LOG_MSG_DRAW_BM_SET_WARNING);
         }
      }
      
      private function drawLineRightSet(param1:String, param2:IRenderer, param3:Object, param4:Boolean) : void
      {
         var _loc5_:Array = param3.outPin;
         var _loc6_:Array = param3.inPins;
         var _loc7_:Object = _loc6_[0];
         this.drawSingleLine(param2,_loc5_,_loc7_,param4);
         if(_loc6_.length > 1)
         {
            DebugUtils.LOG_WARNING(LOG_MSG_DRAW_RIGHT_SET_WARNING + param1);
         }
      }
   }
}

import flash.geom.Point;

class TopLineInfo
{
    
   
   public var id:int;
   
   public var point:Point;
   
   function TopLineInfo(param1:int, param2:Point = null)
   {
      super();
      this.id = param1;
      this.point = param2;
   }
   
   public function get y() : int
   {
      return this.point.y;
   }
   
   public function toString() : String
   {
      return "[TopLineInfo] id = " + this.id + ", point = " + this.point.toString();
   }
}

import flash.geom.Point;

class RSetLineInfo
{
    
   
   public var endPin:Point;
   
   public var drawArrow:Boolean;
   
   public var idx:int;
   
   function RSetLineInfo(param1:int, param2:Point, param3:Boolean = false)
   {
      super();
      this.idx = param1;
      this.endPin = param2;
      this.drawArrow = param3;
   }
}
