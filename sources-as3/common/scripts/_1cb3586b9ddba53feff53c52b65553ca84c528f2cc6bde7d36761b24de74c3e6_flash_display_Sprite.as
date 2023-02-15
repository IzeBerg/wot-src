package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1cb3586b9ddba53feff53c52b65553ca84c528f2cc6bde7d36761b24de74c3e6_flash_display_Sprite extends Sprite
   {
       
      
      public function _1cb3586b9ddba53feff53c52b65553ca84c528f2cc6bde7d36761b24de74c3e6_flash_display_Sprite()
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
