package net.wg.infrastructure.managers.utils.impl
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.adobe.serialization.json.JSONEncoder;
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   
   public class WGJSON implements ISerializable
   {
       
      
      public function WGJSON()
      {
         super();
      }
      
      public function encode(param1:*) : String
      {
         return new JSONEncoder(param1).getString();
      }
      
      public function decode(param1:String) : Object
      {
         return new JSONDecoder(param1,true).getValue();
      }
   }
}
