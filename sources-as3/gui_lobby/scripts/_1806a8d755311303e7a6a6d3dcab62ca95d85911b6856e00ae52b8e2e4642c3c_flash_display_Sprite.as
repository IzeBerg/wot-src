package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1806a8d755311303e7a6a6d3dcab62ca95d85911b6856e00ae52b8e2e4642c3c_flash_display_Sprite extends Sprite
   {
       
      
      public function _1806a8d755311303e7a6a6d3dcab62ca95d85911b6856e00ae52b8e2e4642c3c_flash_display_Sprite()
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
