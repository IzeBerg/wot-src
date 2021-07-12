package scaleform.clik.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import scaleform.clik.interfaces.IDataProvider;
   
   [Event(name="change",type="flash.events.Event")]
   public dynamic class DataProvider extends Array implements IDataProvider, IEventDispatcher
   {
       
      
      protected var dispatcher:EventDispatcher;
      
      public function DataProvider(param1:Array = null)
      {
         super();
         this.dispatcher = new EventDispatcher(this);
         this.parseSource(param1);
      }
      
      public function indexOf(param1:Object, param2:Function = null) : int
      {
         var _loc3_:int = super.indexOf(param1);
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = this[param1];
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc4_:Array = this.slice(param1,param2 + 1);
         if(param3 != null)
         {
            param3(_loc4_);
         }
         return _loc4_;
      }
      
      public function cleanUp() : void
      {
         this.splice(0,length);
      }
      
      public function invalidate(param1:uint = 0) : void
      {
         this.dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function setSource(param1:Array) : void
      {
         this.parseSource(param1);
      }
      
      public function toString() : String
      {
         return "[CLIK DataProvider " + this.join(",") + "]";
      }
      
      protected function parseSource(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:uint = param1.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.dispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.dispatcher.willTrigger(param1);
      }
   }
}
