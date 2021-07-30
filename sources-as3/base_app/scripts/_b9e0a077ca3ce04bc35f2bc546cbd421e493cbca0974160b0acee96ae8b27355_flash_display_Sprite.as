package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b9e0a077ca3ce04bc35f2bc546cbd421e493cbca0974160b0acee96ae8b27355_flash_display_Sprite extends Sprite
   {
       
      
      public function _b9e0a077ca3ce04bc35f2bc546cbd421e493cbca0974160b0acee96ae8b27355_flash_display_Sprite()
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
