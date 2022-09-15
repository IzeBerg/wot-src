package net.wg.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IListDAAPIDataProvider;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.utils.IDataUtils;
   
   public class ListDAAPIDataProvider extends EventDispatcher implements IListDAAPIDataProvider
   {
       
      
      public var requestItemAtHandler:Function;
      
      public var requestItemRangeHandler:Function;
      
      public var lengthHandler:Function;
      
      public var sortOnHandler:Function;
      
      public var getSelectedIdxHandler:Function;
      
      public var getItemIndexHandler:Function;
      
      private var _voClass:Class;
      
      private var _cachedRange:Vector.<IDAAPIDataClass> = null;
      
      private var _itemsToDestroy:Vector.<IDisposable> = null;
      
      private var _dataUtils:IDataUtils = null;
      
      private var _items:Array = null;
      
      private var _maxCacheSize:int = 2147483647;
      
      private var _startCachedIndex:int = -1;
      
      private var _endCachedIndex:int = -1;
      
      private var _cacheSize:int = 0;
      
      private var _isLengthValid:Boolean = false;
      
      private var _length:uint = 0;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _isDisposed:Boolean = false;
      
      private var _isValid:Boolean = false;
      
      public function ListDAAPIDataProvider(param1:Class)
      {
         super();
         this._voClass = param1;
      }
      
      public function DAAPIsortOn(param1:Object, param2:Object) : Array
      {
         if(this._isDAAPIInited)
         {
            this.sortOnHandler(param1,param2);
         }
         return null;
      }
      
      public function as_dispose() : void
      {
         this.dispose();
      }
      
      public function as_populate() : void
      {
         this._dataUtils = App.utils.data;
         this._items = [];
         this._itemsToDestroy = new Vector.<IDisposable>();
         this._cachedRange = new Vector.<IDAAPIDataClass>();
         this._isDisposed = false;
         this._isDAAPIInited = true;
         this._cacheSize = 0;
      }
      
      public function cleanUp() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:uint = 0;
         if(this._isDisposed)
         {
            return;
         }
         for each(_loc1_ in this._cachedRange)
         {
            _loc1_.dispose();
         }
         _loc2_ = this._cachedRange.length;
         this._cachedRange.splice(0,_loc2_);
         this._cacheSize -= _loc2_;
         App.utils.asserter.assert(this._cacheSize == 0,"Some elements wasn\'t destroyed! _cacheSize = " + this._cacheSize);
         this._items.splice(0,this._items.length);
         for each(_loc1_ in this._itemsToDestroy)
         {
            _loc1_.dispose();
         }
         this._itemsToDestroy.splice(0,this._itemsToDestroy.length);
         this._startCachedIndex = -1;
         this._endCachedIndex = -1;
      }
      
      public final function dispose() : void
      {
         this._isDisposed = true;
         this.onDispose();
      }
      
      public function getDAAPIselectedIdx() : int
      {
         if(this._isDAAPIInited)
         {
            return this.getSelectedIdxHandler();
         }
         return -1;
      }
      
      public function getItemIndex(param1:String, param2:*) : int
      {
         return int(this.getItemIndexHandler(param1,param2));
      }
      
      public function indexOf(param1:Object, param2:Function = null) : int
      {
         var _loc3_:int = this.cacheIndexOf(IDAAPIDataClass(param1));
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public function invalidate(param1:uint = 0) : void
      {
         this._isValid = false;
         this._length = param1;
         this._isLengthValid = true;
         this.callInvalidateActions();
      }
      
      protected function callInvalidateActions() : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function invalidateItem(param1:int, param2:Object) : void
      {
         this.cacheUpdateItem(param1,param2);
      }
      
      public function invalidateItems(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = param1.length;
         if(this._isValid)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.cacheUpdateItem(param1[_loc4_],param2[_loc4_]);
               _loc4_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               this._dataUtils.cleanupDynamicObject(param2[_loc5_]);
               _loc5_++;
            }
         }
         param1.splice(0,_loc3_);
         param2.splice(0,param2.length);
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:IDAAPIDataClass = null;
         if(param1 == uint.MAX_VALUE)
         {
            _loc3_ = null;
         }
         else if(this.hasIndexInCache(param1))
         {
            _loc3_ = this.getCachedItemAt(param1);
         }
         else if(this._isValid && this._startCachedIndex - 1 == param1)
         {
            _loc3_ = this.cacheAddItemToTheTop(param1);
         }
         else if(this._isValid && this._endCachedIndex + 1 == param1)
         {
            _loc3_ = this.cacheAddItemToTheEnd(param1);
         }
         else if(this._isDAAPIInited)
         {
            _loc3_ = this.createTemporaryItem(param1);
         }
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         if(!this._isDAAPIInited || param1 > param2 || param1 > this.length - 1)
         {
            if(param3 != null)
            {
               param3([]);
            }
            return [];
         }
         if(param2 > this._length - 1)
         {
            param2 = this._length - 1;
         }
         var _loc4_:Boolean = this._startCachedIndex <= param1;
         var _loc5_:Boolean = param2 <= this._endCachedIndex;
         var _loc6_:int = this._endCachedIndex + 1;
         var _loc7_:int = this._startCachedIndex - 1;
         if(!this._isValid || _loc7_ > param2 || param1 > _loc6_)
         {
            this.cleanUp();
            this.initCache(param1,param2);
            this._isValid = true;
         }
         else
         {
            _loc8_ = _loc7_ == param1;
            _loc9_ = _loc6_ == param2;
            if(_loc8_)
            {
               this.cacheAddItemToTheTop(param1);
            }
            else if(_loc9_)
            {
               this.cacheAddItemToTheEnd(param2);
            }
            if(!_loc4_ && !_loc8_)
            {
               this.cacheAddRangeToTheTop(param1,_loc7_);
            }
            if(!_loc5_ && !_loc9_)
            {
               this.cacheAddRangeToTheEnd(_loc6_,param2);
            }
         }
         this.cacheUpdateSendRange(param1,param2);
         if(param3 != null)
         {
            param3(this._items);
         }
         return this._items;
      }
      
      public function resetSelectedIndex(param1:int) : void
      {
         dispatchEvent(new ListDataProviderEvent(ListDataProviderEvent.RESET_SELECTED_INDEX,param1,null));
      }
      
      protected function onDispose() : void
      {
         this.cleanUp();
         this._dataUtils = null;
         this._cachedRange = null;
         this._itemsToDestroy = null;
         this._items = null;
         this._voClass = null;
         this.requestItemAtHandler = null;
         this.requestItemRangeHandler = null;
         this.lengthHandler = null;
         this.sortOnHandler = null;
         this.getSelectedIdxHandler = null;
         this.getItemIndexHandler = null;
      }
      
      private function getCachedItemAt(param1:uint) : IDAAPIDataClass
      {
         return this._cachedRange[this.indexToCacheIndex(param1)];
      }
      
      private function initCache(param1:int, param2:int) : void
      {
         var _loc3_:Array = this.requestItemRangeHandler(param1,param2);
         var _loc4_:int = _loc3_.length;
         this._cachedRange.length = _loc4_;
         this._cacheSize = _loc4_;
         this._startCachedIndex = param1;
         this._endCachedIndex = param1 + _loc4_ - 1;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._cachedRange[_loc5_] = new this._voClass(_loc3_[_loc5_]);
            _loc5_++;
         }
         _loc3_.splice(0,_loc4_);
      }
      
      private function hasIndexInCache(param1:uint) : Boolean
      {
         return this._isValid && this._startCachedIndex <= param1 && param1 <= this._endCachedIndex;
      }
      
      private function cacheUpdateSendRange(param1:int, param2:int) : void
      {
         this._items.splice(0,this._items.length);
         var _loc3_:int = this.indexToCacheIndex(param1);
         var _loc4_:int = this.indexToCacheIndex(param2);
         var _loc5_:int = _loc3_;
         while(_loc5_ <= _loc4_)
         {
            this._items.push(this._cachedRange[_loc5_]);
            _loc5_++;
         }
      }
      
      private function cacheAddItemToTheEnd(param1:int) : IDAAPIDataClass
      {
         var _loc2_:IDAAPIDataClass = new this._voClass(this.requestItemAtHandler(param1));
         var _loc3_:int = this._cachedRange.push(_loc2_);
         ++this._cacheSize;
         ++this._endCachedIndex;
         if(_loc3_ > this._maxCacheSize)
         {
            this.cacheRemoveItemFromTheTop();
         }
         return _loc2_;
      }
      
      private function cacheAddItemToTheTop(param1:int) : IDAAPIDataClass
      {
         var _loc2_:IDAAPIDataClass = new this._voClass(this.requestItemAtHandler(param1));
         var _loc3_:int = this._cachedRange.unshift(_loc2_);
         ++this._cacheSize;
         --this._startCachedIndex;
         if(_loc3_ > this._maxCacheSize)
         {
            this.cacheRemoveItemFromTheEnd();
         }
         return _loc2_;
      }
      
      private function cacheAddRangeToTheEnd(param1:int, param2:int) : void
      {
         var _loc3_:Array = this.requestItemRangeHandler(param1,param2);
         var _loc4_:uint = 0;
         var _loc5_:int = _loc3_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._cachedRange.push(new this._voClass(_loc3_[_loc6_]));
            _loc6_++;
         }
         this._cacheSize += _loc5_;
         this._endCachedIndex += _loc5_;
         _loc3_.splice(0,_loc5_);
         var _loc7_:int = _loc4_ - this._maxCacheSize;
         while(_loc7_ > 0)
         {
            this.cacheRemoveItemFromTheTop();
            _loc7_--;
         }
      }
      
      private function cacheAddRangeToTheTop(param1:int, param2:int) : void
      {
         var _loc3_:Array = this.requestItemRangeHandler(param1,param2);
         var _loc4_:uint = 0;
         var _loc5_:int = _loc3_.length;
         var _loc6_:int = _loc5_ - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = this._cachedRange.unshift(new this._voClass(_loc3_[_loc6_]));
            _loc6_--;
         }
         this._cacheSize += _loc5_;
         this._startCachedIndex -= _loc5_;
         _loc3_.splice(0,_loc5_);
         var _loc7_:int = _loc4_ - this._maxCacheSize;
         while(_loc7_ > 0)
         {
            this.cacheRemoveItemFromTheEnd();
            _loc7_--;
         }
      }
      
      private function cacheRemoveItemFromTheTop() : void
      {
         this._cachedRange.shift().dispose();
         --this._cacheSize;
         ++this._startCachedIndex;
      }
      
      private function cacheRemoveItemFromTheEnd() : void
      {
         this._cachedRange.pop().dispose();
         --this._cacheSize;
         --this._endCachedIndex;
      }
      
      private function cacheUpdateItem(param1:int, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IDAAPIDataClass = null;
         if(this.hasIndexInCache(param1))
         {
            _loc3_ = this.indexToCacheIndex(param1);
            _loc4_ = this._cachedRange[_loc3_];
            if(_loc4_ is IUpdatable)
            {
               IUpdatable(_loc4_).update(param2);
            }
            else
            {
               _loc4_.dispose();
               _loc4_ = new this._voClass(param2);
               this._cachedRange[_loc3_] = _loc4_;
               if(hasEventListener(ListDataProviderEvent.UPDATE_ITEM))
               {
                  dispatchEvent(new ListDataProviderEvent(ListDataProviderEvent.UPDATE_ITEM,param1,_loc4_));
               }
            }
         }
         else
         {
            this._dataUtils.cleanupDynamicObject(param2);
         }
      }
      
      private function cacheIndexOf(param1:IDAAPIDataClass) : int
      {
         var _loc2_:int = this._cachedRange.indexOf(param1);
         if(_loc2_ != -1)
         {
            _loc2_ += this._startCachedIndex;
         }
         return _loc2_;
      }
      
      private function indexToCacheIndex(param1:int) : int
      {
         return param1 - this._startCachedIndex;
      }
      
      private function createTemporaryItem(param1:uint) : IDAAPIDataClass
      {
         var _loc3_:IDAAPIDataClass = null;
         var _loc2_:Object = this.requestItemAtHandler(param1);
         if(_loc2_ == null)
         {
            App.utils.asserter.assertNotNull(_loc2_,"Requested " + this._voClass + " item with index " + param1 + " not found!");
         }
         _loc3_ = new this._voClass(_loc2_);
         this._itemsToDestroy.push(_loc3_);
         return _loc3_;
      }
      
      public function get length() : uint
      {
         if(this._isLengthValid)
         {
            return this._length;
         }
         if(this._isDAAPIInited)
         {
            this._length = this.lengthHandler();
            this._isLengthValid = true;
            return this._length;
         }
         return 0;
      }
      
      public function get maxCacheSize() : int
      {
         return this._maxCacheSize;
      }
      
      public function set maxCacheSize(param1:int) : void
      {
         this._maxCacheSize = param1;
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      protected function get isValid() : Boolean
      {
         return this._isValid;
      }
   }
}
