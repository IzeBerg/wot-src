package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6773d20413f72a961bb377e55ce95fcf993b48bebe1b1295d7f3b314289e2553_flash_display_Sprite extends Sprite
   {
       
      
      public function _6773d20413f72a961bb377e55ce95fcf993b48bebe1b1295d7f3b314289e2553_flash_display_Sprite()
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
