package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _31049c0b775997bec911ae7b9f55f2c743cd115439eed0fca8d4d35b8c26e76c_flash_display_Sprite extends Sprite
   {
       
      
      public function _31049c0b775997bec911ae7b9f55f2c743cd115439eed0fca8d4d35b8c26e76c_flash_display_Sprite()
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
