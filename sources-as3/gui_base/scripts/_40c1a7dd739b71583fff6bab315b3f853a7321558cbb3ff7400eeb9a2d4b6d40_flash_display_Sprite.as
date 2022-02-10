package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _40c1a7dd739b71583fff6bab315b3f853a7321558cbb3ff7400eeb9a2d4b6d40_flash_display_Sprite extends Sprite
   {
       
      
      public function _40c1a7dd739b71583fff6bab315b3f853a7321558cbb3ff7400eeb9a2d4b6d40_flash_display_Sprite()
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
