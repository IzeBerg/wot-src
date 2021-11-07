package scaleform.clik.utils
{
   import flash.utils.Dictionary;
   
   public class WeakReference
   {
       
      
      protected var _dictionary:Dictionary;
      
      public function WeakReference(param1:Object)
      {
         super();
         this._dictionary = new Dictionary(true);
         this._dictionary[param1] = 1;
      }
      
      public function get value() : Object
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = this._dictionary;
         for(_loc1_ in _loc3_)
         {
            return _loc1_;
         }
         return null;
      }
   }
}
