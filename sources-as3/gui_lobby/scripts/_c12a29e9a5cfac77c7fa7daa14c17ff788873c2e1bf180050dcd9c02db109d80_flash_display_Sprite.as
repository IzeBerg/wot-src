package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c12a29e9a5cfac77c7fa7daa14c17ff788873c2e1bf180050dcd9c02db109d80_flash_display_Sprite extends Sprite
   {
       
      
      public function _c12a29e9a5cfac77c7fa7daa14c17ff788873c2e1bf180050dcd9c02db109d80_flash_display_Sprite()
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
