package net.wg.infrastructure.exceptions
{
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   
   public class InfrastructureException extends WGGUIException
   {
       
      
      public function InfrastructureException(param1:String = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
