package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   
   public class AssertionException extends WGGUIException
   {
       
      
      public function AssertionException(param1:* = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
