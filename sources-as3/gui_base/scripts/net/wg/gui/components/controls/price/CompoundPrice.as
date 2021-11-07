package net.wg.gui.components.controls.price
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.VO.CompoundPriceVO;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class CompoundPrice extends UIComponentEx
   {
      
      private static const PRICES_HORIZONTAL_OFFSET:int = 10;
      
      private static const PRICES_VERTICAL_OFFSET:int = -9;
      
      public static const DIRECTION_LEFT:String = "left";
      
      public static const DIRECTION_RIGHT:String = "right";
      
      public static const DIRECTION_DOWN:String = "down";
      
      public static const DIRECTION_UP:String = "up";
      
      public static const ANCHOR_BOTTOM_LEFT:String = "bottomLeft";
      
      public static const ANCHOR_BOTTOM_RIGHT:String = "bottomRight";
      
      public static const ACTION_STATE_SIMPLE:String = Price.ACTION_STATE_SIMPLE;
      
      public static const ACTION_STATE_SHOW_VALUE:String = Price.ACTION_STATE_SHOW_VALUE;
      
      public static const ACTION_STATE_ONLY_BG:String = Price.ACTION_STATE_ONLY_BG;
      
      public static const ACTION_MODE_DISABLED:String = Price.ACTION_MODE_DISABLED;
      
      public static const ACTION_MODE_ENABLED:String = Price.ACTION_MODE_ENABLED;
      
      public static const ACTION_MODE_ALWAYS_SHOW:String = Price.ACTION_MODE_ALWAYS_SHOW;
      
      public static const PRICE_ICON_ALIGN_LEFT:String = Price.ICON_ALIGN_LEFT;
      
      public static const PRICE_ICON_ALIGN_RIGHT:String = Price.ICON_ALIGN_RIGHT;
      
      public static const OLD_PRICE_ALIGN_TOP:String = Price.OLD_PRICE_ALIGN_TOP;
      
      public static const OLD_PRICE_ALIGN_BOTTOM:String = Price.OLD_PRICE_ALIGN_BOTTOM;
      
      public static const OLD_PRICE_ALIGN_LEFT:String = Price.OLD_PRICE_ALIGN_LEFT;
       
      
      public var hit:Sprite = null;
      
      private var _classFactory:IClassFactory;
      
      private var _items:Vector.<Price> = null;
      
      private var _numVisibleItems:int = 0;
      
      private var _actionMode:String = "enabled";
      
      private var _actionState:String = "percentBG";
      
      private var _bigFonts:Boolean = false;
      
      private var _actionTooltip:Boolean = false;
      
      private var _couponDiscount:int = 0;
      
      private var _customActionTooltip:String = "";
      
      private var _priceIconAlign:String = "right";
      
      private var _priceIconOffset:Point;
      
      private var _priceActionOffset:Point;
      
      private var _itemsDirection:String = "left";
      
      private var _itemsAnchor:String = "bottomLeft";
      
      private var _oldPriceAlign:String = "oldPriceAlignBottom";
      
      private var _oldPriceVisible:Boolean = false;
      
      public function CompoundPrice()
      {
         this._classFactory = App.utils.classFactory;
         this._priceIconOffset = new Point(0,0);
         this._priceActionOffset = new Point(0,0);
         super();
         this._items = new Vector.<Price>(0);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(Event.RESIZE,this.onChildrenResizeHandler,true,0,true);
      }
      
      override protected function draw() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updatePositions();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Price = null;
         removeEventListener(Event.RESIZE,this.onChildrenResizeHandler,true);
         for each(_loc1_ in this._items)
         {
            _loc1_.dispose();
         }
         this._items.splice(0,this._items.length);
         this._items = null;
         this._classFactory = null;
         this._priceIconOffset = null;
         this._priceActionOffset = null;
         this.hit = null;
         super.onDispose();
      }
      
      public function setCouponDiscount(param1:int) : void
      {
         if(this._couponDiscount == param1)
         {
            return;
         }
         this._couponDiscount = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].couponDiscount = param1;
            _loc2_++;
         }
      }
      
      public function setData(param1:ItemPriceVO) : void
      {
         var _loc5_:Price = null;
         var _loc6_:PriceVO = null;
         var _loc7_:PriceVO = null;
         var _loc8_:PriceVO = null;
         var _loc14_:Vector.<PriceVO> = null;
         var _loc15_:Vector.<PriceVO> = null;
         var _loc2_:int = this._items.length;
         var _loc3_:Vector.<PriceVO> = param1.price.items;
         var _loc4_:int = _loc3_.length;
         var _loc9_:int = Math.max(_loc4_,_loc2_);
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:CompoundPriceVO = param1.action;
         var _loc13_:CompoundPriceVO = param1.defPrice;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         this._numVisibleItems = _loc4_;
         if(_loc12_ != null)
         {
            _loc14_ = _loc12_.items;
            _loc16_ = _loc14_.length;
         }
         if(_loc13_ != null)
         {
            _loc15_ = _loc13_.items;
            _loc17_ = _loc15_.length;
         }
         var _loc18_:int = 0;
         while(_loc18_ < _loc9_)
         {
            _loc7_ = null;
            _loc8_ = null;
            if(_loc18_ < _loc2_)
            {
               _loc5_ = this._items[_loc18_];
            }
            if(_loc18_ >= _loc4_)
            {
               _loc5_.visible = false;
            }
            else
            {
               if(_loc18_ >= _loc2_)
               {
                  _loc5_ = this._classFactory.getComponent(Linkages.PRICE_COMPONENT,Price);
                  addChild(_loc5_);
                  this._items.push(_loc5_);
               }
               _loc6_ = _loc3_[_loc18_];
               if(_loc16_)
               {
                  if(_loc10_ < _loc16_ && _loc14_[_loc10_].name == _loc6_.name)
                  {
                     _loc7_ = _loc14_[_loc10_];
                     _loc10_++;
                  }
               }
               if(_loc17_)
               {
                  if(_loc11_ < _loc17_ && _loc15_[_loc11_].name == _loc6_.name)
                  {
                     _loc8_ = _loc15_[_loc11_];
                     _loc11_++;
                  }
               }
               _loc5_.setData(_loc6_,_loc7_,_loc8_);
               _loc5_.bigFonts = this._bigFonts;
               _loc5_.visible = true;
               _loc5_.actionMode = this._actionMode;
               _loc5_.actionState = this._actionState;
               _loc5_.actionTooltipEnabled = this._actionTooltip;
               _loc5_.iconAlign = this._priceIconAlign;
               _loc5_.iconOffset = this._priceIconOffset;
               _loc5_.actionOffset = this._priceActionOffset;
               _loc5_.oldPriceVisible = this._oldPriceVisible;
               _loc5_.oldPriceAlign = this._oldPriceAlign;
            }
            _loc18_++;
         }
         invalidateLayout();
      }
      
      public function updateEnoughStatuses(param1:Vector.<PriceVO>) : void
      {
         var _loc2_:PriceVO = null;
         var _loc3_:Price = null;
         for each(_loc2_ in param1)
         {
            for each(_loc3_ in this._items)
            {
               if(_loc3_.itemType == _loc2_.name)
               {
                  _loc3_.isEnough = Boolean(_loc2_.value);
                  break;
               }
            }
         }
      }
      
      private function updatePositions() : void
      {
         var _loc3_:Price = null;
         var _loc19_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = this._numVisibleItems;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc4_:Boolean = this._itemsDirection == DIRECTION_LEFT;
         var _loc5_:Boolean = this._itemsDirection == DIRECTION_RIGHT;
         var _loc6_:Boolean = this._itemsDirection == DIRECTION_UP;
         var _loc7_:Boolean = this._itemsDirection == DIRECTION_DOWN;
         var _loc8_:Boolean = _loc4_ || _loc5_;
         var _loc9_:Boolean = !_loc8_;
         var _loc10_:int = !!_loc8_ ? int(PRICES_HORIZONTAL_OFFSET) : int(PRICES_VERTICAL_OFFSET);
         var _loc11_:Boolean = _loc6_ || _loc4_;
         var _loc12_:Number = Number.MAX_VALUE;
         var _loc13_:Number = Number.MIN_VALUE;
         var _loc14_:Number = Number.MAX_VALUE;
         var _loc15_:Number = Number.MIN_VALUE;
         var _loc16_:int = !!_loc11_ ? int(-1) : int(1);
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         var _loc20_:int = 0;
         while(_loc20_ < _loc2_)
         {
            _loc19_ = !!_loc11_ ? int(_loc2_ - 1 - _loc20_) : int(_loc20_);
            _loc3_ = this._items[_loc19_];
            _loc3_.validateNow();
            _loc3_.x = _loc3_.y = 0;
            if(_loc4_)
            {
               _loc1_ += -_loc3_.contentWidth;
               _loc3_.x = _loc1_;
            }
            else if(_loc5_)
            {
               _loc3_.x = _loc1_;
               _loc1_ += _loc3_.contentWidth;
            }
            else if(_loc6_)
            {
               _loc1_ += -_loc3_.contentHeight;
               _loc3_.y = _loc1_;
            }
            else if(_loc7_)
            {
               _loc3_.y = _loc1_;
               _loc1_ += _loc3_.contentHeight;
            }
            if(_loc6_ || _loc19_ != 0 && _loc19_ != _loc2_ - 1)
            {
               _loc1_ += _loc10_ * _loc16_;
            }
            if(_loc9_ && this._itemsAnchor == ANCHOR_BOTTOM_RIGHT)
            {
               _loc3_.x -= _loc3_.contentWidth;
            }
            _loc17_ = _loc3_.x + _loc3_.contentWidth;
            _loc18_ = _loc3_.y + _loc3_.contentHeight;
            _loc12_ = _loc3_.x < _loc12_ ? Number(_loc3_.x) : Number(_loc12_);
            _loc14_ = _loc3_.y < _loc14_ ? Number(_loc3_.y) : Number(_loc14_);
            _loc13_ = _loc17_ > _loc13_ ? Number(_loc17_) : Number(_loc13_);
            _loc15_ = _loc18_ > _loc15_ ? Number(_loc18_) : Number(_loc15_);
            _loc20_++;
         }
         this.hit.x = _loc12_;
         this.hit.y = _loc14_;
         this.hit.width = _loc13_ - _loc12_;
         this.hit.height = _loc15_ - _loc14_;
      }
      
      public function get itemsDirection() : String
      {
         return this._itemsDirection;
      }
      
      public function set itemsDirection(param1:String) : void
      {
         if(this._itemsDirection == param1)
         {
            return;
         }
         this._itemsDirection = param1;
         invalidateLayout();
      }
      
      public function get itemsAnchor() : String
      {
         return this._itemsAnchor;
      }
      
      public function set itemsAnchor(param1:String) : void
      {
         if(this._itemsAnchor == param1)
         {
            return;
         }
         this._itemsAnchor = param1;
         invalidateLayout();
      }
      
      public function get actionMode() : String
      {
         return this._actionMode;
      }
      
      public function set actionMode(param1:String) : void
      {
         if(this._actionMode == param1)
         {
            return;
         }
         this._actionMode = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].actionMode = this._actionMode;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function get actionState() : String
      {
         return this._actionState;
      }
      
      public function set actionState(param1:String) : void
      {
         if(this._actionState == param1)
         {
            return;
         }
         this._actionState = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].actionState = this._actionState;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function set bigFonts(param1:Boolean) : void
      {
         if(this._bigFonts == param1)
         {
            return;
         }
         this._bigFonts = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].bigFonts = this._bigFonts;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function set actionTooltip(param1:Boolean) : void
      {
         if(this._actionTooltip == param1)
         {
            return;
         }
         this._actionTooltip = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].actionTooltipEnabled = this._actionTooltip;
            _loc2_++;
         }
      }
      
      public function set customActionTooltip(param1:String) : void
      {
         if(this._customActionTooltip == param1)
         {
            return;
         }
         this._customActionTooltip = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].customActionTooltip = param1;
            _loc2_++;
         }
      }
      
      public function get priceIconAlign() : String
      {
         return this._priceIconAlign;
      }
      
      public function set priceIconAlign(param1:String) : void
      {
         if(this._priceIconAlign == param1)
         {
            return;
         }
         this._priceIconAlign = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].iconAlign = this._priceIconAlign;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function get contentWidth() : Number
      {
         return this.hit.width;
      }
      
      public function get contentHeight() : Number
      {
         return this.hit.height;
      }
      
      public function get priceIconOffset() : Point
      {
         return this._priceIconOffset;
      }
      
      public function set priceIconOffset(param1:Point) : void
      {
         if(this._priceIconOffset == param1 || this._priceIconOffset && this._priceIconOffset.equals(param1))
         {
            return;
         }
         this._priceIconOffset = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].iconOffset = this._priceIconOffset;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function get priceActionOffset() : Point
      {
         return this._priceActionOffset;
      }
      
      public function set priceActionOffset(param1:Point) : void
      {
         if(this._priceActionOffset == param1 || this._priceActionOffset && this._priceActionOffset.equals(param1))
         {
            return;
         }
         this._priceActionOffset = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this._numVisibleItems)
         {
            this._items[_loc2_].actionOffset = this._priceActionOffset;
            _loc2_++;
         }
         invalidateLayout();
      }
      
      public function get oldPriceAlign() : String
      {
         return this._oldPriceAlign;
      }
      
      public function set oldPriceAlign(param1:String) : void
      {
         var _loc2_:int = 0;
         if(this._oldPriceAlign != param1)
         {
            this._oldPriceAlign = param1;
            _loc2_ = 0;
            while(_loc2_ < this._numVisibleItems)
            {
               this._items[_loc2_].oldPriceAlign = param1;
               _loc2_++;
            }
            invalidateLayout();
         }
      }
      
      public function get oldPriceVisible() : Boolean
      {
         return this._oldPriceVisible;
      }
      
      public function set oldPriceVisible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this._oldPriceVisible != param1)
         {
            this._oldPriceVisible = param1;
            _loc2_ = 0;
            while(_loc2_ < this._numVisibleItems)
            {
               this._items[_loc2_].oldPriceVisible = param1;
               _loc2_++;
            }
            invalidateLayout();
         }
      }
      
      private function onChildrenResizeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
