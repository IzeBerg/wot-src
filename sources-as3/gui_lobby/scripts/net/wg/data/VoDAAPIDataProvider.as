package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;
   
   public class VoDAAPIDataProvider extends DAAPIDataProvider
   {
       
      
      protected var voClass:Class;
      
      public function VoDAAPIDataProvider(param1:Class)
      {
         this.voClass = param1;
         super();
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = requestItemAtHandler(param1);
         if(_loc3_ != null)
         {
            _loc3_ = new this.voClass(_loc3_);
         }
         if(param2 != null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc6_:Object = null;
         if(!Boolean(requestItemRangeHandler))
         {
            return [];
         }
         var _loc4_:Array = requestItemRangeHandler(param1,param2);
         var _loc5_:Array = [];
         for each(_loc6_ in _loc4_)
         {
            _loc5_.push(new this.voClass(_loc6_));
         }
         if(param3 != null)
         {
            param3(_loc5_);
         }
         return _loc5_;
      }
   }
}
