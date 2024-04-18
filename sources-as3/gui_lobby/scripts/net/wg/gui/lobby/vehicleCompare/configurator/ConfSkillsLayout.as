package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.geom.Point;
   import net.wg.gui.components.common.containers.TiledLayout;
   
   public class ConfSkillsLayout extends TiledLayout
   {
      
      private static const COMMON_ROLE:String = "common";
      
      private static const WIDTH:int = 97;
      
      private static const HEIGHT:int = 90;
      
      private static const COLUMN:int = 6;
      
      private static const GAP:int = 8;
       
      
      public function ConfSkillsLayout()
      {
         super(WIDTH,HEIGHT,COLUMN);
         gap = GAP;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc2_:VehConfCrewSkillSlot = null;
         var _loc5_:int = 0;
         var _loc1_:int = _target.numChildren;
         if(_loc1_ <= 0)
         {
            return new Point();
         }
         var _loc3_:int = rendererWidth + gap;
         var _loc4_:int = rendererHeight + gap;
         _loc5_ = 0;
         var _loc6_:int = -1;
         var _loc7_:String = COMMON_ROLE;
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_)
         {
            _loc2_ = VehConfCrewSkillSlot(_target.getChildAt(_loc8_));
            if(_loc6_ >= columns - 1 || _loc7_ != _loc2_.skillRole)
            {
               _loc6_ = 0;
               _loc5_++;
               _loc7_ = _loc2_.skillRole;
            }
            else
            {
               _loc6_++;
            }
            _loc2_.x = _loc6_ * _loc3_;
            _loc2_.y = _loc5_ * _loc4_;
            _loc8_++;
         }
         return new Point(_loc3_ * Math.min(columns,_loc1_) - gap,(_loc5_ + 1) * _loc4_ - gap);
      }
   }
}
