package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _85d2876472e7de0096e87e038c767e5c2afd302f272a436c55d9eee3dd8c5a9e_flash_display_Sprite extends Sprite
   {
       
      
      public function _85d2876472e7de0096e87e038c767e5c2afd302f272a436c55d9eee3dd8c5a9e_flash_display_Sprite()
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
