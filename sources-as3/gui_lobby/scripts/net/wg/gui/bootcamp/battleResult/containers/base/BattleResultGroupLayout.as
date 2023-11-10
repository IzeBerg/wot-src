package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.containers.GroupLayout;
   
   public class BattleResultGroupLayout extends GroupLayout
   {
       
      
      protected var imageSize:int = 0;
      
      public function BattleResultGroupLayout(param1:int = 0, param2:int = 0)
      {
         super();
         this.imageSize = param1;
         this.gap = param2;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = gap;
         var _loc4_:int = this.startPos();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
            _loc1_.x = _loc4_;
            _loc4_ += this.imageSize + _loc3_;
            _loc5_++;
         }
         _loc4_ -= this.shift();
         return new Point(_loc4_,this.rendererHeight());
      }
      
      protected function shift() : int
      {
         return (this.imageSize >> 1) + gap;
      }
      
      protected function startPos() : int
      {
         return this.imageSize >> 1;
      }
      
      protected function rendererHeight() : int
      {
         return 0;
      }
   }
}
