package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e3948a7d62200e78d37039889d27d01930c0a0d6800505390beb984e324eb2b3_flash_display_Sprite extends Sprite
   {
       
      
      public function _e3948a7d62200e78d37039889d27d01930c0a0d6800505390beb984e324eb2b3_flash_display_Sprite()
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
