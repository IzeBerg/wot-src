package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _06424c31f9ce7a38bf990556f759621846033f2107514f441d1f93f1f6d4c75f_flash_display_Sprite extends Sprite
   {
       
      
      public function _06424c31f9ce7a38bf990556f759621846033f2107514f441d1f93f1f6d4c75f_flash_display_Sprite()
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
