package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _144915d486b3a72ba5e8d0b035215ad906b8917d201e2202eab7b74e1092021f_flash_display_Sprite extends Sprite
   {
       
      
      public function _144915d486b3a72ba5e8d0b035215ad906b8917d201e2202eab7b74e1092021f_flash_display_Sprite()
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
