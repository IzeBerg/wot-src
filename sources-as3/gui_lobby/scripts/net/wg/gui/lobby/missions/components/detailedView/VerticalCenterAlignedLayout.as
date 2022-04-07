package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   
   public class VerticalCenterAlignedLayout extends VerticalGroupLayout
   {
       
      
      public function VerticalCenterAlignedLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Point = Point(super.invokeLayout());
         var _loc3_:int = _target.numChildren;
         var _loc4_:int = _loc1_.x;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = DisplayObject(_target.getChildAt(_loc5_));
            _loc2_.x = _target.width - _loc4_ >> 1;
            _loc5_++;
         }
         return _loc1_;
      }
   }
}
