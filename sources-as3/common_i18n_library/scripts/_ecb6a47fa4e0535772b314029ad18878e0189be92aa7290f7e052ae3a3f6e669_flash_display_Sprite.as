package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ecb6a47fa4e0535772b314029ad18878e0189be92aa7290f7e052ae3a3f6e669_flash_display_Sprite extends Sprite
   {
       
      
      public function _ecb6a47fa4e0535772b314029ad18878e0189be92aa7290f7e052ae3a3f6e669_flash_display_Sprite()
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
