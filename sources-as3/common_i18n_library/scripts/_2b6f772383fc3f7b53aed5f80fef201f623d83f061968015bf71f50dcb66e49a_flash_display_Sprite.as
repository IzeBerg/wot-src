package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2b6f772383fc3f7b53aed5f80fef201f623d83f061968015bf71f50dcb66e49a_flash_display_Sprite extends Sprite
   {
       
      
      public function _2b6f772383fc3f7b53aed5f80fef201f623d83f061968015bf71f50dcb66e49a_flash_display_Sprite()
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
