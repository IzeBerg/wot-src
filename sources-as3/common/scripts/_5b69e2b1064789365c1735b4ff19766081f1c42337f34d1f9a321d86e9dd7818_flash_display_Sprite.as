package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5b69e2b1064789365c1735b4ff19766081f1c42337f34d1f9a321d86e9dd7818_flash_display_Sprite extends Sprite
   {
       
      
      public function _5b69e2b1064789365c1735b4ff19766081f1c42337f34d1f9a321d86e9dd7818_flash_display_Sprite()
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
