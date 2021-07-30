package net.wg.gui.components.common.containers
{
   import flash.geom.Point;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TiledLayout extends GroupLayout
   {
      
      public static const DEFAULT_COLUMNS_COUNT:uint = 8;
       
      
      private var _rendererWidth:int;
      
      private var _rendererHeight:int;
      
      private var _columns:uint;
      
      private var _alignment:String;
      
      public function TiledLayout(param1:int, param2:int, param3:uint = 8, param4:String = "")
      {
         super();
         this._rendererWidth = param1;
         this._rendererHeight = param2;
         this._columns = param3;
         this._alignment = param4 == "" ? TEXT_ALIGN.LEFT : param4;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:UIComponentEx = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         if(_target.numChildren > 0)
         {
            _loc2_ = _target.numChildren;
            _loc3_ = gap;
            _loc4_ = this._rendererWidth + _loc3_;
            _loc5_ = this._rendererHeight + _loc3_;
            _loc6_ = _loc4_ * this.columns;
            _loc7_ = _target.numChildren % this.columns;
            _loc8_ = _target.numChildren - _loc7_;
            _loc9_ = 0;
            if(this._alignment == TEXT_ALIGN.CENTER)
            {
               _loc9_ = _loc6_ - _loc4_ * _loc7_ >> 1;
            }
            else if(this._alignment == TEXT_ALIGN.RIGHT)
            {
               _loc9_ = _loc6_ - _loc4_ * _loc7_;
            }
            _loc10_ = 0;
            while(_loc10_ < _loc2_)
            {
               _loc1_ = UIComponentEx(_target.getChildAt(_loc10_));
               _loc1_.setSize(this._rendererWidth,this._rendererHeight);
               _loc1_.y = int(_loc10_ / this._columns) * _loc5_;
               _loc1_.x = _loc10_ % this._columns * _loc4_;
               if(_loc10_ >= _loc8_)
               {
                  _loc1_.x += _loc9_;
               }
               _loc10_++;
            }
            return new Point(_loc4_ * Math.min(this._columns,_loc2_) - _loc3_,Math.ceil(_loc2_ / this._columns) * _loc5_ - _loc3_);
         }
         return new Point();
      }
      
      public function get rendererWidth() : int
      {
         return this._rendererWidth;
      }
      
      public function set rendererWidth(param1:int) : void
      {
         this._rendererWidth = param1;
      }
      
      public function get rendererHeight() : int
      {
         return this._rendererHeight;
      }
      
      public function set rendererHeight(param1:int) : void
      {
         this._rendererHeight = param1;
      }
      
      public function get columns() : uint
      {
         return this._columns;
      }
      
      public function set columns(param1:uint) : void
      {
         this._columns = param1;
         this.invokeLayout();
      }
   }
}
