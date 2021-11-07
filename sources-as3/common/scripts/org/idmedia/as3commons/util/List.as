package org.idmedia.as3commons.util
{
   public interface List extends Collection
   {
       
      
      function addAt(param1:int, param2:*) : Boolean;
      
      function setAt(param1:int, param2:*) : Boolean;
      
      function get(param1:int) : *;
      
      function listIterator() : ListIterator;
      
      function indexedListIterator(param1:uint) : ListIterator;
      
      function removeAt(param1:int) : Boolean;
      
      function removeAtAndReturn(param1:int) : *;
      
      function removeAtTo(param1:int, param2:int) : Boolean;
      
      function indexOf(param1:* = null) : int;
   }
}
