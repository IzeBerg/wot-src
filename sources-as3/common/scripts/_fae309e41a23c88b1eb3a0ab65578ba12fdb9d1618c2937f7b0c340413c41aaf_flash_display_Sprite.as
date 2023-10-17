package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fae309e41a23c88b1eb3a0ab65578ba12fdb9d1618c2937f7b0c340413c41aaf_flash_display_Sprite extends Sprite
   {
       
      
      public function _fae309e41a23c88b1eb3a0ab65578ba12fdb9d1618c2937f7b0c340413c41aaf_flash_display_Sprite()
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
