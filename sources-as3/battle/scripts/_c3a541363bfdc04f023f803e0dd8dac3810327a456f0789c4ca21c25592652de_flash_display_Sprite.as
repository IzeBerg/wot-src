package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c3a541363bfdc04f023f803e0dd8dac3810327a456f0789c4ca21c25592652de_flash_display_Sprite extends Sprite
   {
       
      
      public function _c3a541363bfdc04f023f803e0dd8dac3810327a456f0789c4ca21c25592652de_flash_display_Sprite()
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
