package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2d20475a0e9a71cb161beb987b1d8559fba31f8e0603ad6024c0885cbfbd4671_flash_display_Sprite extends Sprite
   {
       
      
      public function _2d20475a0e9a71cb161beb987b1d8559fba31f8e0603ad6024c0885cbfbd4671_flash_display_Sprite()
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
