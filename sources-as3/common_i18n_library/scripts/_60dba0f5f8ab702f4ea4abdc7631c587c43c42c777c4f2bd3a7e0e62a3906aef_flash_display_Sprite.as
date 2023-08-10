package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _60dba0f5f8ab702f4ea4abdc7631c587c43c42c777c4f2bd3a7e0e62a3906aef_flash_display_Sprite extends Sprite
   {
       
      
      public function _60dba0f5f8ab702f4ea4abdc7631c587c43c42c777c4f2bd3a7e0e62a3906aef_flash_display_Sprite()
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
