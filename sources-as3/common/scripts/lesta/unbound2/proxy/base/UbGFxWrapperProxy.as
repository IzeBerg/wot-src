package lesta.unbound2.proxy.base
{
   public class UbGFxWrapperProxy extends UbProxy
   {
       
      
      public var p_pushError:Function;
      
      public function UbGFxWrapperProxy()
      {
         super();
      }
      
      public function pushError(param1:String) : void
      {
         this.p_pushError(param1);
      }
   }
}
