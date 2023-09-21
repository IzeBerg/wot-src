package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ea7e610fee19ef47cb9363cfbf538729d7f47d8ca0a87b953604f6d5e889334c_flash_display_Sprite extends Sprite
   {
       
      
      public function _ea7e610fee19ef47cb9363cfbf538729d7f47d8ca0a87b953604f6d5e889334c_flash_display_Sprite()
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
