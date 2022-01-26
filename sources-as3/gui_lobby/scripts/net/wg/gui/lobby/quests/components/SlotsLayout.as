package net.wg.gui.lobby.quests.components
{
   import flash.geom.Point;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public class SlotsLayout extends GroupLayout
   {
       
      
      public function SlotsLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:IUIComponentEx = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = gap;
         var _loc4_:Number = _target.width;
         var _loc5_:Number = _loc4_ / _loc2_ - _loc3_;
         var _loc6_:int = _loc5_ + _loc3_;
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_)
         {
            _loc1_ = IUIComponentEx(_target.getChildAt(_loc7_));
            _loc1_.x = _loc6_ * _loc7_;
            _loc1_.width = _loc5_;
            _loc7_++;
         }
         return new Point(_loc4_,_target.height);
      }
   }
}
