package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d33e2f40cd3f7e07b58e844a9c6f6455575d4f9e89a48c62dce10a8feeb08531_flash_display_Sprite extends Sprite
   {
       
      
      public function _d33e2f40cd3f7e07b58e844a9c6f6455575d4f9e89a48c62dce10a8feeb08531_flash_display_Sprite()
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
