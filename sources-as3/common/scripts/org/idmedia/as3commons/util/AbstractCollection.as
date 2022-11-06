package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.UnsupportedOperationException;
   
   public class AbstractCollection implements Collection
   {
       
      
      public function AbstractCollection()
      {
         super();
      }
      
      public function add(param1:*) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      public function addAll(param1:Collection) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Iterator = param1.iterator();
         while(_loc3_.hasNext())
         {
            if(this.add(_loc3_.next()))
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         var _loc1_:Iterator = this.iterator();
         while(_loc1_.hasNext())
         {
            _loc1_.next();
            _loc1_.remove();
         }
      }
      
      public function contains(param1:*) : Boolean
      {
         return this.toArray().indexOf(param1) > -1;
      }
      
      public function containsAll(param1:Collection) : Boolean
      {
         var _loc2_:Iterator = param1.iterator();
         while(_loc2_.hasNext())
         {
            if(!this.contains(_loc2_.next()))
            {
               return false;
            }
         }
         return true;
      }
      
      public function isEmpty() : Boolean
      {
         return this.size() == 0;
      }
      
      public function iterator() : Iterator
      {
         return null;
      }
      
      public function remove(param1:* = null) : Boolean
      {
         var _loc2_:Iterator = this.iterator();
         while(_loc2_.hasNext())
         {
            if(_loc2_.next() == param1)
            {
               _loc2_.remove();
               return true;
            }
         }
         return false;
      }
      
      public function size() : int
      {
         return 0;
      }
      
      public function toArray() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:Iterator = this.iterator();
         while(_loc2_.hasNext())
         {
            _loc1_.push(_loc2_.next());
         }
         return _loc1_;
      }
      
      public function equals(param1:*) : Boolean
      {
         return param1 === this;
      }
   }
}
