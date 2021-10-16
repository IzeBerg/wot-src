package org.idmedia.as3commons.util
{
   public interface Iterator
   {
       
      
      function hasNext() : Boolean;
      
      function next() : *;
      
      function remove() : void;
   }
}
