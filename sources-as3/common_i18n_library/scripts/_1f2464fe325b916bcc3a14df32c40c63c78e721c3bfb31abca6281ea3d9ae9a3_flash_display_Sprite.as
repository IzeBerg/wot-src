package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1f2464fe325b916bcc3a14df32c40c63c78e721c3bfb31abca6281ea3d9ae9a3_flash_display_Sprite extends Sprite
   {
       
      
      public function _1f2464fe325b916bcc3a14df32c40c63c78e721c3bfb31abca6281ea3d9ae9a3_flash_display_Sprite()
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
