package net.wg.gui.components.popovers
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.infrastructure.base.BaseLayout;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.utils.Padding;
   
   public class PopoverInternalLayout extends BaseLayout
   {
      
      public static const INTERNAL_PADDING:int = 59;
       
      
      private var _buttonPadding:Point;
      
      private var _contentPadding:PopoverContentPadding;
      
      protected const _bgInternalPadding:Padding = new Padding(INTERNAL_PADDING);
      
      public function PopoverInternalLayout()
      {
         this._buttonPadding = new Point(5,5);
         super();
         this._contentPadding = new PopoverContentPadding();
         this._contentPadding.top = 0;
         this._contentPadding.right = 0;
         this._contentPadding.bottom = 0;
         this._contentPadding.left = 0;
         this._contentPadding.titleTop = 13;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc2_:IUIComponentEx = null;
         var _loc3_:TextField = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:PopOver = PopOver(target);
         if(_loc1_)
         {
            _loc2_ = _loc1_.wrapperContent;
            _loc3_ = _loc1_.titleTextField;
            if(_loc1_.title != "")
            {
               _loc4_ = _loc3_.y + _loc3_.height + this._contentPadding.titleTop;
            }
            else
            {
               _loc4_ = this._bgInternalPadding.top + this._contentPadding.top;
            }
            _loc2_.x = this._contentPadding.left + this._bgInternalPadding.left;
            _loc2_.y = _loc4_;
            _loc5_ = _loc1_.background;
            _loc5_.width = this._bgInternalPadding.left + this._contentPadding.left + _loc2_.width + this._contentPadding.right + this._bgInternalPadding.right;
            _loc5_.height = _loc4_ + _loc2_.height + this._contentPadding.bottom + this._bgInternalPadding.bottom;
            _loc6_ = _loc1_.hitMc;
            _loc6_.x = this._bgInternalPadding.left;
            _loc6_.y = this._bgInternalPadding.top;
            _loc6_.width = _loc5_.width - this._bgInternalPadding.left - this._bgInternalPadding.right;
            _loc6_.height = _loc5_.height - this._bgInternalPadding.top - this._bgInternalPadding.bottom;
            if(_loc1_.isCloseBtnVisible)
            {
               _loc1_.closeBtn.x = _loc6_.x + _loc6_.width - _loc1_.closeBtn.width - this._buttonPadding.x;
               if(_loc1_.title != "")
               {
                  _loc1_.closeBtn.y = _loc6_.y + this._buttonPadding.y;
               }
               else
               {
                  _loc1_.closeBtn.y = _loc4_ + this._buttonPadding.y;
               }
            }
            _loc7_ = _loc1_.arrowPosition;
            _loc8_ = _loc1_.arrowDirection;
            this.updateArrowPosition(_loc1_,_loc8_,_loc7_);
         }
         return null;
      }
      
      protected function updateArrowPosition(param1:PopOver, param2:int, param3:int) : void
      {
         if(param2 == PopOverConst.ARROW_LEFT)
         {
            param1.arrowLeft.y = param3 + this._bgInternalPadding.top;
         }
         else if(param2 == PopOverConst.ARROW_RIGHT)
         {
            param1.arrowRight.y = param3 + this._bgInternalPadding.top;
            param1.arrowRight.x = this._bgInternalPadding.left + param1.width;
         }
         else if(param2 == PopOverConst.ARROW_TOP)
         {
            param1.arrowTop.x = param3 + this._bgInternalPadding.left;
         }
         else if(param2 == PopOverConst.ARROW_BOTTOM)
         {
            param1.arrowBottom.x = param3 + this._bgInternalPadding.left;
            param1.arrowBottom.y = this._bgInternalPadding.top + param1.height;
         }
      }
      
      public function get contentPadding() : PopoverContentPadding
      {
         return this._contentPadding;
      }
      
      public function set contentPadding(param1:PopoverContentPadding) : void
      {
         this._contentPadding = param1;
      }
      
      public function get bgInternalPadding() : Padding
      {
         return this._bgInternalPadding;
      }
      
      public function get buttonPadding() : Point
      {
         return this._buttonPadding;
      }
      
      public function set buttonPadding(param1:Point) : void
      {
         this._buttonPadding = param1;
      }
   }
}
