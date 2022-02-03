package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b75d574b5520579d4e164c0686986ad2c6642b6468eedfa196cfba6e6571af24_flash_display_Sprite extends Sprite
   {
       
      
      public function _b75d574b5520579d4e164c0686986ad2c6642b6468eedfa196cfba6e6571af24_flash_display_Sprite()
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
