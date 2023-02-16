package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d9da29dda7b730f765a4342138acd39ba5b7e521a6824171277d9084ab1a9c7b_flash_display_Sprite extends Sprite
   {
       
      
      public function _d9da29dda7b730f765a4342138acd39ba5b7e521a6824171277d9084ab1a9c7b_flash_display_Sprite()
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
