package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ff3ca433d462e49eb7805c83ed34d0c805b56557a7cd1d4a9d55628e99d0c8b8_flash_display_Sprite extends Sprite
   {
       
      
      public function _ff3ca433d462e49eb7805c83ed34d0c805b56557a7cd1d4a9d55628e99d0c8b8_flash_display_Sprite()
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
