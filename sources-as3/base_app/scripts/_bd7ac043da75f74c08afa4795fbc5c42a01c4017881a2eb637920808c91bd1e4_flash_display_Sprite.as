package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bd7ac043da75f74c08afa4795fbc5c42a01c4017881a2eb637920808c91bd1e4_flash_display_Sprite extends Sprite
   {
       
      
      public function _bd7ac043da75f74c08afa4795fbc5c42a01c4017881a2eb637920808c91bd1e4_flash_display_Sprite()
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
