package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3c01ae0ea4fcb5ce964521f3ed9a07fdd5727f5e46f3934b9030f9e7e4d4d4a2_flash_display_Sprite extends Sprite
   {
       
      
      public function _3c01ae0ea4fcb5ce964521f3ed9a07fdd5727f5e46f3934b9030f9e7e4d4d4a2_flash_display_Sprite()
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
