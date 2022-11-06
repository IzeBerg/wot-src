package com.adobe.serialization.json
{
   public final class JSONToken
   {
      
      static const token:JSONToken = new JSONToken();
       
      
      public var type:int;
      
      public var value:Object;
      
      public function JSONToken(param1:int = -1, param2:Object = null)
      {
         super();
         this.type = param1;
         this.value = param2;
      }
      
      static function create(param1:int = -1, param2:Object = null) : JSONToken
      {
         token.type = param1;
         token.value = param2;
         return token;
      }
   }
}
