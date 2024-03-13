package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1c04f9ae00be794bbd67373ede3d00bf5a61c3bc8924d4b066fc2fdeb8c61349_flash_display_Sprite extends Sprite
   {
       
      
      public function _1c04f9ae00be794bbd67373ede3d00bf5a61c3bc8924d4b066fc2fdeb8c61349_flash_display_Sprite()
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
