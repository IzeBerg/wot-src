package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   
   public class AbstractException extends WGGUIException
   {
       
      
      public function AbstractException(param1:* = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
