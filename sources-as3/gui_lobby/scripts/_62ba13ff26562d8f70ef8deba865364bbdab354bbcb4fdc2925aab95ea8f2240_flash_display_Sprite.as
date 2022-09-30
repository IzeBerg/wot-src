package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _62ba13ff26562d8f70ef8deba865364bbdab354bbcb4fdc2925aab95ea8f2240_flash_display_Sprite extends Sprite
   {
       
      
      public function _62ba13ff26562d8f70ef8deba865364bbdab354bbcb4fdc2925aab95ea8f2240_flash_display_Sprite()
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
