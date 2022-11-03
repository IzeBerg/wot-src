package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _44581fa036736d882ebe0aea5f1b254f2a71b492c20f515d663d92e72ba7f41c_flash_display_Sprite extends Sprite
   {
       
      
      public function _44581fa036736d882ebe0aea5f1b254f2a71b492c20f515d663d92e72ba7f41c_flash_display_Sprite()
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
