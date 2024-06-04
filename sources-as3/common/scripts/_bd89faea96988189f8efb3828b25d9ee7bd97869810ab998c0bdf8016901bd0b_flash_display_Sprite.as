package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _bd89faea96988189f8efb3828b25d9ee7bd97869810ab998c0bdf8016901bd0b_flash_display_Sprite extends Sprite
   {
       
      
      public function _bd89faea96988189f8efb3828b25d9ee7bd97869810ab998c0bdf8016901bd0b_flash_display_Sprite()
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
