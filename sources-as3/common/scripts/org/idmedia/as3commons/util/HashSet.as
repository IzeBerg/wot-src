package org.idmedia.as3commons.util
{
   public class HashSet extends AbstractSet
   {
      
      private static var PRESENT:Object = new Object();
       
      
      private var map:HashMap;
      
      public function HashSet(param1:Map = null)
      {
         super();
         this.map = new HashMap();
         if(param1)
         {
            this.map.putAll(param1);
         }
      }
      
      override public function iterator() : Iterator
      {
         return this.map.keySet().iterator();
      }
      
      override public function size() : int
      {
         return this.map.size();
      }
      
      override public function isEmpty() : Boolean
      {
         return this.map.isEmpty();
      }
      
      override public function contains(param1:*) : Boolean
      {
         return this.map.containsKey(param1);
      }
      
      override public function add(param1:*) : Boolean
      {
         return this.map.put(param1,PRESENT) == null;
      }
      
      override public function remove(param1:* = null) : Boolean
      {
         return this.map.remove(param1) == PRESENT;
      }
      
      override public function clear() : void
      {
         this.map.clear();
      }
   }
}
