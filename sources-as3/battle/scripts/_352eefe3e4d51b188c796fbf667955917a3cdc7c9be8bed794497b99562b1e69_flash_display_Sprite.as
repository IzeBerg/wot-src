package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _352eefe3e4d51b188c796fbf667955917a3cdc7c9be8bed794497b99562b1e69_flash_display_Sprite extends Sprite
   {
       
      
      public function _352eefe3e4d51b188c796fbf667955917a3cdc7c9be8bed794497b99562b1e69_flash_display_Sprite()
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
