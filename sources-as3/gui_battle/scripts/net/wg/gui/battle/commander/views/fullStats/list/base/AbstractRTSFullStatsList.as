package net.wg.gui.battle.commander.views.fullStats.list.base
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsItem;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsList;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.IClassFactory;
   
   public class AbstractRTSFullStatsList extends UIComponentEx implements IRTSFullStatsList
   {
      
      protected static const ITEM_HEIGHT:int = 25;
       
      
      public var header:TextField = null;
      
      public var container:Sprite = null;
      
      private var _items:Vector.<IRTSFullStatsItem> = null;
      
      private var _itemMap:Dictionary = null;
      
      private var _currOrder:Vector.<Number> = null;
      
      private var _classFactory:IClassFactory;
      
      public function AbstractRTSFullStatsList()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._items = new Vector.<IRTSFullStatsItem>();
         this._itemMap = new Dictionary();
         this._currOrder = new Vector.<Number>();
      }
      
      override protected function onDispose() : void
      {
         this.removeAllItems();
         this._items = null;
         this._itemMap = null;
         this._currOrder = null;
         this.container = null;
         this.header = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function removeAllItems() : void
      {
         var _loc1_:IRTSFullStatsItem = null;
         if(this._itemMap)
         {
            App.utils.data.cleanupDynamicObject(this._itemMap);
         }
         if(this._currOrder)
         {
            this._currOrder.splice(0,this._currOrder.length);
         }
         if(this._items)
         {
            for each(_loc1_ in this._items)
            {
               _loc1_.dispose();
            }
            this._items.splice(0,this._items.length);
         }
         while(this.container.numChildren)
         {
            this.container.removeChildAt(0);
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function resetFrags() : void
      {
         var _loc1_:IRTSFullStatsItem = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.setFrags(0);
         }
      }
      
      public function setFrags(param1:Number, param2:int) : void
      {
         var _loc3_:IRTSFullStatsItem = this.getItemByID(param1);
         if(_loc3_)
         {
            _loc3_.setFrags(param2);
         }
      }
      
      public function setHeaderText(param1:String) : void
      {
         this.header.text = param1;
      }
      
      public function setData(param1:Vector.<IDAAPIDataClass>) : void
      {
         var _loc2_:IDAAPIDataClass = null;
         if(!visible && (!param1 || !param1.length))
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            this.setItemData(_loc2_);
         }
         visible = this._items && this._items.length > 0;
         invalidateData();
      }
      
      public function updateOrder(param1:Vector.<Number>) : void
      {
         var _loc4_:IRTSFullStatsItem = null;
         if(!param1 || !this.checkIfOrderIsValid(param1))
         {
            return;
         }
         var _loc2_:int = this._items.length;
         var _loc3_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_];
            if(this._currOrder[_loc5_] != _loc3_)
            {
               _loc4_ = this.getItemByID(_loc3_);
               if(_loc4_)
               {
                  _loc4_.y = ITEM_HEIGHT * _loc5_;
                  this._currOrder[_loc5_] = _loc3_;
               }
            }
            _loc5_++;
         }
         invalidateSize();
      }
      
      public function getItemByID(param1:Number) : IRTSFullStatsItem
      {
         return this._itemMap[param1];
      }
      
      protected function getItemLinkage() : String
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getItemID(param1:IDAAPIDataClass) : Number
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function get isAllyList() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      private function checkIfOrderIsValid(param1:Vector.<Number>) : Boolean
      {
         var _loc2_:int = param1.length;
         if(_loc2_ != this._currOrder.length)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._currOrder.indexOf(param1[_loc3_]) == Values.DEFAULT_INT)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function setItemData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:Number = this.getItemID(param1);
         var _loc3_:IRTSFullStatsItem = this.getItemByID(_loc2_);
         if(_loc3_)
         {
            _loc3_.setData(param1);
         }
         else
         {
            this.addItem(_loc2_,param1);
         }
      }
      
      private function addItem(param1:Number, param2:IDAAPIDataClass) : void
      {
         var _loc3_:IRTSFullStatsItem = this._classFactory.getComponent(this.getItemLinkage(),IRTSFullStatsItem);
         _loc3_.y = this._items.length * ITEM_HEIGHT;
         this.container.addChild(DisplayObject(_loc3_));
         this._items.push(_loc3_);
         this._itemMap[param1] = _loc3_;
         this._currOrder.push(param1);
         _loc3_.setData(param2);
         invalidateSize();
      }
   }
}
