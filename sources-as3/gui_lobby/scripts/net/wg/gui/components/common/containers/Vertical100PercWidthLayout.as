package net.wg.gui.components.common.containers
{
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import scaleform.clik.core.UIComponent;
   
   public class Vertical100PercWidthLayout extends VerticalGroupLayout
   {
       
      
      public function Vertical100PercWidthLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:UIComponent = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = UIComponent(_target.getChildAt(_loc3_));
            _loc1_.width = _target.width;
            _loc1_.validateNow();
            _loc3_++;
         }
         return super.invokeLayout();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
