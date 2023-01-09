package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e361a78f08b68a920aa4ed14aaf1de5d62fec0182d69e101cd6c7310c99c0df8_flash_display_Sprite extends Sprite
   {
       
      
      public function _e361a78f08b68a920aa4ed14aaf1de5d62fec0182d69e101cd6c7310c99c0df8_flash_display_Sprite()
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
