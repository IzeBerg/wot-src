package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1b6eaef1b831186dc482e32221bb297b290d7c0d8668dd12c49a6e4972aba6d5_flash_display_Sprite extends Sprite
   {
       
      
      public function _1b6eaef1b831186dc482e32221bb297b290d7c0d8668dd12c49a6e4972aba6d5_flash_display_Sprite()
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
