package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1b4b48bd8b2e5fe6b72a9f59cfb20012b284fc3e0bb7d236134adcfd5659e12a_flash_display_Sprite extends Sprite
   {
       
      
      public function _1b4b48bd8b2e5fe6b72a9f59cfb20012b284fc3e0bb7d236134adcfd5659e12a_flash_display_Sprite()
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
