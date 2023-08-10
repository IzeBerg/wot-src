package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4975f459c16be572e2cefb3a05dd9728b2dde46b15a9633c8fb07ecb18fe8a4e_flash_display_Sprite extends Sprite
   {
       
      
      public function _4975f459c16be572e2cefb3a05dd9728b2dde46b15a9633c8fb07ecb18fe8a4e_flash_display_Sprite()
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
