package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _83b14abb401c7691c726a8d76af176c00154438a659036d95e3456364e2dd53a_flash_display_Sprite extends Sprite
   {
       
      
      public function _83b14abb401c7691c726a8d76af176c00154438a659036d95e3456364e2dd53a_flash_display_Sprite()
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
