package net.wg.data.VO
{
   import flash.events.Event;
   import net.wg.data.ListDAAPIDataProvider;
   
   public class FilterDAAPIDataProvider extends ListDAAPIDataProvider
   {
       
      
      private var _isFilter:Boolean = false;
      
      private var _filteredItems:Array = null;
      
      private var _isCache:Boolean = false;
      
      public function FilterDAAPIDataProvider(param1:Class)
      {
         super(param1);
      }
      
      override public function as_populate() : void
      {
         super.as_populate();
         this._filteredItems = [];
      }
      
      override public function invalidate(param1:uint = 0) : void
      {
         if(param1 == 0)
         {
            this._isFilter = false;
         }
         super.invalidate(param1);
      }
      
      override protected function callInvalidateActions() : void
      {
         this.createCache();
         super.callInvalidateActions();
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = null;
         if(this._isFilter)
         {
            _loc3_ = this._filteredItems[param1];
            if(param2 != null)
            {
               param2(_loc3_);
            }
            return _loc3_;
         }
         return super.requestItemAt(param1,param2);
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc4_:Array = null;
         if(this._isFilter)
         {
            _loc4_ = this._filteredItems.slice(param1,param2);
            if(param3 != null)
            {
               param3(_loc4_);
            }
            return _loc4_;
         }
         return super.requestItemRange(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         this._isFilter = false;
         this._filteredItems.splice(0,this._filteredItems.length);
         this._filteredItems = null;
         super.onDispose();
      }
      
      public function as_setFilter(param1:Object) : void
      {
         var _loc2_:Array = param1 as Array;
         App.utils.asserter.assertNotNull(_loc2_,"filter must be Array");
         if(!this._isCache)
         {
            this.createCache();
         }
         var _loc3_:int = _loc2_.length;
         this._filteredItems.length = _loc3_;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._filteredItems[_loc4_] = super.requestItemAt(_loc2_[_loc4_]);
            _loc4_++;
         }
         this._isFilter = true;
         if(hasEventListener(Event.CHANGE))
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      private function createCache() : void
      {
         super.requestItemRange(0,super.length);
         this._isCache = true;
      }
      
      override public function get length() : uint
      {
         if(this._isFilter && this._filteredItems != null)
         {
            return this._filteredItems.length;
         }
         return super.length;
      }
   }
}
