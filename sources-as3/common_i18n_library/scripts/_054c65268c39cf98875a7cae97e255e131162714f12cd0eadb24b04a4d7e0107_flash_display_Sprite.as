package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _054c65268c39cf98875a7cae97e255e131162714f12cd0eadb24b04a4d7e0107_flash_display_Sprite extends Sprite
   {
       
      
      public function _054c65268c39cf98875a7cae97e255e131162714f12cd0eadb24b04a4d7e0107_flash_display_Sprite()
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
