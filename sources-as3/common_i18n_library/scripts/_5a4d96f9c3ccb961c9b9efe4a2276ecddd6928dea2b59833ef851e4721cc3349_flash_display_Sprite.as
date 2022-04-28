package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _5a4d96f9c3ccb961c9b9efe4a2276ecddd6928dea2b59833ef851e4721cc3349_flash_display_Sprite extends Sprite
   {
       
      
      public function _5a4d96f9c3ccb961c9b9efe4a2276ecddd6928dea2b59833ef851e4721cc3349_flash_display_Sprite()
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
