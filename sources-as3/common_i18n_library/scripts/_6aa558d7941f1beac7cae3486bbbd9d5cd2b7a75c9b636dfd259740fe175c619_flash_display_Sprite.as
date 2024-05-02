package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6aa558d7941f1beac7cae3486bbbd9d5cd2b7a75c9b636dfd259740fe175c619_flash_display_Sprite extends Sprite
   {
       
      
      public function _6aa558d7941f1beac7cae3486bbbd9d5cd2b7a75c9b636dfd259740fe175c619_flash_display_Sprite()
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
