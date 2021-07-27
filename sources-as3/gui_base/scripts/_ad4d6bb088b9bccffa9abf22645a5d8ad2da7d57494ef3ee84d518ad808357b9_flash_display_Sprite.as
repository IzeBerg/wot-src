package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ad4d6bb088b9bccffa9abf22645a5d8ad2da7d57494ef3ee84d518ad808357b9_flash_display_Sprite extends Sprite
   {
       
      
      public function _ad4d6bb088b9bccffa9abf22645a5d8ad2da7d57494ef3ee84d518ad808357b9_flash_display_Sprite()
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
