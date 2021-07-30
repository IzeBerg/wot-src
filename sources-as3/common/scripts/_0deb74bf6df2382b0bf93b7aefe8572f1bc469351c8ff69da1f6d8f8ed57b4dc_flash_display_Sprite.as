package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0deb74bf6df2382b0bf93b7aefe8572f1bc469351c8ff69da1f6d8f8ed57b4dc_flash_display_Sprite extends Sprite
   {
       
      
      public function _0deb74bf6df2382b0bf93b7aefe8572f1bc469351c8ff69da1f6d8f8ed57b4dc_flash_display_Sprite()
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
