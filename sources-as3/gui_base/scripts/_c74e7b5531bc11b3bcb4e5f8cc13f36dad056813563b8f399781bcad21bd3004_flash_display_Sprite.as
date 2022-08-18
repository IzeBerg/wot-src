package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c74e7b5531bc11b3bcb4e5f8cc13f36dad056813563b8f399781bcad21bd3004_flash_display_Sprite extends Sprite
   {
       
      
      public function _c74e7b5531bc11b3bcb4e5f8cc13f36dad056813563b8f399781bcad21bd3004_flash_display_Sprite()
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
