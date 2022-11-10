package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _66cf2891792bb22885b608b61922afb20e09fc9a8b384b481afa712b86e87c61_flash_display_Sprite extends Sprite
   {
       
      
      public function _66cf2891792bb22885b608b61922afb20e09fc9a8b384b481afa712b86e87c61_flash_display_Sprite()
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
