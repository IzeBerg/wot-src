package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _69bffcff497b82943d4746665e5498f5adc0a7ad9b9c280b89fe728c2a588076_flash_display_Sprite extends Sprite
   {
       
      
      public function _69bffcff497b82943d4746665e5498f5adc0a7ad9b9c280b89fe728c2a588076_flash_display_Sprite()
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
