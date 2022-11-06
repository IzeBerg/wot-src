package net.wg.gui.components.containers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import scaleform.clik.core.UIComponent;
   
   public class HorizontalGroupLayout extends GroupLayout
   {
       
      
      private var _usePreLayoutValidation:Boolean;
      
      public function HorizontalGroupLayout(param1:int = 0, param2:Boolean = true)
      {
         super();
         this.gap = param1;
         this._usePreLayoutValidation = param2;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:DisplayObject = null;
         var _loc5_:Number = NaN;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc6_:int = gap;
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_)
         {
            _loc1_ = DisplayObject(_target.getChildAt(_loc7_));
            _loc1_.x = _loc4_ | 0;
            if(this._usePreLayoutValidation)
            {
               if(_loc1_ is UIComponent)
               {
                  UIComponent(_loc1_).validateNow();
               }
            }
            _loc4_ += _loc1_.width + _loc6_;
            _loc5_ = _loc1_.height;
            if(_loc3_ < _loc5_)
            {
               _loc3_ = _loc5_;
            }
            _loc7_++;
         }
         if(_loc4_ > 0)
         {
            _loc4_ -= _loc6_;
         }
         return new Point(_loc4_,_loc3_);
      }
   }
}
