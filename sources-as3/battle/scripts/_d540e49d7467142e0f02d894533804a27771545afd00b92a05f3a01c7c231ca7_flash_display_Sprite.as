package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d540e49d7467142e0f02d894533804a27771545afd00b92a05f3a01c7c231ca7_flash_display_Sprite extends Sprite
   {
       
      
      public function _d540e49d7467142e0f02d894533804a27771545afd00b92a05f3a01c7c231ca7_flash_display_Sprite()
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
