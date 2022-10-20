package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1fcc06700ed09e239d34f2dae81f3e9df38c616adcc3ae5e3feabb4d59448043_flash_display_Sprite extends Sprite
   {
       
      
      public function _1fcc06700ed09e239d34f2dae81f3e9df38c616adcc3ae5e3feabb4d59448043_flash_display_Sprite()
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
