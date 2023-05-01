package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _904ee74fe5e2cd711a654af0b8524907e80ae8fa385a6d3af6b9bfc138337224_flash_display_Sprite extends Sprite
   {
       
      
      public function _904ee74fe5e2cd711a654af0b8524907e80ae8fa385a6d3af6b9bfc138337224_flash_display_Sprite()
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
