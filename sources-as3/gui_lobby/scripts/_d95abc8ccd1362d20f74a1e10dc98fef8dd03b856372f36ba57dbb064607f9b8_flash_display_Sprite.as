package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d95abc8ccd1362d20f74a1e10dc98fef8dd03b856372f36ba57dbb064607f9b8_flash_display_Sprite extends Sprite
   {
       
      
      public function _d95abc8ccd1362d20f74a1e10dc98fef8dd03b856372f36ba57dbb064607f9b8_flash_display_Sprite()
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
