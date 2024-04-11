package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8b6684d11a4def77819e2aa135ff6054692bfbe2afc37622a2f4a7be7fbec7c7_flash_display_Sprite extends Sprite
   {
       
      
      public function _8b6684d11a4def77819e2aa135ff6054692bfbe2afc37622a2f4a7be7fbec7c7_flash_display_Sprite()
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
