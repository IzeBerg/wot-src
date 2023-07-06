package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _92cf295aa75a8b1cc5bb63e89580831d630f13903214cdc087af65e03e9cd1ea_flash_display_Sprite extends Sprite
   {
       
      
      public function _92cf295aa75a8b1cc5bb63e89580831d630f13903214cdc087af65e03e9cd1ea_flash_display_Sprite()
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
