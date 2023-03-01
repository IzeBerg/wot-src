package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a20d93ab806d217bc0fe303fd79a44f1f546ef27b4b57d2fcf7ba50b98a4b2db_flash_display_Sprite extends Sprite
   {
       
      
      public function _a20d93ab806d217bc0fe303fd79a44f1f546ef27b4b57d2fcf7ba50b98a4b2db_flash_display_Sprite()
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
