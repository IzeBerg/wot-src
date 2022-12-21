package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ce6341eff4547ee1dea519ac5439c948cb246e9d927069a8448af0527862fd43_flash_display_Sprite extends Sprite
   {
       
      
      public function _ce6341eff4547ee1dea519ac5439c948cb246e9d927069a8448af0527862fd43_flash_display_Sprite()
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
