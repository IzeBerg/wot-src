package net.wg.gui.components.common.containers
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AutoResizableTiledLayout extends TiledLayout
   {
       
      
      private var _numElements:int = -1;
      
      public function AutoResizableTiledLayout(param1:int, param2:int, param3:uint = 8, param4:String = "left")
      {
         super(param1,param2,param3,param4);
      }
      
      override public function invokeLayout() : Object
      {
         var _loc3_:UIComponentEx = null;
         this._numElements = _target.numChildren;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._numElements)
         {
            _loc3_ = UIComponentEx(_target.getChildAt(_loc4_));
            _loc1_ = Math.max(_loc1_,_loc3_.actualWidth);
            _loc2_ = Math.max(_loc2_,_loc3_.actualHeight);
            _loc4_++;
         }
         rendererWidth = _loc1_;
         rendererHeight = _loc2_;
         return super.invokeLayout();
      }
   }
}
