package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _09b9f09d7a8c096469c93e5f2f28e099299ab9388f16d013cdc98c61101cf6cd_flash_display_Sprite extends Sprite
   {
       
      
      public function _09b9f09d7a8c096469c93e5f2f28e099299ab9388f16d013cdc98c61101cf6cd_flash_display_Sprite()
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
