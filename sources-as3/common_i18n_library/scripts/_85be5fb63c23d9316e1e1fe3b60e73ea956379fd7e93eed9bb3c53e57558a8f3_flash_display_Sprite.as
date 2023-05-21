package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _85be5fb63c23d9316e1e1fe3b60e73ea956379fd7e93eed9bb3c53e57558a8f3_flash_display_Sprite extends Sprite
   {
       
      
      public function _85be5fb63c23d9316e1e1fe3b60e73ea956379fd7e93eed9bb3c53e57558a8f3_flash_display_Sprite()
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
