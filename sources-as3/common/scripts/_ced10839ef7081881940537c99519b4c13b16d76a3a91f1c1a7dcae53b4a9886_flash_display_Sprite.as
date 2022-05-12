package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ced10839ef7081881940537c99519b4c13b16d76a3a91f1c1a7dcae53b4a9886_flash_display_Sprite extends Sprite
   {
       
      
      public function _ced10839ef7081881940537c99519b4c13b16d76a3a91f1c1a7dcae53b4a9886_flash_display_Sprite()
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
