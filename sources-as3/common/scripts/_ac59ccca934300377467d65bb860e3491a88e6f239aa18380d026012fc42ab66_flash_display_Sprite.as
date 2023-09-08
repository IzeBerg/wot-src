package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ac59ccca934300377467d65bb860e3491a88e6f239aa18380d026012fc42ab66_flash_display_Sprite extends Sprite
   {
       
      
      public function _ac59ccca934300377467d65bb860e3491a88e6f239aa18380d026012fc42ab66_flash_display_Sprite()
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
