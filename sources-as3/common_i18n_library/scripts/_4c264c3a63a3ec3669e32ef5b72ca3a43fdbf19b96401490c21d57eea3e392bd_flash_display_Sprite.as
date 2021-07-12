package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4c264c3a63a3ec3669e32ef5b72ca3a43fdbf19b96401490c21d57eea3e392bd_flash_display_Sprite extends Sprite
   {
       
      
      public function _4c264c3a63a3ec3669e32ef5b72ca3a43fdbf19b96401490c21d57eea3e392bd_flash_display_Sprite()
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
