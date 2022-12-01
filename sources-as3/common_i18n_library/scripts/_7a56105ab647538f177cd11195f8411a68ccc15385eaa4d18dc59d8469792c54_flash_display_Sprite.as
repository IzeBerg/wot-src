package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _7a56105ab647538f177cd11195f8411a68ccc15385eaa4d18dc59d8469792c54_flash_display_Sprite extends Sprite
   {
       
      
      public function _7a56105ab647538f177cd11195f8411a68ccc15385eaa4d18dc59d8469792c54_flash_display_Sprite()
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
