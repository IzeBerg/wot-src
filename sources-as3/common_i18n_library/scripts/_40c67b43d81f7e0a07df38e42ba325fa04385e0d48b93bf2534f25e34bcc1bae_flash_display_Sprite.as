package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _40c67b43d81f7e0a07df38e42ba325fa04385e0d48b93bf2534f25e34bcc1bae_flash_display_Sprite extends Sprite
   {
       
      
      public function _40c67b43d81f7e0a07df38e42ba325fa04385e0d48b93bf2534f25e34bcc1bae_flash_display_Sprite()
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
