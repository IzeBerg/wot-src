package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   
   public class NullPointerException extends WGGUIException
   {
       
      
      public function NullPointerException(param1:* = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
