package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1e90c2e8c6a734f1c8b99ed0218661ee08da16a7d313ed65fcebb9ff09f9a41b_flash_display_Sprite extends Sprite
   {
       
      
      public function _1e90c2e8c6a734f1c8b99ed0218661ee08da16a7d313ed65fcebb9ff09f9a41b_flash_display_Sprite()
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
