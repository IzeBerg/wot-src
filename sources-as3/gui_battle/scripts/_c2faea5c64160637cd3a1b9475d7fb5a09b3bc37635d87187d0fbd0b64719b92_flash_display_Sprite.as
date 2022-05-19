package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c2faea5c64160637cd3a1b9475d7fb5a09b3bc37635d87187d0fbd0b64719b92_flash_display_Sprite extends Sprite
   {
       
      
      public function _c2faea5c64160637cd3a1b9475d7fb5a09b3bc37635d87187d0fbd0b64719b92_flash_display_Sprite()
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
