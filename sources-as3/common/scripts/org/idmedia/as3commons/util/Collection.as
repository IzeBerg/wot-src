package org.idmedia.as3commons.util
{
   public interface Collection
   {
       
      
      function add(param1:*) : Boolean;
      
      function clear() : void;
      
      function contains(param1:*) : Boolean;
      
      function containsAll(param1:Collection) : Boolean;
      
      function addAll(param1:Collection) : Boolean;
      
      function isEmpty() : Boolean;
      
      function iterator() : Iterator;
      
      function remove(param1:* = null) : Boolean;
      
      function size() : int;
      
      function toArray() : Array;
   }
}
