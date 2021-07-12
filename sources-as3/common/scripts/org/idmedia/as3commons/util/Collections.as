package org.idmedia.as3commons.util
{
   public class Collections
   {
       
      
      public function Collections()
      {
         super();
      }
      
      public static function sort(param1:List, param2:Comparator) : void
      {
         var _loc3_:Array = param1.toArray();
         Arrays.sort(_loc3_,param2);
         var _loc4_:ListIterator = param1.listIterator();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_.next();
            _loc4_.setValue(_loc3_[_loc5_]);
            _loc5_++;
         }
      }
   }
}
