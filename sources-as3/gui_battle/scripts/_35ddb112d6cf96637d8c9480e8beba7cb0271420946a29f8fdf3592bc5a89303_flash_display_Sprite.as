package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _35ddb112d6cf96637d8c9480e8beba7cb0271420946a29f8fdf3592bc5a89303_flash_display_Sprite extends Sprite
   {
       
      
      public function _35ddb112d6cf96637d8c9480e8beba7cb0271420946a29f8fdf3592bc5a89303_flash_display_Sprite()
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
