package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7478ab0ab6b7bde4f139da5f81f1f487c2ebd751f410c8aae8beccb2452d4702_flash_display_Sprite extends Sprite
   {
       
      
      public function _7478ab0ab6b7bde4f139da5f81f1f487c2ebd751f410c8aae8beccb2452d4702_flash_display_Sprite()
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
