package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _32228f7e5efc6a44e3d9ecb1e6d11fea169306bcb7b7685cde34f754d8f788c6_flash_display_Sprite extends Sprite
   {
       
      
      public function _32228f7e5efc6a44e3d9ecb1e6d11fea169306bcb7b7685cde34f754d8f788c6_flash_display_Sprite()
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
