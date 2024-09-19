package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ed0dbf9302f87da9344207b16755af6f640d6e6bff00a2e7f51e8ad33bcdd6eb_flash_display_Sprite extends Sprite
   {
       
      
      public function _ed0dbf9302f87da9344207b16755af6f640d6e6bff00a2e7f51e8ad33bcdd6eb_flash_display_Sprite()
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
