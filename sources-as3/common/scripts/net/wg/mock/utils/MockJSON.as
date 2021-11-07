package net.wg.mock.utils
{
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   
   public class MockJSON implements ISerializable
   {
       
      
      public function MockJSON()
      {
         super();
      }
      
      public function decode(param1:String) : Object
      {
         return null;
      }
      
      public function encode(param1:*) : String
      {
         return "";
      }
   }
}
