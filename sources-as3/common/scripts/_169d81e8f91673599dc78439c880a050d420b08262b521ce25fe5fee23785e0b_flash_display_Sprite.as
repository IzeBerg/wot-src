package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _169d81e8f91673599dc78439c880a050d420b08262b521ce25fe5fee23785e0b_flash_display_Sprite extends Sprite
   {
       
      
      public function _169d81e8f91673599dc78439c880a050d420b08262b521ce25fe5fee23785e0b_flash_display_Sprite()
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
