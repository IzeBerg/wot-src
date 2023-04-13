package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f80e5601530862b5a26faab038a959a1385ddb25bd85a776a15a4cde83f4a460_flash_display_Sprite extends Sprite
   {
       
      
      public function _f80e5601530862b5a26faab038a959a1385ddb25bd85a776a15a4cde83f4a460_flash_display_Sprite()
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
