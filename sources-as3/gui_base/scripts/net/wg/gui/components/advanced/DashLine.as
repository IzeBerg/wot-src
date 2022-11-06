package net.wg.gui.components.advanced
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DashLine extends UIComponentEx
   {
      
      private static const REDRAW_INV:String = "redrawInv";
       
      
      public var background:MovieClip;
      
      private var maskObj:Sprite;
      
      private var _gap:uint = 2;
      
      private var _dashLength:uint = 1;
      
      public function DashLine()
      {
         this.maskObj = new Sprite();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addChild(this.maskObj);
         this.background.mask = this.maskObj;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = width;
            invalidate(REDRAW_INV);
         }
         if(isInvalid(REDRAW_INV))
         {
            _loc1_ = this.maskObj.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0);
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc2_ < _width)
            {
               _loc4_ = _loc2_ + this._dashLength;
               if(_loc4_ <= _width)
               {
                  _loc3_ = this._dashLength;
               }
               else
               {
                  _loc3_ = _width - _loc4_;
               }
               _loc1_.drawRect(_loc2_,0,_loc3_,_height);
               _loc2_ += _loc3_ + this._gap;
            }
            _loc1_.endFill();
         }
      }
      
      override protected function onDispose() : void
      {
         this.background.mask = null;
         this.background = null;
         this.maskObj = null;
         super.onDispose();
      }
      
      [Inspectable(defaultValue="2",type="Number")]
      public function get gap() : uint
      {
         return this._gap;
      }
      
      public function set gap(param1:uint) : void
      {
         if(this._gap != param1)
         {
            this._gap = param1;
            invalidate(REDRAW_INV);
         }
      }
      
      [Inspectable(defaultValue="1",type="Number")]
      public function get dashLength() : uint
      {
         return this._dashLength;
      }
      
      public function set dashLength(param1:uint) : void
      {
         if(this._dashLength != param1)
         {
            this._dashLength = param1;
            invalidate(REDRAW_INV);
         }
      }
   }
}
