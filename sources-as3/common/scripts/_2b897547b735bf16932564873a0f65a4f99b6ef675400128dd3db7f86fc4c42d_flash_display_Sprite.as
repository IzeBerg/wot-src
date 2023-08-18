package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2b897547b735bf16932564873a0f65a4f99b6ef675400128dd3db7f86fc4c42d_flash_display_Sprite extends Sprite
   {
       
      
      public function _2b897547b735bf16932564873a0f65a4f99b6ef675400128dd3db7f86fc4c42d_flash_display_Sprite()
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
