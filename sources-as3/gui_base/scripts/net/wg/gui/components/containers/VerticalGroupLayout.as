package net.wg.gui.components.containers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import scaleform.clik.core.UIComponent;
   
   public class VerticalGroupLayout extends GroupLayout
   {
       
      
      public function VerticalGroupLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
            _loc1_.y = _loc4_;
            if(_loc1_ is UIComponent)
            {
               UIComponent(_loc1_).validateNow();
            }
            _loc4_ += _loc1_.height + gap;
            if(_loc3_ < _loc1_.width)
            {
               _loc3_ = _loc1_.width;
            }
            _loc5_++;
         }
         if(_loc4_ > 0)
         {
            _loc4_ -= gap;
         }
         return new Point(_loc3_,_loc4_);
      }
   }
}
