package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7a06b24a8c914d093b51ab5730d427a7cdaa50d9c3aa102fba7e8dce2f9eea0c_flash_display_Sprite extends Sprite
   {
       
      
      public function _7a06b24a8c914d093b51ab5730d427a7cdaa50d9c3aa102fba7e8dce2f9eea0c_flash_display_Sprite()
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
