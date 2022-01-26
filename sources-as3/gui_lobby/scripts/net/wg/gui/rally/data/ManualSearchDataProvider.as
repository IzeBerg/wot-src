package net.wg.gui.rally.data
{
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
   import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
   
   public class ManualSearchDataProvider extends SortableVoDAAPIDataProvider implements IManualSearchDataProvider
   {
       
      
      public var requestUpdatedItemsHandler:Function;
      
      private var indexes:Array;
      
      private var cache:Array;
      
      public function ManualSearchDataProvider(param1:Class)
      {
         this.indexes = [];
         this.cache = [];
         super(param1);
      }
      
      override public function cleanUp() : void
      {
         this.cache = [];
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = this.cache[param1];
         if(!_loc3_)
         {
            _loc3_ = super.requestItemAt(param1,param2);
         }
         else if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc7_:Object = null;
         var _loc10_:Object = null;
         if(!Boolean(requestItemRangeHandler))
         {
            return [];
         }
         var _loc4_:Array = this.cache.slice(param1,param2 + 1);
         var _loc5_:uint = 0;
         var _loc6_:uint = _loc4_.length;
         var _loc8_:Array = [];
         var _loc9_:uint = param1;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc4_[_loc5_];
            if(!_loc7_)
            {
               break;
            }
            _loc8_.push(_loc7_);
            _loc9_ = param1 + _loc5_ + 1;
            _loc5_++;
         }
         if(_loc9_ <= param2)
         {
            _loc4_ = requestItemRangeHandler(_loc9_,param2);
            _loc6_ = _loc4_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc10_ = new voClass(_loc7_);
               this.cache[_loc9_ + _loc5_] = _loc10_;
               _loc8_.push(_loc10_);
               _loc5_++;
            }
         }
         if(param3 != null)
         {
            param3(_loc8_);
         }
         return _loc8_;
      }
      
      public function requestUpdatedItems(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc4_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         if(!Boolean(this.requestUpdatedItemsHandler))
         {
            return [];
         }
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         for each(_loc4_ in this.indexes)
         {
            if(param1 <= _loc4_ && _loc4_ <= param2)
            {
               _loc5_.push(_loc4_);
            }
         }
         if(_loc5_.length)
         {
            _loc7_ = this.requestUpdatedItemsHandler(_loc5_);
            _loc10_ = _loc7_.length;
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc8_ = _loc7_[_loc11_];
               _loc4_ = _loc8_[0];
               _loc9_ = new voClass(_loc8_[1]);
               this.cache[_loc4_] = _loc9_;
               _loc6_.push([_loc4_,_loc9_]);
               _loc11_++;
            }
         }
         if(param3 != null)
         {
            param3(_loc6_);
         }
         return _loc6_;
      }
      
      override public function invalidate(param1:uint = 0) : void
      {
         this.cache = new Array(param1);
         super.invalidate(param1);
      }
      
      public function update(param1:Array) : void
      {
         var _loc2_:uint = 0;
         this.indexes = param1;
         for each(_loc2_ in this.indexes)
         {
            this.cache[_loc2_] = undefined;
         }
         dispatchEvent(new ManualSearchEvent(ManualSearchEvent.DATA_UPDATED));
      }
   }
}
