package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _73b689cb64faaf9586b3408bf0e926537922d73553e12fc478d62675f8c8f826_flash_display_Sprite extends Sprite
   {
       
      
      public function _73b689cb64faaf9586b3408bf0e926537922d73553e12fc478d62675f8c8f826_flash_display_Sprite()
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
