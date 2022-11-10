package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9d3c37a576691431b4fe7d8c891d1c7f3f77e9957970405aec8541e36b32ea5c_flash_display_Sprite extends Sprite
   {
       
      
      public function _9d3c37a576691431b4fe7d8c891d1c7f3f77e9957970405aec8541e36b32ea5c_flash_display_Sprite()
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
