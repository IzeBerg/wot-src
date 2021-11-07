package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ecad940d42ca7cd304ec90d5a0933929902c1729f6dab1d89f712d46dd534ee9_flash_display_Sprite extends Sprite
   {
       
      
      public function _ecad940d42ca7cd304ec90d5a0933929902c1729f6dab1d89f712d46dd534ee9_flash_display_Sprite()
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
