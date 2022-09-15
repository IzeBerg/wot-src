package net.wg.gui.components.common.containers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.containers.GroupLayout;
   
   public class EqualWidthHorizontalLayout extends GroupLayout
   {
       
      
      private var _availableSize:int = 0;
      
      private var _paddingGap:Boolean = false;
      
      public function EqualWidthHorizontalLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = 0;
         var _loc4_:int = !!this._paddingGap ? int(_loc2_ + 1) : int(_loc2_ - 1);
         var _loc5_:uint = (this._availableSize - gap * _loc4_) / _loc2_;
         var _loc6_:int = !!this._paddingGap ? int(gap) : int(0);
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_)
         {
            _loc1_ = _target.getChildAt(_loc7_);
            _loc1_.x = _loc6_;
            _loc1_.width = _loc5_;
            _loc6_ += _loc1_.width + gap;
            _loc3_ = Math.max(_loc3_,_loc1_.height);
            _loc7_++;
         }
         if(!this._paddingGap)
         {
            _loc6_ -= gap;
         }
         return new Point(_loc6_,_loc3_);
      }
      
      public function get availableSize() : int
      {
         return this._availableSize;
      }
      
      public function set availableSize(param1:int) : void
      {
         this._availableSize = param1;
      }
      
      public function get paddingGap() : Boolean
      {
         return this._paddingGap;
      }
      
      public function set paddingGap(param1:Boolean) : void
      {
         this._paddingGap = param1;
      }
   }
}
