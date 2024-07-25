package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _98301a479650ccbb8acffe30c089d718bf1d123f0ca1312d94d172b7282b93d0_flash_display_Sprite extends Sprite
   {
       
      
      public function _98301a479650ccbb8acffe30c089d718bf1d123f0ca1312d94d172b7282b93d0_flash_display_Sprite()
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
