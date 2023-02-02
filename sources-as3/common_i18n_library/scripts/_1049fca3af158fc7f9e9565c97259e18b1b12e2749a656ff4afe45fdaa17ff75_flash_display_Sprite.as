package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1049fca3af158fc7f9e9565c97259e18b1b12e2749a656ff4afe45fdaa17ff75_flash_display_Sprite extends Sprite
   {
       
      
      public function _1049fca3af158fc7f9e9565c97259e18b1b12e2749a656ff4afe45fdaa17ff75_flash_display_Sprite()
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
