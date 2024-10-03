package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8f0c009161fc3229cb3f8cec808d6edf040ca431c90f03932a4f13f25f7f68db_flash_display_Sprite extends Sprite
   {
       
      
      public function _8f0c009161fc3229cb3f8cec808d6edf040ca431c90f03932a4f13f25f7f68db_flash_display_Sprite()
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
