package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _94575ec348fb56468d0f09094e237c6f250151f90a9db98facfb64ea3fc09d93_flash_display_Sprite extends Sprite
   {
       
      
      public function _94575ec348fb56468d0f09094e237c6f250151f90a9db98facfb64ea3fc09d93_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
