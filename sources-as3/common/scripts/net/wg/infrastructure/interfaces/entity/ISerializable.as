package net.wg.infrastructure.interfaces.entity
{
   public interface ISerializable
   {
       
      
      function encode(param1:*) : String;
      
      function decode(param1:String) : Object;
   }
}
