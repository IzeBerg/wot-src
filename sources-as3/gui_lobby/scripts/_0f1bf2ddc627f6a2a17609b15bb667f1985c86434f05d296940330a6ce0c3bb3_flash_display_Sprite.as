package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0f1bf2ddc627f6a2a17609b15bb667f1985c86434f05d296940330a6ce0c3bb3_flash_display_Sprite extends Sprite
   {
       
      
      public function _0f1bf2ddc627f6a2a17609b15bb667f1985c86434f05d296940330a6ce0c3bb3_flash_display_Sprite()
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
