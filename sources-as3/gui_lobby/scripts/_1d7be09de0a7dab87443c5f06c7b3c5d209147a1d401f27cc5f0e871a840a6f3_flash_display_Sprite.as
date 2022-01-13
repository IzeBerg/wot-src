package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1d7be09de0a7dab87443c5f06c7b3c5d209147a1d401f27cc5f0e871a840a6f3_flash_display_Sprite extends Sprite
   {
       
      
      public function _1d7be09de0a7dab87443c5f06c7b3c5d209147a1d401f27cc5f0e871a840a6f3_flash_display_Sprite()
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
