package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c59ad583447216faa9dd8f1d5de3ce75e1618b5fac7a1535c039e64e7c705011_flash_display_Sprite extends Sprite
   {
       
      
      public function _c59ad583447216faa9dd8f1d5de3ce75e1618b5fac7a1535c039e64e7c705011_flash_display_Sprite()
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
