package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d9e549471c9c91baa9b4dea33632bddb1ac7db20bc6b0edbbbfd172f54dc0989_flash_display_Sprite extends Sprite
   {
       
      
      public function _d9e549471c9c91baa9b4dea33632bddb1ac7db20bc6b0edbbbfd172f54dc0989_flash_display_Sprite()
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
