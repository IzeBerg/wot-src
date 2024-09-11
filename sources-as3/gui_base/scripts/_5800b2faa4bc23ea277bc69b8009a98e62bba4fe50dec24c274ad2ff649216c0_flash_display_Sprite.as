package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5800b2faa4bc23ea277bc69b8009a98e62bba4fe50dec24c274ad2ff649216c0_flash_display_Sprite extends Sprite
   {
       
      
      public function _5800b2faa4bc23ea277bc69b8009a98e62bba4fe50dec24c274ad2ff649216c0_flash_display_Sprite()
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
