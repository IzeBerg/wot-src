package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e2f254da728eb5ebd63852cfd486c3021931d348d7af851f274a5c93e66e0aa4_flash_display_Sprite extends Sprite
   {
       
      
      public function _e2f254da728eb5ebd63852cfd486c3021931d348d7af851f274a5c93e66e0aa4_flash_display_Sprite()
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
