package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d372d722e7f7ca2c19ac741ea565435adc34fe461d559d880b1cef9cf14dd0bd_flash_display_Sprite extends Sprite
   {
       
      
      public function _d372d722e7f7ca2c19ac741ea565435adc34fe461d559d880b1cef9cf14dd0bd_flash_display_Sprite()
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
