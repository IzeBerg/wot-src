package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a5c4bdcf2f5dbee3483b1c1762c402653a146768f9dca371546564ed1c07a5f1_flash_display_Sprite extends Sprite
   {
       
      
      public function _a5c4bdcf2f5dbee3483b1c1762c402653a146768f9dca371546564ed1c07a5f1_flash_display_Sprite()
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
