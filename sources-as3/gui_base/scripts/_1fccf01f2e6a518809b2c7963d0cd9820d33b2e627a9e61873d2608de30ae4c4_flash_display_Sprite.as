package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1fccf01f2e6a518809b2c7963d0cd9820d33b2e627a9e61873d2608de30ae4c4_flash_display_Sprite extends Sprite
   {
       
      
      public function _1fccf01f2e6a518809b2c7963d0cd9820d33b2e627a9e61873d2608de30ae4c4_flash_display_Sprite()
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
