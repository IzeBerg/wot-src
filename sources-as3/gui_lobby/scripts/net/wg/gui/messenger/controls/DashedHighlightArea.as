package net.wg.gui.messenger.controls
{
   import flash.display.Graphics;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DashedHighlightArea extends UIComponentEx
   {
      
      private static const REDRAW_LINE_INV:String = "redrawLineInv";
      
      private static const REDRAW_BG_INV:String = "redrawBgInv";
       
      
      private var _color:uint = 0;
      
      private var _dashLength:int = 6;
      
      private var _gap:int = 3;
      
      private var _lineThickness:int = 1;
      
      private var _bgColor:uint = 16777215;
      
      private var _bgAlpha:Number = 0;
      
      public function DashedHighlightArea()
      {
         super();
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color != param1)
         {
            this._color = param1;
            invalidate(REDRAW_LINE_INV);
         }
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      public function set gap(param1:int) : void
      {
         if(this._gap != param1)
         {
            this._gap = param1;
            invalidate(REDRAW_LINE_INV);
         }
      }
      
      public function get dashLength() : int
      {
         return this._dashLength;
      }
      
      public function set dashLength(param1:int) : void
      {
         if(this._dashLength != param1)
         {
            this._dashLength = param1;
            invalidate(REDRAW_LINE_INV);
         }
      }
      
      public function get bgColor() : uint
      {
         return this._bgColor;
      }
      
      public function set bgColor(param1:uint) : void
      {
         if(this._bgColor != param1)
         {
            this._bgColor = param1;
            invalidate(REDRAW_BG_INV);
         }
      }
      
      public function get bgAlpha() : Number
      {
         return this._bgAlpha;
      }
      
      public function set bgAlpha(param1:Number) : void
      {
         if(this._bgAlpha != param1)
         {
            this._bgAlpha = param1;
            invalidate(REDRAW_BG_INV);
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(_width != param1 || _height != param2)
         {
            super.setSize(param1,param2);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            invalidate(REDRAW_LINE_INV);
            invalidate(REDRAW_BG_INV);
         }
         if(isInvalid(REDRAW_BG_INV))
         {
            _loc1_ = graphics;
            _loc1_.clear();
            _loc2_ = 1;
            _loc1_.beginFill(this._bgColor,this._bgAlpha);
            _loc1_.drawRect(this._lineThickness + _loc2_,this._lineThickness + _loc2_,_width - 2 * this._lineThickness - 2 * _loc2_,_height - 2 * this._lineThickness - 2 * _loc2_);
            _loc1_.endFill();
         }
         if(isInvalid(REDRAW_LINE_INV))
         {
            _loc1_ = graphics;
            _loc1_.lineStyle(this._lineThickness,this._color);
            _loc1_.moveTo(0,0);
            _loc3_ = int(this._dashLength / 2);
            _loc3_ = _loc3_ == 0 ? Number(1) : Number(_loc3_);
            _loc1_.lineTo(_loc3_,0);
            _loc4_ = _width - this._lineThickness;
            _loc5_ = _height - this._lineThickness;
            _loc1_.moveTo(_loc4_ - _loc3_,0);
            _loc1_.lineTo(_loc4_,0);
            _loc1_.lineTo(_loc4_,_loc3_);
            _loc1_.moveTo(_loc4_,_loc5_ - _loc3_);
            _loc1_.lineTo(_loc4_,_loc5_);
            _loc1_.lineTo(_loc4_ - _loc3_,_loc5_);
            _loc1_.moveTo(_loc3_ - this._lineThickness,_loc5_);
            _loc1_.lineTo(0,_loc5_);
            _loc1_.lineTo(0,_loc5_ - _loc3_);
            _loc1_.moveTo(0,_loc3_);
            _loc1_.lineTo(0,0);
            _loc6_ = _loc4_ - this._dashLength;
            _loc7_ = _loc5_ - this._dashLength;
            if(_loc6_ <= 0 || _loc7_ <= 0)
            {
               return;
            }
            _loc8_ = this._dashLength + this._gap;
            _loc9_ = _loc6_ / _loc8_;
            _loc10_ = _loc7_ / _loc8_;
            _loc1_.moveTo(_loc3_,0);
            _loc11_ = _loc3_;
            _loc12_ = 0;
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc11_ += this._gap;
               _loc1_.moveTo(_loc11_,0);
               _loc11_ += this._dashLength;
               _loc1_.lineTo(_loc11_,0);
               _loc12_++;
            }
            _loc13_ = _loc6_ - _loc9_ * _loc8_ - this._gap;
            _loc14_ = _loc7_ - _loc10_ * _loc8_ - this._gap;
            if(_loc13_ > 0)
            {
               _loc11_ += this._gap;
               _loc1_.moveTo(_loc11_,0);
               _loc11_ += _loc13_;
               _loc1_.lineTo(_loc11_,0);
            }
            _loc11_ = _loc4_;
            _loc15_ = _loc3_;
            _loc1_.moveTo(_loc11_,_loc15_);
            _loc12_ = 0;
            while(_loc12_ < _loc10_)
            {
               _loc15_ += this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc15_ += this._dashLength;
               _loc1_.lineTo(_loc11_,_loc15_);
               _loc12_++;
            }
            if(_loc14_ > 0)
            {
               _loc15_ += this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc15_ += _loc14_;
               _loc1_.lineTo(_loc11_,_loc15_);
            }
            _loc11_ = _loc4_ - _loc3_;
            _loc15_ = _loc5_;
            _loc1_.moveTo(_loc11_,_loc15_);
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc11_ -= this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc11_ -= this._dashLength;
               _loc1_.lineTo(_loc11_,_loc15_);
               _loc12_++;
            }
            if(_loc13_ > 0)
            {
               _loc11_ -= this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc11_ -= _loc13_;
               _loc1_.lineTo(_loc11_,_loc15_);
            }
            _loc11_ = 0;
            _loc1_.moveTo(_loc11_,_loc15_);
            _loc12_ = 0;
            while(_loc12_ < _loc10_)
            {
               _loc15_ -= this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc15_ -= this._dashLength;
               _loc1_.lineTo(_loc11_,_loc15_);
               _loc12_++;
            }
            if(_loc14_ > 0)
            {
               _loc15_ -= this._gap;
               _loc1_.moveTo(_loc11_,_loc15_);
               _loc15_ -= _loc14_;
               _loc1_.lineTo(_loc11_,_loc15_);
            }
            _loc1_.moveTo(0,0);
         }
      }
      
      public function get lineThickness() : int
      {
         return this._lineThickness;
      }
      
      public function set lineThickness(param1:int) : void
      {
         if(this._lineThickness != param1)
         {
            this._lineThickness = param1;
            invalidate(REDRAW_BG_INV);
            invalidate(REDRAW_LINE_INV);
         }
      }
   }
}
