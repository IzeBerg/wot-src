package org.idmedia.as3commons.util
{
   public interface ListIterator extends Iterator
   {
       
      
      function setIndex(param1:int) : void;
      
      function hasPrevious() : Boolean;
      
      function previous() : *;
      
      function nextIndex() : int;
      
      function previousIndex() : int;
      
      function setValue(param1:*) : void;
      
      function add(param1:*) : void;
   }
}
