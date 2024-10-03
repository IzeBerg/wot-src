package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e6cf028332f0c0b6517639d967333a2d97c196ce5fd78a37540a1d14a4a733ed_flash_display_Sprite extends Sprite
   {
       
      
      public function _e6cf028332f0c0b6517639d967333a2d97c196ce5fd78a37540a1d14a4a733ed_flash_display_Sprite()
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
