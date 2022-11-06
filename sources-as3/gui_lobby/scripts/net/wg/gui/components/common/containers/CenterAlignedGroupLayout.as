package net.wg.gui.components.common.containers
{
   import flash.geom.Point;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CenterAlignedGroupLayout extends GroupLayout
   {
       
      
      private var _rendererWidth:int;
      
      private var _rendererHeight:int;
      
      public function CenterAlignedGroupLayout(param1:int, param2:int)
      {
         super();
         this._rendererWidth = param1;
         this._rendererHeight = param2;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:UIComponentEx = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(_target.numChildren > 0)
         {
            _loc1_ = UIComponentEx(_target.getChildAt(0));
            _loc2_ = _target.numChildren;
            _loc3_ = gap;
            _loc4_ = _target.width;
            _loc5_ = _loc2_ * (this._rendererWidth + _loc3_) - _loc3_;
            _loc6_ = _loc4_ - _loc5_ >> 1;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc1_ = UIComponentEx(_target.getChildAt(_loc7_));
               _loc1_.x = _loc6_;
               _loc1_.setSize(this._rendererWidth,this._rendererHeight);
               _loc6_ += this._rendererWidth + _loc3_;
               _loc7_++;
            }
            return new Point(_loc4_,_target.height);
         }
         return new Point(0,0);
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
   }
}
