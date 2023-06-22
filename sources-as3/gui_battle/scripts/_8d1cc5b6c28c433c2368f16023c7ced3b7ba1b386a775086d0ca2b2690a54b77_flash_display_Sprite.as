package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _8d1cc5b6c28c433c2368f16023c7ced3b7ba1b386a775086d0ca2b2690a54b77_flash_display_Sprite extends Sprite
   {
       
      
      public function _8d1cc5b6c28c433c2368f16023c7ced3b7ba1b386a775086d0ca2b2690a54b77_flash_display_Sprite()
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
