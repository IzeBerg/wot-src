package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8bf2fe68898c6f7af4e44fcd6745cf7beff492e7e325197b9a8f12f0c338b7fe_flash_display_Sprite extends Sprite
   {
       
      
      public function _8bf2fe68898c6f7af4e44fcd6745cf7beff492e7e325197b9a8f12f0c338b7fe_flash_display_Sprite()
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
