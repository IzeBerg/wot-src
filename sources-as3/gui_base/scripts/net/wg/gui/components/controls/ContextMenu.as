package net.wg.gui.components.controls
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.VO.SeparateItem;
   import net.wg.data.constants.ContextMenuConstants;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.infrastructure.interfaces.IContextMenu;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICounterManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class ContextMenu extends UIComponentEx implements IContextMenu
   {
      
      private static const TWEEN_DURATION:Number = 200;
      
      private static const HIT_AREA_MARGIN:Padding = new Padding(3,3,3,3);
      
      private static const BG_SHADOW_BORDER:Padding = new Padding(8,37,16,35);
      
      private static const FIRST_ELEM_TOP_PADDING:Number = 9;
      
      private static const LAST_ELEM_BOTTOM_PADDING:Number = 9;
      
      private static const ITEM_SHOW_ALPHA:int = 1;
      
      private static const ITEM_HIDE_ALPHA:int = 0;
      
      private static const _LINKAGE_NULL:String = "null";
       
      
      public var bgMc:MovieClip;
      
      public var hit:MovieClip = null;
      
      private var _groupItemSelected:ContextMenuItem;
      
      private var _margin:Number = 0;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _showHideSubTween:Tween;
      
      private var _items:Array;
      
      private var _memberItemData:Object;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _padding:Padding;
      
      private var _clickPoint:Point;
      
      private var _onItemSelectCallback:Function;
      
      private var _onReleaseOutsideCallback:Function;
      
      private var _data:Vector.<IContextItem> = null;
      
      private var _parentObj:DisplayObject = null;
      
      private var _contextMenuItems:Vector.<ContextMenuItem>;
      
      private var _separators:Vector.<ContextMenuItemSeparate>;
      
      private var _counterManager:ICounterManager;
      
      public function ContextMenu()
      {
         this._memberItemData = {};
         this._tweenManager = new ExcludeTweenManager();
         this._padding = new Padding();
         super();
         this.padding = new Padding(0,0,0,0);
         this._contextMenuItems = new Vector.<ContextMenuItem>();
         this._separators = new Vector.<ContextMenuItemSeparate>();
         this._counterManager = App.utils.counterManager;
      }
      
      override public function toString() : String
      {
         return "[Wargaming ContextMenu " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onAppMouseDownHandler);
         hitArea = this.hit;
         this.bgMc.mouseEnabled = false;
         this.bgMc.mouseChildren = false;
         this.bgMc.tabEnabled = false;
         this.bgMc.tabChildren = false;
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onAppMouseDownHandler);
         this._tweenManager.unregisterAll();
         this._tweenManager.dispose();
         this._showHideSubTween = null;
         this._tweenManager = null;
         this._onItemSelectCallback = null;
         this._onReleaseOutsideCallback = null;
         this._clickPoint = null;
         this._padding = null;
         this._memberItemData = null;
         this.bgMc = null;
         this.hit = null;
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         this.clearItems();
         this._contextMenuItems = null;
         this._separators = null;
         if(this._items)
         {
            this._items.splice(0,this._items.length);
            this._items = null;
         }
         this._groupItemSelected = null;
         this._parentObj = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      public function build(param1:Vector.<IContextItem>, param2:Point) : void
      {
         var _loc5_:Vector.<IContextItem> = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:IClassFactory = null;
         var _loc15_:Number = NaN;
         var _loc16_:ContextMenuItem = null;
         var _loc17_:ContextMenuItem = null;
         var _loc18_:ContextMenuItemSeparate = null;
         var _loc19_:IContextItem = null;
         var _loc20_:String = null;
         this._clickPoint = param2;
         var _loc3_:Number = param2.x;
         var _loc4_:Number = param2.y;
         this.clearItems();
         this._data = param1;
         if(this._data)
         {
            _loc5_ = this._data;
            _loc8_ = this._margin + BG_SHADOW_BORDER.left;
            _loc9_ = this._margin + BG_SHADOW_BORDER.top + FIRST_ELEM_TOP_PADDING;
            _loc10_ = _loc8_;
            _loc11_ = _loc9_;
            _loc12_ = 0;
            this._items = [];
            _loc13_ = this._padding.top + this._padding.bottom;
            _loc14_ = App.utils.classFactory;
            _loc15_ = _loc5_.length;
            _loc16_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc15_)
            {
               _loc18_ = null;
               _loc19_ = _loc5_[_loc6_];
               if(_loc19_.id == ContextMenuConstants.SEPARATE)
               {
                  _loc18_ = _loc14_.getComponent(Linkages.CONTEXT_MENU_SEPARATE,ContextMenuItemSeparate);
                  _loc18_.index = _loc6_;
                  _loc18_.id = _loc19_.id;
                  _loc18_.x = _loc10_;
                  _loc18_.y = _loc11_;
                  _loc11_ += _loc18_.height + _loc13_;
                  this._items.push(_loc18_);
                  this._separators.push(_loc18_);
                  addChild(_loc18_);
               }
               else if(_loc19_.initData.visible)
               {
                  _loc20_ = Linkages.CONTEXT_MENU_ITEM;
                  if(StringUtils.isNotEmpty(_loc19_.linkage) && _loc19_.linkage != _LINKAGE_NULL)
                  {
                     _loc20_ = _loc19_.linkage;
                  }
                  _loc16_ = _loc14_.getComponent(_loc20_,ContextMenuItem,_loc19_.initData);
                  _loc16_.index = _loc6_;
                  _loc16_.items = Boolean(_loc5_[_loc6_].submenu) ? _loc5_[_loc6_].submenu.slice(0,_loc5_[_loc6_].submenu.length) : new Vector.<IContextItem>();
                  _loc16_.addEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
                  _loc16_.id = _loc19_.id;
                  _loc16_.label = _loc19_.label;
                  _loc16_.iconType = _loc16_.iconType || _loc19_.iconType;
                  _loc16_.showCheckmark = _loc19_.initData.showCheckmark;
                  _loc16_.invalidWidth();
                  _loc12_ = Math.max(_loc12_,_loc16_.width);
                  _loc16_.x = _loc10_;
                  _loc16_.y = _loc11_;
                  _loc11_ += _loc16_.height + _loc13_;
                  if(_loc16_.items.length > 0)
                  {
                     _loc12_ = Math.max(_loc12_,this.createSubItems(_loc16_));
                  }
                  this._contextMenuItems.push(_loc16_);
                  this._items.push(_loc16_);
                  addChild(_loc16_);
                  if(_loc16_.isNew)
                  {
                     this._counterManager.setCounter(_loc16_,CounterManager.EXCLAMATION_COUNTER_VALUE,null,new CounterProps(-7,10));
                  }
               }
               _loc6_++;
            }
            for each(_loc17_ in this._contextMenuItems)
            {
               _loc17_.width = _loc12_;
            }
            this.bgMc.width = _loc12_ + this._margin * 2 + BG_SHADOW_BORDER.left + BG_SHADOW_BORDER.right ^ 0;
            this.bgMc.height = _loc11_ - this._padding.bottom - this._padding.top + this._margin + BG_SHADOW_BORDER.bottom + LAST_ELEM_BOTTOM_PADDING ^ 0;
            this.hit.x = _loc8_ - HIT_AREA_MARGIN.left;
            this.hit.y = _loc9_ - FIRST_ELEM_TOP_PADDING - HIT_AREA_MARGIN.top;
            this.hit.width = this.bgMc.width - (BG_SHADOW_BORDER.horizontal + this._margin * 2) + HIT_AREA_MARGIN.horizontal;
            this.updateHitHeight(this.bgMc.height);
            x = _loc3_ - BG_SHADOW_BORDER.left;
            y = _loc4_ - BG_SHADOW_BORDER.top;
            if(y + this.bgMc.height > App.instance.appHeight)
            {
               y = y - this.hit.height + HIT_AREA_MARGIN.vertical ^ 0;
            }
            if(y < 0)
            {
               y = BG_SHADOW_BORDER.top;
            }
            if(x + this.bgMc.width > App.instance.appWidth)
            {
               x = x - this.hit.width + HIT_AREA_MARGIN.horizontal ^ 0;
            }
            if(x < 0)
            {
               x = BG_SHADOW_BORDER.left;
            }
            this._startX = x;
            this._startY = y;
         }
      }
      
      public function setMemberItemData(param1:Object) : void
      {
         this._memberItemData = param1;
      }
      
      protected function clearItems() : void
      {
         var _loc2_:ContextMenuItem = null;
         var _loc4_:ContextMenuItemSeparate = null;
         var _loc1_:int = this._contextMenuItems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._contextMenuItems[_loc3_];
            _loc2_.removeEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
            this._counterManager.removeCounter(_loc2_);
            removeChild(_loc2_);
            if(!_loc2_.isDisposed())
            {
               _loc2_.dispose();
            }
            _loc3_++;
         }
         this._contextMenuItems.splice(0,_loc1_);
         _loc1_ = this._separators.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this._separators[_loc3_];
            removeChild(_loc4_);
            if(!_loc4_.isDisposed())
            {
               _loc4_.dispose();
            }
            _loc3_++;
         }
         this._separators.splice(0,_loc1_);
      }
      
      private function updateHitHeight(param1:int) : void
      {
         this.hit.height = param1 - (BG_SHADOW_BORDER.vertical + this._margin * 2) + HIT_AREA_MARGIN.vertical;
      }
      
      private function createSubItems(param1:ContextMenuItem) : Number
      {
         var _loc7_:IContextItem = null;
         var _loc8_:ContextMenuItem = null;
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y + param1.height + this._padding.top + this._padding.bottom;
         var _loc4_:Number = param1.items.length;
         var _loc5_:IClassFactory = App.utils.classFactory;
         var _loc6_:Number = 0;
         var _loc9_:uint = 0;
         while(_loc9_ < _loc4_)
         {
            if(!(param1.items[_loc9_] is SeparateItem))
            {
               _loc7_ = param1.items[_loc9_];
               _loc8_ = _loc5_.getComponent(Linkages.CONTEXT_MENU_ITEM,ContextMenuItem,_loc7_.initData);
               _loc8_.index = _loc9_;
               _loc8_.type = _loc8_.CONTEXT_MENU_ITEM_SUB;
               _loc8_.id = _loc7_.id;
               _loc8_.label = _loc7_.label;
               _loc8_.invalidWidth();
               _loc6_ = Math.max(_loc6_,_loc8_.width);
               _loc8_.addEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
               _loc8_.x = _loc2_;
               _loc8_.y = _loc3_;
               _loc3_ += _loc8_.height + this._padding.top + this._padding.bottom;
               _loc8_.visible = false;
               _loc8_.alpha = 0;
               param1.subItems.push(_loc8_);
               this._contextMenuItems.push(_loc8_);
               addChild(_loc8_);
            }
            _loc9_++;
         }
         return _loc6_;
      }
      
      private function beginAnimExpand(param1:ContextMenuItem) : void
      {
         this._tweenManager.unregisterAll();
         if(this._groupItemSelected && this._groupItemSelected == param1)
         {
            if(this._groupItemSelected.isOpened)
            {
               this.hideSub(this._groupItemSelected);
            }
            else
            {
               this.showSub(this._groupItemSelected);
            }
         }
         else
         {
            if(this._groupItemSelected && this._groupItemSelected.isOpened)
            {
               this.hideSub(this._groupItemSelected);
            }
            this._groupItemSelected = param1;
            this.showSub(this._groupItemSelected);
         }
         this.expand(this._groupItemSelected);
      }
      
      private function calculateItemsHeight(param1:Array) : int
      {
         var _loc2_:int = this._padding.top + this._padding.bottom;
         var _loc3_:int = 0;
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ += param1[_loc5_].height;
            _loc5_++;
         }
         return int(_loc3_ + _loc4_ * _loc2_);
      }
      
      private function calcSumPaddings() : int
      {
         return FIRST_ELEM_TOP_PADDING + LAST_ELEM_BOTTOM_PADDING - this._padding.bottom - this._padding.top + this._margin * 2 + BG_SHADOW_BORDER.top + BG_SHADOW_BORDER.bottom;
      }
      
      private function expand(param1:ContextMenuItem) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc2_:Function = Strong.easeInOut;
         var _loc7_:int = this.calculateItemsHeight(this._items);
         var _loc8_:uint = 0;
         if(param1.isOpened)
         {
            _loc8_ = this.calculateItemsHeight(param1.subItems);
         }
         _loc7_ += _loc8_;
         _loc7_ += this.calcSumPaddings();
         var _loc9_:int = this._startY + _loc7_ + this._margin;
         if(_loc9_ > App.appHeight)
         {
            _loc5_ = App.appHeight - _loc9_;
         }
         this._tweenManager.registerAndLaunch(TWEEN_DURATION,this.bgMc,{"height":_loc7_},{
            "paused":false,
            "onComplete":this.onHideTweenComplete,
            "ease":_loc2_
         });
         this._tweenManager.registerAndLaunch(TWEEN_DURATION,this,{"y":this._startY + _loc5_ ^ 0},{
            "paused":false,
            "onComplete":this.onHideTweenComplete,
            "ease":_loc2_
         });
         var _loc10_:uint = param1.index + 1;
         var _loc11_:int = this._padding.top + this._padding.bottom;
         var _loc12_:int = this._margin + BG_SHADOW_BORDER.top + FIRST_ELEM_TOP_PADDING;
         _loc3_ = this._items.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ == _loc10_)
            {
               _loc12_ += _loc8_;
            }
            this._tweenManager.registerAndLaunch(TWEEN_DURATION,this._items[_loc4_],{"y":_loc12_},{
               "paused":false,
               "onComplete":this.onHideTweenComplete,
               "ease":_loc2_
            });
            _loc12_ += this._items[_loc4_].height + _loc11_;
            _loc4_++;
         }
      }
      
      private function showSub(param1:ContextMenuItem) : void
      {
         var _loc3_:ContextMenuItem = null;
         param1.isOpened = true;
         var _loc2_:int = param1.subItems.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = ContextMenuItem(param1.subItems[_loc4_]);
            _loc3_.visible = true;
            this._showHideSubTween = this._tweenManager.registerAndLaunch(TWEEN_DURATION,_loc3_,{"alpha":ITEM_SHOW_ALPHA},{
               "paused":false,
               "onComplete":this.fSubAnimComplete,
               "ease":Strong.easeIn
            });
            _loc4_++;
         }
      }
      
      private function hideSub(param1:ContextMenuItem) : void
      {
         param1.isOpened = false;
         var _loc2_:int = param1.subItems.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this._showHideSubTween = this._tweenManager.registerAndLaunch(TWEEN_DURATION,ContextMenuItem(param1.subItems[_loc3_]),{"alpha":ITEM_HIDE_ALPHA},{
               "paused":false,
               "onComplete":this.fSubAnimComplete,
               "ease":Strong.easeOut
            });
            _loc3_++;
         }
      }
      
      private function onHideTweenComplete(param1:Tween) : void
      {
         if(param1.target == this.bgMc)
         {
            this.updateHitHeight(this.bgMc.height);
         }
         this._tweenManager.unregister(param1);
      }
      
      private function fSubAnimComplete(param1:Tween) : void
      {
         var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
         if(_loc2_.alpha == ITEM_HIDE_ALPHA)
         {
            _loc2_.visible = false;
         }
         this._tweenManager.unregister(param1);
      }
      
      public function get padding() : Padding
      {
         return this._padding;
      }
      
      public function set padding(param1:Padding) : void
      {
         this._padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      public function get clickPoint() : Point
      {
         return this._clickPoint;
      }
      
      public function set onItemSelectCallback(param1:Function) : void
      {
         this._onItemSelectCallback = param1;
      }
      
      public function set onReleaseOutsideCallback(param1:Function) : void
      {
         this._onReleaseOutsideCallback = param1;
      }
      
      public function get parentObj() : DisplayObject
      {
         return this._parentObj;
      }
      
      public function set parentObj(param1:DisplayObject) : void
      {
         this._parentObj = param1;
      }
      
      private function onAppMouseDownHandler(param1:MouseEvent) : void
      {
         if(this._onReleaseOutsideCallback != null && !this.hit.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this._onReleaseOutsideCallback();
         }
      }
      
      private function onItemClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:ContextMenuItem = ContextMenuItem(param1.target);
         this.beginAnimExpand(_loc2_);
         if(_loc2_.type != _loc2_.CONTEXT_MENU_ITEM_GROUP)
         {
            if(this._onItemSelectCallback != null)
            {
               this._onItemSelectCallback(_loc2_.id);
            }
         }
      }
   }
}
