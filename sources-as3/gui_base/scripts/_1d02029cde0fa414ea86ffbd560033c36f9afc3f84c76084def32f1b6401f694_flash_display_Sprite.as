package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1d02029cde0fa414ea86ffbd560033c36f9afc3f84c76084def32f1b6401f694_flash_display_Sprite extends Sprite
   {
       
      
      public function _1d02029cde0fa414ea86ffbd560033c36f9afc3f84c76084def32f1b6401f694_flash_display_Sprite()
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
