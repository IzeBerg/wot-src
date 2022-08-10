package net.wg.gui.lobby.badges
{
   import flash.events.Event;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.badges.data.BadgeSuffixItemVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SuffixContainer extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const ITEMS_GAP:int = 6;
      
      private static const NOT_ENABLED_ALPHA:Number = 0.25;
       
      
      public var item0:SuffixItem;
      
      public var item1:SuffixItem;
      
      private var _items:Vector.<SuffixItem>;
      
      private var _itemsLength:int;
      
      private var _selectedItem:SuffixItem;
      
      private var _isItemsShortState:Boolean;
      
      public function SuffixContainer()
      {
         this._items = new Vector.<SuffixItem>(0);
         super();
         this._items = new <SuffixItem>[this.item0,this.item1];
         this._itemsLength = this._items.length;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:int = 0;
         while(_loc1_ < this._itemsLength)
         {
            this._items[_loc1_].addEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
            this._items[_loc1_].addEventListener(Event.RESIZE,this.onItemResizeHandler);
            _loc1_++;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SuffixItem = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 0;
            for each(_loc2_ in this._items)
            {
               if(_loc2_.visible)
               {
                  _loc2_.x = _loc1_;
                  _loc1_ += _loc2_.width + ITEMS_GAP;
               }
            }
            width = _loc1_ - ITEMS_GAP;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._itemsLength)
         {
            this._items[_loc1_].removeEventListener(ButtonEvent.CLICK,this.onItemClickHandler);
            this._items[_loc1_].removeEventListener(Event.RESIZE,this.onItemResizeHandler);
            _loc1_++;
         }
         this.item0.dispose();
         this.item0 = null;
         this.item1.dispose();
         this.item1 = null;
         this._items.splice(0,this._items.length);
         this._items = null;
         this._selectedItem = null;
         super.onDispose();
      }
      
      public function getSelectedId() : int
      {
         return Boolean(this._selectedItem) ? int(this._selectedItem.getId()) : int(0);
      }
      
      public function setSelectedIdx(param1:int) : void
      {
         if(this._selectedItem != null)
         {
            this._selectedItem.selected = false;
         }
         this._selectedItem = this._items[param1];
         this._selectedItem.selected = true;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:Vector.<BadgeSuffixItemVO> = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:SuffixItem = null;
         var _loc6_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1 as Vector.<BadgeSuffixItemVO>;
            _loc3_ = _loc2_.length;
            this._isItemsShortState = _loc3_ == 1;
            _loc6_ = 0;
            while(_loc6_ < this._itemsLength)
            {
               _loc4_ = _loc6_ < _loc3_;
               _loc5_ = this._items[_loc6_];
               _loc5_.visible = _loc4_;
               if(_loc4_)
               {
                  _loc5_.isShortState = this._isItemsShortState;
                  _loc5_.update(_loc2_[_loc6_]);
               }
               _loc6_++;
            }
            invalidateSize();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         alpha = this._isItemsShortState || param1 ? Number(1) : Number(NOT_ENABLED_ALPHA);
      }
      
      private function onItemClickHandler(param1:ButtonEvent) : void
      {
         this._selectedItem.selected = false;
         this._selectedItem = SuffixItem(param1.currentTarget);
         this._selectedItem.selected = true;
         dispatchEvent(new BadgesEvent(BadgesEvent.SUFFIX_BADGE_SELECT));
      }
      
      private function onItemResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
