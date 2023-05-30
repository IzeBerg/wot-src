package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _96cd5e080783025fceea2ff24c3fc145ba26352825d6b2fcf1d59e2c403d197f_flash_display_Sprite extends Sprite
   {
       
      
      public function _96cd5e080783025fceea2ff24c3fc145ba26352825d6b2fcf1d59e2c403d197f_flash_display_Sprite()
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
