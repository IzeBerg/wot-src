package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ed9bea38b36d794f643c697f09651aaa9a9e430ddaff50bb194bec5e2454fcd8_flash_display_Sprite extends Sprite
   {
       
      
      public function _ed9bea38b36d794f643c697f09651aaa9a9e430ddaff50bb194bec5e2454fcd8_flash_display_Sprite()
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
