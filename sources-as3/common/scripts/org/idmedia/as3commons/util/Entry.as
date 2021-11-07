package org.idmedia.as3commons.util
{
   public interface Entry
   {
       
      
      function getKey() : *;
      
      function getValue() : *;
      
      function setValue(param1:*) : *;
      
      function equals(param1:*) : Boolean;
   }
}
