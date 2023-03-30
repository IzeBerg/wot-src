package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _eb1254d457a14bd166880ead2f242be58ad1d108e2c31161505db72ef1f68617_flash_display_Sprite extends Sprite
   {
       
      
      public function _eb1254d457a14bd166880ead2f242be58ad1d108e2c31161505db72ef1f68617_flash_display_Sprite()
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
