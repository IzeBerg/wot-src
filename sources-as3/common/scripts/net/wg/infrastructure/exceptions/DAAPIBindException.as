package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   
   public class DAAPIBindException extends WGGUIException
   {
       
      
      public function DAAPIBindException(param1:* = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
