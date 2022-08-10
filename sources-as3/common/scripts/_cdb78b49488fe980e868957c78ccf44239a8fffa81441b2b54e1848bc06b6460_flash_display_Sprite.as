package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _cdb78b49488fe980e868957c78ccf44239a8fffa81441b2b54e1848bc06b6460_flash_display_Sprite extends Sprite
   {
       
      
      public function _cdb78b49488fe980e868957c78ccf44239a8fffa81441b2b54e1848bc06b6460_flash_display_Sprite()
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
