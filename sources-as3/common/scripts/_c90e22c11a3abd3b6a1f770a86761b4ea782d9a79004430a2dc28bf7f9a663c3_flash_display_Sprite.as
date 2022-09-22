package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c90e22c11a3abd3b6a1f770a86761b4ea782d9a79004430a2dc28bf7f9a663c3_flash_display_Sprite extends Sprite
   {
       
      
      public function _c90e22c11a3abd3b6a1f770a86761b4ea782d9a79004430a2dc28bf7f9a663c3_flash_display_Sprite()
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
