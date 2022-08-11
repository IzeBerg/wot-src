package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a26313bea529a97cabca85d9ab8d21edd6eb53f2498bec2b3477a147680c6e5c_flash_display_Sprite extends Sprite
   {
       
      
      public function _a26313bea529a97cabca85d9ab8d21edd6eb53f2498bec2b3477a147680c6e5c_flash_display_Sprite()
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
