package net.wg.gui.lobby.tankman
{
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class RoleChangeItems extends UIComponentEx implements ISpriteEx
   {
       
      
      public var item0:RoleChangeItem;
      
      public var item1:RoleChangeItem;
      
      public var item2:RoleChangeItem;
      
      public var item3:RoleChangeItem;
      
      public var item4:RoleChangeItem;
      
      private var _items:Vector.<RoleChangeItem>;
      
      private var _itemsLength:int;
      
      private var _currentRoleId:String;
      
      public function RoleChangeItems()
      {
         this._items = new Vector.<RoleChangeItem>(0);
         super();
         this._items = new <RoleChangeItem>[this.item0,this.item1,this.item2,this.item3,this.item4];
         this._itemsLength = this._items.length;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:int = 0;
         while(_loc1_ < this._itemsLength)
         {
            this._items[_loc1_].addEventListener(ButtonEvent.CLICK,this.onItemClick);
            _loc1_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._itemsLength)
         {
            this._items[0].removeEventListener(ButtonEvent.CLICK,this.onItemClick);
            _loc1_++;
         }
         this.item0.dispose();
         this.item0 = null;
         this.item1.dispose();
         this.item1 = null;
         this.item2.dispose();
         this.item2 = null;
         this.item3.dispose();
         this.item3 = null;
         this.item4.dispose();
         this.item4 = null;
         this._items.splice(0,this._items.length);
         this._items = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:RoleChangeItem = null;
         var _loc2_:Array = param1 as Array;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < this._itemsLength)
         {
            _loc5_ = _loc4_ < _loc3_;
            _loc6_ = this._items[_loc4_];
            _loc6_.visible = _loc5_;
            _loc6_.selected = false;
            if(_loc5_)
            {
               _loc6_.update(_loc2_[_loc4_]);
            }
            _loc4_++;
         }
         this._currentRoleId = null;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get currentRoleId() : String
      {
         return this._currentRoleId;
      }
      
      private function onItemClick(param1:Event) : void
      {
         var _loc2_:RoleChangeItem = RoleChangeItem(param1.currentTarget);
         this._currentRoleId = _loc2_.roleId;
         var _loc3_:int = 0;
         while(_loc3_ < this._itemsLength)
         {
            this._items[_loc3_].selected = this._items[_loc3_] == _loc2_;
            _loc3_++;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
