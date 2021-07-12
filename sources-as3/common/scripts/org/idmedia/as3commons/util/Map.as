package org.idmedia.as3commons.util
{
   public interface Map
   {
       
      
      function put(param1:*, param2:*) : *;
      
      function get(param1:*) : *;
      
      function containsKey(param1:*) : Boolean;
      
      function containsValue(param1:*) : Boolean;
      
      function remove(param1:*) : *;
      
      function clear() : void;
      
      function size() : int;
      
      function values() : Collection;
      
      function keySet() : Set;
      
      function entrySet() : Set;
      
      function isEmpty() : Boolean;
      
      function putAll(param1:Map) : void;
   }
}
