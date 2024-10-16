package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _01b9eaacd7750f0c872a300846f7f43bca71c9cbc533d00cb8fb5e638999414b_flash_display_Sprite extends Sprite
   {
       
      
      public function _01b9eaacd7750f0c872a300846f7f43bca71c9cbc533d00cb8fb5e638999414b_flash_display_Sprite()
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
