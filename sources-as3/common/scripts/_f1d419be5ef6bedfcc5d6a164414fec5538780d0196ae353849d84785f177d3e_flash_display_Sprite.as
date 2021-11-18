package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f1d419be5ef6bedfcc5d6a164414fec5538780d0196ae353849d84785f177d3e_flash_display_Sprite extends Sprite
   {
       
      
      public function _f1d419be5ef6bedfcc5d6a164414fec5538780d0196ae353849d84785f177d3e_flash_display_Sprite()
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
