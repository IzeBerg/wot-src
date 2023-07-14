package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fbeeb5635c8929af8b1344abc6f066b1229cbfcfb15c7771ce19d6ecde2ecc33_flash_display_Sprite extends Sprite
   {
       
      
      public function _fbeeb5635c8929af8b1344abc6f066b1229cbfcfb15c7771ce19d6ecde2ecc33_flash_display_Sprite()
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
