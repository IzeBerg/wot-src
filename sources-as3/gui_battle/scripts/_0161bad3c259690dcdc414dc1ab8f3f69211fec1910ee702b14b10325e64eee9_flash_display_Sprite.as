package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0161bad3c259690dcdc414dc1ab8f3f69211fec1910ee702b14b10325e64eee9_flash_display_Sprite extends Sprite
   {
       
      
      public function _0161bad3c259690dcdc414dc1ab8f3f69211fec1910ee702b14b10325e64eee9_flash_display_Sprite()
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
