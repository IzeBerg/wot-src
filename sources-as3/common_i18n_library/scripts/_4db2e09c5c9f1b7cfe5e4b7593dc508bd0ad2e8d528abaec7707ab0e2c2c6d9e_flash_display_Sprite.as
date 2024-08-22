package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _4db2e09c5c9f1b7cfe5e4b7593dc508bd0ad2e8d528abaec7707ab0e2c2c6d9e_flash_display_Sprite extends Sprite
   {
       
      
      public function _4db2e09c5c9f1b7cfe5e4b7593dc508bd0ad2e8d528abaec7707ab0e2c2c6d9e_flash_display_Sprite()
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
