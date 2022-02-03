package net.wg.data.daapi.base
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DAAPIDataProvider extends EventDispatcher implements IDataProvider, IDAAPIModule
   {
       
      
      public var lengthHandler:Function;
      
      public var requestItemAtHandler:Function;
      
      public var requestItemRangeHandler:Function;
      
      private var _isDAAPIInited:Boolean = false;
      
      public function DAAPIDataProvider()
      {
         super();
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
      
      public function get length() : uint
      {
         if(this.lengthHandler != null)
         {
            return this.lengthHandler();
         }
         return 0;
      }
      
      public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = this.requestItemAtHandler(param1);
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         if(!Boolean(this.requestItemRangeHandler))
         {
            return [];
         }
         var _loc4_:Array = this.requestItemRangeHandler(param1,param2);
         if(param3 != null)
         {
            param3(_loc4_);
         }
         return _loc4_;
      }
      
      public function indexOf(param1:Object, param2:Function = null) : int
      {
         if(param2 != null)
         {
            param2(-1);
         }
         return -1;
      }
      
      public function cleanUp() : void
      {
      }
      
      public function triggerInvalidation() : void
      {
         this.invalidate(this.lengthHandler());
      }
      
      public function invalidate(param1:uint = 0) : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function as_populate() : void
      {
         this._isDAAPIInited = true;
      }
      
      public function as_dispose() : void
      {
         this.dispose();
      }
      
      public final function dispose() : void
      {
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
   }
}
