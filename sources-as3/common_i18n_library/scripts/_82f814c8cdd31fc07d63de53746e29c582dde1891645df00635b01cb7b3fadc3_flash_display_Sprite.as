package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _82f814c8cdd31fc07d63de53746e29c582dde1891645df00635b01cb7b3fadc3_flash_display_Sprite extends Sprite
   {
       
      
      public function _82f814c8cdd31fc07d63de53746e29c582dde1891645df00635b01cb7b3fadc3_flash_display_Sprite()
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
