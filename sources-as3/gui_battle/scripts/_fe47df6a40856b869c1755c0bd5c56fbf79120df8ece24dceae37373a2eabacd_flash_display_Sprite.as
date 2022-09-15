package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _fe47df6a40856b869c1755c0bd5c56fbf79120df8ece24dceae37373a2eabacd_flash_display_Sprite extends Sprite
   {
       
      
      public function _fe47df6a40856b869c1755c0bd5c56fbf79120df8ece24dceae37373a2eabacd_flash_display_Sprite()
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
