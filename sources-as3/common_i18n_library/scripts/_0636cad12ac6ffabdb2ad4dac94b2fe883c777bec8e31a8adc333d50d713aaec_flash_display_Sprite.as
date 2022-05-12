package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0636cad12ac6ffabdb2ad4dac94b2fe883c777bec8e31a8adc333d50d713aaec_flash_display_Sprite extends Sprite
   {
       
      
      public function _0636cad12ac6ffabdb2ad4dac94b2fe883c777bec8e31a8adc333d50d713aaec_flash_display_Sprite()
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
