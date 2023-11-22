package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _216150e48c9f7943873a546059ddee395ca1d4ce9c1f58f65a8fa930b311c5fa_flash_display_Sprite extends Sprite
   {
       
      
      public function _216150e48c9f7943873a546059ddee395ca1d4ce9c1f58f65a8fa930b311c5fa_flash_display_Sprite()
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
