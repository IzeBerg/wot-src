package net.wg.gui.components.common.containers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.containers.GroupLayout;
   import scaleform.clik.core.UIComponent;
   
   public class EqualGapsHorizontalLayout extends GroupLayout
   {
       
      
      private var _availableSize:int = 0;
      
      private var _paddingGap:Boolean = false;
      
      public function EqualGapsHorizontalLayout()
      {
         super();
      }
      
      override public function invokeLayout() : Object
      {
         var _loc1_:DisplayObject = null;
         var _loc7_:int = 0;
         var _loc10_:UIComponent = null;
         var _loc2_:int = _target.numChildren;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _target.getChildAt(_loc5_);
            if(_loc1_.visible)
            {
               _loc10_ = UIComponent(_loc1_);
               if(_loc10_ != null)
               {
                  _loc10_.validateNow();
               }
               _loc3_++;
               _loc4_ += _loc1_.width;
            }
            _loc5_++;
         }
         var _loc6_:int = !!this._paddingGap ? int(_loc3_ + 1) : int(_loc3_ - 1);
         _loc7_ = (this._availableSize - _loc4_) / _loc6_;
         var _loc8_:Boolean = _loc7_ >= 0 ? Boolean(this._paddingGap) : Boolean(false);
         var _loc9_:int = !!_loc8_ ? int(_loc7_) : int(0);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _target.getChildAt(_loc5_);
            if(_loc1_.visible)
            {
               _loc1_.x = _loc9_;
               _loc9_ += _loc1_.width + _loc7_ | 0;
            }
            _loc5_++;
         }
         if(!_loc8_)
         {
            _loc9_ -= _loc7_;
         }
         return new Point(_loc9_,0);
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
