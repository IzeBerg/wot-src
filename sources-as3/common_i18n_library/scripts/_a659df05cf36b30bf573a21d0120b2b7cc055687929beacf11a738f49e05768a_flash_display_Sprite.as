package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a659df05cf36b30bf573a21d0120b2b7cc055687929beacf11a738f49e05768a_flash_display_Sprite extends Sprite
   {
       
      
      public function _a659df05cf36b30bf573a21d0120b2b7cc055687929beacf11a738f49e05768a_flash_display_Sprite()
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
