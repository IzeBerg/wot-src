package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e53d6335c9d28dd4b8306a45b16b55e76ada3b5cf50ef797f30c1358f7d8350e_flash_display_Sprite extends Sprite
   {
       
      
      public function _e53d6335c9d28dd4b8306a45b16b55e76ada3b5cf50ef797f30c1358f7d8350e_flash_display_Sprite()
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
