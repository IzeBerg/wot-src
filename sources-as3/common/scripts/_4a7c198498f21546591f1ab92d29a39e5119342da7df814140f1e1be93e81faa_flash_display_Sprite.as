package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4a7c198498f21546591f1ab92d29a39e5119342da7df814140f1e1be93e81faa_flash_display_Sprite extends Sprite
   {
       
      
      public function _4a7c198498f21546591f1ab92d29a39e5119342da7df814140f1e1be93e81faa_flash_display_Sprite()
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
