package org.idmedia.as3commons.lang
{
   import flash.utils.getQualifiedClassName;
   
   public class Throwable extends Error
   {
       
      
      public function Throwable(param1:String)
      {
         super(param1);
      }
      
      public function getMessage() : String
      {
         return message;
      }
      
      public function getName() : String
      {
         return getQualifiedClassName(this);
      }
   }
}
