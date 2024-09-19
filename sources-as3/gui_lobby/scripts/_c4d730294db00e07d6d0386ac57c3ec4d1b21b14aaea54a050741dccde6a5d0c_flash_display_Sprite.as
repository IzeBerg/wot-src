package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c4d730294db00e07d6d0386ac57c3ec4d1b21b14aaea54a050741dccde6a5d0c_flash_display_Sprite extends Sprite
   {
       
      
      public function _c4d730294db00e07d6d0386ac57c3ec4d1b21b14aaea54a050741dccde6a5d0c_flash_display_Sprite()
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
