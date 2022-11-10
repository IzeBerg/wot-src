package net.wg.gui.components.popovers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.utilData.TwoDimensionalPadding;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import scaleform.clik.utils.Padding;
   
   public class SmartPopOverExternalLayout extends PopoverInternalLayout
   {
      
      private static var _checkedPopoverPos:Point;
      
      private static var _directionsAbility:Vector.<Boolean> = new Vector.<Boolean>(4);
      
      private static const BORDER_POPOVER_OFFSET:int = 150;
       
      
      private var _stageDimensions:Point;
      
      private var _positionKeyPoint:Point;
      
      private var _positionKeyPointPadding:TwoDimensionalPadding;
      
      private var _preferredLayout:int = -1;
      
      private var _changeableArrowDirection:Boolean = false;
      
      public function SmartPopOverExternalLayout()
      {
         this._positionKeyPointPadding = new TwoDimensionalPadding();
         super();
      }
      
      private static function updateArrowDirection(param1:SmartPopOverLayoutInfo, param2:Point, param3:Point, param4:Point, param5:Padding = null) : SmartPopOverLayoutInfo
      {
         if(param5 == null)
         {
            param5 = new Padding(PopoverInternalLayout.INTERNAL_PADDING);
         }
         _checkedPopoverPos = new Point(Math.round(param4.x - param1.popupPaddingLeft - param5.left),Math.round(param4.y - param1.popupPaddingTop - param5.top));
         _directionsAbility[PopOverConst.ARROW_TOP] = param3.y > _checkedPopoverPos.y + param5.top + param2.y;
         _directionsAbility[PopOverConst.ARROW_RIGHT] = _checkedPopoverPos.x > 0;
         _directionsAbility[PopOverConst.ARROW_BOTTOM] = _checkedPopoverPos.y > 0;
         _directionsAbility[PopOverConst.ARROW_LEFT] = param3.x > _checkedPopoverPos.x + param5.left + param2.x;
         var _loc6_:int = param1.arrowDirection;
         if(!_directionsAbility[_loc6_])
         {
            switch(_loc6_)
            {
               case PopOverConst.ARROW_TOP:
               case PopOverConst.ARROW_BOTTOM:
                  if(_loc6_ == PopOverConst.ARROW_TOP && param4.y > param3.y - BORDER_POPOVER_OFFSET && _directionsAbility[PopOverConst.ARROW_BOTTOM])
                  {
                     _loc6_ = PopOverConst.ARROW_BOTTOM;
                  }
                  else if(_loc6_ == PopOverConst.ARROW_BOTTOM && param4.y < BORDER_POPOVER_OFFSET && _directionsAbility[PopOverConst.ARROW_TOP])
                  {
                     _loc6_ = PopOverConst.ARROW_TOP;
                  }
                  else
                  {
                     _loc6_ = _checkedPopoverPos.x > param3.x >> 1 ? int(PopOverConst.ARROW_RIGHT) : int(PopOverConst.ARROW_LEFT);
                  }
                  break;
               case PopOverConst.ARROW_LEFT:
               case PopOverConst.ARROW_RIGHT:
                  if(_loc6_ == PopOverConst.ARROW_LEFT && param4.x > param3.x - BORDER_POPOVER_OFFSET && _directionsAbility[PopOverConst.ARROW_RIGHT])
                  {
                     _loc6_ = PopOverConst.ARROW_RIGHT;
                  }
                  else if(_loc6_ == PopOverConst.ARROW_RIGHT && param4.x < BORDER_POPOVER_OFFSET && _directionsAbility[PopOverConst.ARROW_LEFT])
                  {
                     _loc6_ = PopOverConst.ARROW_LEFT;
                  }
                  else
                  {
                     _loc6_ = _checkedPopoverPos.y > param3.y >> 1 ? int(PopOverConst.ARROW_BOTTOM) : int(PopOverConst.ARROW_TOP);
                  }
            }
         }
         if(_loc6_ != param1.arrowDirection)
         {
            param1.arrowDirection = _loc6_;
            return param1;
         }
         return null;
      }
      
      public static function getLayoutOptions(param1:Point, param2:Vector.<Point>, param3:Point, param4:Point, param5:Rectangle, param6:TwoDimensionalPadding = null, param7:int = -1, param8:Boolean = false, param9:Padding = null) : SmartPopOverLayoutInfo
      {
         var _loc10_:SmartPopOverLayoutInfo = null;
         var _loc12_:int = 0;
         var _loc13_:Point = null;
         var _loc14_:int = 0;
         var _loc15_:Point = null;
         var _loc16_:Number = NaN;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Point = null;
         var _loc23_:Number = NaN;
         if(param6 == null)
         {
            param6 = new TwoDimensionalPadding();
         }
         var _loc11_:SmartPopOverLayoutInfo = null;
         while(true)
         {
            if(_loc11_ != null)
            {
               param7 = _loc11_.arrowDirection;
            }
            _loc12_ = PopOverConst.ARROW_LEFT;
            _loc13_ = param2[PopOverConst.ARROW_LEFT];
            _loc14_ = -Math.round(_loc13_.x + param6.right.x);
            _loc15_ = param6.right;
            if(param7 == PopOverConst.ARROW_RIGHT && param4.x > param1.x + param2[PopOverConst.ARROW_RIGHT].x - param6.left.x || param1.x + _loc13_.x + param4.x + param6.right.x > param3.x)
            {
               _loc12_ = PopOverConst.ARROW_RIGHT;
               _loc13_ = param2[PopOverConst.ARROW_RIGHT];
               _loc14_ = Math.round(param1.x + _loc13_.x - param6.left.x);
               _loc15_ = param6.left;
            }
            _loc16_ = param5.height - _loc13_.y;
            _loc17_ = param5.y + _loc13_.y / 2;
            _loc18_ = param1.y - (param5.y + param5.height) + _loc13_.y / 2;
            _loc19_ = param4.y - _loc17_;
            _loc19_ = _loc19_ > 0 ? int(_loc19_) : int(0);
            _loc20_ = Math.round((_loc19_ + _loc15_.y) / (param3.y - _loc17_ - _loc18_) * _loc16_ + _loc13_.y / 2) + param5.y;
            _loc21_ = _loc20_ - _loc15_.y;
            _loc10_ = new SmartPopOverLayoutInfo(_loc12_,_loc20_,_loc14_,_loc21_);
            if(param7 == PopOverConst.ARROW_LEFT || param7 == PopOverConst.ARROW_RIGHT)
            {
               if(param8)
               {
                  _loc11_ = updateArrowDirection(_loc10_,param1,param3,param4,param9);
               }
               if(_loc11_ == null)
               {
                  break;
               }
            }
            else
            {
               if(param7 == PopOverConst.ARROW_TOP || param4.y <= _loc20_ - _loc15_.y)
               {
                  _loc13_ = param2[PopOverConst.ARROW_TOP];
                  _loc12_ = PopOverConst.ARROW_TOP;
                  _loc21_ = -Math.round(_loc13_.y + param6.bottom.y);
                  _loc22_ = param6.bottom;
               }
               else if(param7 == PopOverConst.ARROW_BOTTOM || param3.y - param4.y - _loc15_.y <= _loc18_)
               {
                  _loc13_ = param2[PopOverConst.ARROW_BOTTOM];
                  _loc12_ = PopOverConst.ARROW_BOTTOM;
                  _loc21_ = Math.round(param1.y + _loc13_.y - param6.top.y);
                  _loc22_ = param6.top;
               }
               if(_loc12_ == PopOverConst.ARROW_BOTTOM || _loc12_ == PopOverConst.ARROW_TOP)
               {
                  _loc23_ = param1.x / 2;
                  if(param4.x < _loc23_)
                  {
                     _loc20_ = Math.round(_loc13_.x / 2);
                  }
                  else if(param3.x - param4.x < _loc23_)
                  {
                     _loc20_ = Math.round(param1.x - _loc13_.x / 2);
                  }
                  else
                  {
                     _loc20_ = Math.round(param1.x / 2);
                  }
                  _loc14_ = _loc20_ - _loc22_.x;
               }
               _loc10_ = new SmartPopOverLayoutInfo(_loc12_,_loc20_,_loc14_,_loc21_);
               if(param8)
               {
                  _loc11_ = updateArrowDirection(_loc10_,param1,param3,param4,param9);
               }
               if(_loc11_ == null)
               {
                  return _loc10_;
               }
            }
            if(_loc11_ == null)
            {
               return _loc10_;
            }
         }
         return _loc10_;
      }
      
      override public function invokeLayout() : Object
      {
         var _loc4_:DisplayObject = null;
         var _loc10_:SmartPopOverLayoutInfo = null;
         super.invokeLayout();
         if(this._positionKeyPoint == null || this._stageDimensions == null)
         {
            return null;
         }
         var _loc1_:Point = new Point();
         var _loc2_:SmartPopOver = SmartPopOver(target);
         _loc1_.x = _loc2_.width;
         _loc1_.y = _loc2_.height;
         var _loc3_:Vector.<Point> = new Vector.<Point>(4);
         var _loc5_:Vector.<DisplayObject> = _loc2_.getArrowsList();
         var _loc6_:uint = _loc5_.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc5_[_loc7_];
            _loc3_[_loc7_] = new Point(_loc4_.width,_loc4_.height);
            _loc7_++;
         }
         var _loc8_:IAbstractWrapperView = _loc2_.wrapperContent;
         var _loc9_:Rectangle = new Rectangle(0,0,_loc2_.hitMc.width,_loc2_.hitMc.height);
         _loc10_ = getLayoutOptions(_loc1_,_loc3_,this._stageDimensions,this._positionKeyPoint,_loc9_,this._positionKeyPointPadding,this._preferredLayout,this._changeableArrowDirection,_bgInternalPadding);
         _loc2_.arrowDirection = _loc10_.arrowDirection;
         _loc2_.arrowPosition = _loc10_.arrowPosition;
         _loc2_.x = Math.round(this.positionKeyPoint.x - _loc10_.popupPaddingLeft - _bgInternalPadding.left);
         _loc2_.y = Math.round(this.positionKeyPoint.y - _loc10_.popupPaddingTop - _bgInternalPadding.top);
         updateArrowPosition(_loc2_,_loc10_.arrowDirection,_loc10_.arrowPosition);
         return _loc10_;
      }
      
      public function set stageDimensions(param1:Point) : void
      {
         this._stageDimensions = param1;
      }
      
      public function set positionKeyPoint(param1:Point) : void
      {
         this._positionKeyPoint = param1;
      }
      
      public function get stageDimensions() : Point
      {
         return this._stageDimensions;
      }
      
      public function get positionKeyPoint() : Point
      {
         return this._positionKeyPoint;
      }
      
      public function get positionKeyPointPadding() : TwoDimensionalPadding
      {
         return this._positionKeyPointPadding;
      }
      
      public function set positionKeyPointPadding(param1:TwoDimensionalPadding) : void
      {
         this._positionKeyPointPadding = param1;
      }
      
      override public function dispose() : void
      {
         this._stageDimensions = null;
         this._positionKeyPoint = null;
         this._positionKeyPointPadding = null;
         super.dispose();
      }
      
      public function get preferredLayout() : int
      {
         return this._preferredLayout;
      }
      
      public function set preferredLayout(param1:int) : void
      {
         this._preferredLayout = param1;
      }
      
      public function get changeableArrowDirection() : Boolean
      {
         return this._changeableArrowDirection;
      }
      
      public function set changeableArrowDirection(param1:Boolean) : void
      {
         this._changeableArrowDirection = param1;
      }
   }
}
