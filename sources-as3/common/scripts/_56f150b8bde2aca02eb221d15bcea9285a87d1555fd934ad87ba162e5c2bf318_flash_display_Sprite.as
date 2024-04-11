package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _56f150b8bde2aca02eb221d15bcea9285a87d1555fd934ad87ba162e5c2bf318_flash_display_Sprite extends Sprite
   {
       
      
      public function _56f150b8bde2aca02eb221d15bcea9285a87d1555fd934ad87ba162e5c2bf318_flash_display_Sprite()
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
