package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _faa6afce4ee0cb4733f1e1d6c303512e608d67b53942d375c0a4d09bc3e64d25_flash_display_Sprite extends Sprite
   {
       
      
      public function _faa6afce4ee0cb4733f1e1d6c303512e608d67b53942d375c0a4d09bc3e64d25_flash_display_Sprite()
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
